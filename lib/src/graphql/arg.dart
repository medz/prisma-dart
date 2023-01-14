import 'dart:convert';

import '../runtime/json_serializable.dart';
import '../runtime/prisma_null.dart';

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
    Object? result = _objectBuilder(value);

    // If result is null return null.
    if (result == null) return null;

    // If result.zero is PrismaNull, return built SDL.
    if (result is PrismaNull) return '$key: null';

    final String? sdl = _sdlBuilder(result);
    if (sdl == null) return null;

    return '$key: $sdl';
  }

  /// SDL builder.
  String? _sdlBuilder(dynamic value) {
    if (value == null) return null;

    // If result is a Feeezed union, return value;
    if (value is Map && value.containsKey('runtimeType')) {
      return _sdlBuilder(value['value']);
    }

    // If value is a [DateTime] return timestamp.
    if (value is DateTime) {
      return _sdlBuilder(value.isUtc
          ? value.toIso8601String()
          : value.toUtc().toIso8601String());
    }

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

    return value.toString();
  }

  /// Recursively build GraphQL SDL.
  Object? _objectBuilder(dynamic value) {
    // If value is feezed union, return value.
    if (value is Map && value.containsKey('runtimeType')) {
      return _objectBuilder(value['value']);
    }

    // If value is PrismaNull, return it.
    if (value is PrismaNull) return value;

    /// If value is list, return Prisma union with list of values.
    if (value is List) return _listBuilder(value);

    /// If value is map, return Prisma union with map of values.
    if (value is Map) return _mapBuilder(value);

    /// If value is json serializable.
    if (value is JsonSerializable) return _objectBuilder(value.toJson());

    // Default return Prisma union with value.
    return value;
  }

  /// Map builder.
  Map<String, dynamic> _mapBuilder(Map map) {
    return map.map((key, value) => MapEntry(key, _objectBuilder(value)))
      ..removeWhere((key, value) => value == null);
  }

  /// List build.
  List<dynamic> _listBuilder(List<dynamic> list) {
    return list.map((value) => _objectBuilder(value)).toList();
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
