import 'dart:convert';

import '../runtime/json_serializable.dart';
import '../runtime/prisma_null.dart';
import '../runtime/prisma_union.dart';

/// GraphQL variable SDL builder.
///
/// Example:
/// ```dart
/// final veriable = GraphQLArg('id', 1, isRequired: true);
///
/// print(veriable); // id: 1
/// ```
class GraphQLArg {
  /// Veriable name
  final String key;

  /// Veriable value
  final dynamic value;

  /// Veriable is required
  final bool isRequired;

  const GraphQLArg(this.key, this.value, {this.isRequired = false})
      : assert(!isRequired || value != null,
            '"$key" must be required and not null');

  @override
  String toString() => toSdl() ?? super.toString();

  /// Built GraphQL SDL.
  String? toSdl() {
    final PrismaUnion<PrismaNull, dynamic>? result = _objectBuilder(value);

    // If result is null return null.
    if (result == null) return null;

    // If result.zero is PrismaNull, return built SDL.
    if (result.zero is PrismaNull) return '$key: null';

    final String? sdl = _sdlBuilder(result.one);
    if (sdl == null) return null;

    return '$key: $sdl';
  }

  /// SDL builder.
  String? _sdlBuilder(dynamic value) {
    if (value == null) return null;

    // If value is null, return null.
    if (value is PrismaNull) return 'null';

    // If value is String
    if (value is String) return json.encode(value);

    // If value is Enum, return, return enum name.
    if (value is Enum) return value.name;

    // If value is List, return list.
    if (value is List) {
      final List<String> list = [];
      for (final dynamic item in value) {
        final String? result = _sdlBuilder(item);
        if (result != null) {
          list.add(result);
        }
      }
      return '[${list.join(', ')}]';
    }

    // If value is Map, return map.
    if (value is Map) {
      final List<String> list = [];
      for (final String key in value.keys) {
        list.add('${key.toString()}: ${_sdlBuilder(value[key])}');
      }
      return '{${list.join(', ')}}';
    }

    /// If value is PrismaUnion, return union.
    if (value is PrismaUnion) {
      return _sdlPrismaUnionBuilder(value);
    }

    return value.toString();
  }

  /// SDL builder for PrismaUnion.
  String _sdlPrismaUnionBuilder(PrismaUnion union) {
    final String? zore = _sdlBuilder(union.zero);
    final String? one = _sdlBuilder(union.one);

    return (zore ?? one)!;
  }

  /// Recursively build GraphQL SDL.
  PrismaUnion<PrismaNull, dynamic>? _objectBuilder(dynamic value) {
    // If value is null, return null.
    if (value == null) return null;

    // If value is enum, return Prisma union with enum name.
    if (value is Enum) return PrismaUnion.one(value);

    /// If value is list, return Prisma union with list of values.
    if (value is List) return PrismaUnion.one(_listBuilder(value));

    /// If value is map, return Prisma union with map of values.
    if (value is Map) return PrismaUnion.one(_mapBuilder(value));

    /// If value is json serializable.
    if (value is JsonSerializable) return _objectBuilder(value.toJson());

    // If value is Prisma null, return Prisma union with Prisma null.
    if (value is PrismaNull) return PrismaUnion.zero(value);

    // If value is Prisma union, return Prisma union with Prisma union.
    if (value is PrismaUnion) return _prismaUnionBuilder(value);

    // Default return Prisma union with value.
    return PrismaUnion.one(value);
  }

  /// Prisma union build.
  PrismaUnion<PrismaNull, dynamic>? _prismaUnionBuilder(PrismaUnion value) {
    final PrismaUnion<PrismaNull, dynamic>? zero = _objectBuilder(value.zero);
    final PrismaUnion<PrismaNull, dynamic>? one = _objectBuilder(value.one);

    // If zero.one is Map
    if (zero?.one is Map) {
      return PrismaUnion.one({
        ...zero?.one as Map,
        ...one?.one is Map ? one?.one : {},
      });
    }

    // If one.one is Map
    if (one?.one is Map) {
      return PrismaUnion.one({
        ...zero?.one is Map ? zero?.one : {},
        ...one?.one as Map,
      });
    }

    // If zero.one is not null, return Prisma union with zero.one.
    if (zero?.one != null) {
      return PrismaUnion.one(zero?.one);
    }

    // If one.one is not null, return Prisma union with one.one.
    if (one?.one != null) {
      return PrismaUnion.one(one?.one);
    }

    return zero ?? one;
  }

  /// Map builder.
  Map<String, dynamic> _mapBuilder(Map map) {
    return map.map((key, value) => MapEntry(key, _objectBuilder(value)))
      ..removeWhere((key, value) => value == null);
  }

  /// List build.
  List<dynamic> _listBuilder(List<dynamic> list) {
    return list.map((value) => _objectBuilder(value)?.one).toList();
  }
}

/// GraphQL args.
class GraphQLArgs {
  final List<GraphQLArg> args;

  const GraphQLArgs(this.args);

  // Serizlize args to SDL.
  String? toSdl() {
    final List<String> list = [];
    for (final GraphQLArg arg in args) {
      final String? sdl = arg.toSdl();
      if (sdl != null) {
        list.add(sdl);
      }
    }
    if (list.isEmpty) return null;

    return '(${list.join(', ')})';
  }

  @override
  String toString() => toSdl() ?? super.toString();
}
