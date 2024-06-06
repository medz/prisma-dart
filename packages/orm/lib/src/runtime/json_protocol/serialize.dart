import 'dart:convert';
import 'dart:collection';
import 'dart:typed_data';

import '../../../../dmmf.dart' as dmmf;
import '../../errors.dart';
import '../json_convertible.dart';
import '../prisma_enum.dart';
import '../prisma_json.dart';
import '../prisma_null.dart';
import '../decimal.dart';
import '../reference.dart';
import 'protocol.dart';

extension ModelActionToJsonQueryAction on dmmf.ModelAction {
  JsonQueryAction toJsonQueryAction() {
    return switch (this) {
      dmmf.ModelAction.findFirst => JsonQueryAction.findFirst,
      dmmf.ModelAction.findFirstOrThrow => JsonQueryAction.findFirstOrThrow,
      dmmf.ModelAction.findUnique => JsonQueryAction.findUnique,
      dmmf.ModelAction.findUniqueOrThrow => JsonQueryAction.findUniqueOrThrow,
      dmmf.ModelAction.findMany => JsonQueryAction.findMany,
      dmmf.ModelAction.create => JsonQueryAction.createOne,
      dmmf.ModelAction.createMany => JsonQueryAction.createMany,
      dmmf.ModelAction.createManyAndReturn =>
        JsonQueryAction.createManyAndReturn,
      dmmf.ModelAction.update => JsonQueryAction.updateOne,
      dmmf.ModelAction.updateMany => JsonQueryAction.updateMany,
      dmmf.ModelAction.delete => JsonQueryAction.deleteOne,
      dmmf.ModelAction.deleteMany => JsonQueryAction.deleteMany,
      dmmf.ModelAction.upsert => JsonQueryAction.upsertOne,
      dmmf.ModelAction.aggregate => JsonQueryAction.aggregate,
      dmmf.ModelAction.groupBy => JsonQueryAction.groupBy,
      dmmf.ModelAction.findRaw => JsonQueryAction.findRaw,
      dmmf.ModelAction.count => JsonQueryAction.aggregate,
      dmmf.ModelAction.aggregateRaw => JsonQueryAction.aggregateRaw,
    };
  }
}

extension on JsonQueryAction {
  String toApiFunctionName() {
    if (name.endsWith('One')) return name.substring(0, name.length - 3);

    return name;
  }
}

extension<K, V> on Map<K, V> {
  Map<K, V> withoutKeys(Iterable<K> keys) =>
      Map.from(this)..removeWhere((k, _) => keys.contains(k));

  Map<K, V> withoutNulls() => Map.from(this)..removeWhere((_, v) => v == null);
}

class _Context {
  final dmmf.DataModel datamodel;
  final String? modelName;
  final JsonQueryAction action;
  final Iterable<String> arguments;
  final Iterable<String> selections;

  const _Context({
    required this.datamodel,
    required this.action,
    this.modelName,
    this.arguments = const [],
    this.selections = const [],
  });

  _Context nestArgument(String argument) {
    return _Context(
      datamodel: datamodel,
      modelName: modelName,
      action: action,
      arguments: [...arguments, argument],
      selections: selections,
    );
  }

  _Context nestSelection(String selection) {
    return _Context(
      datamodel: datamodel,
      modelName: modelName,
      action: action,
      arguments: arguments,
      selections: [...selections, selection],
    );
  }

  Never throwValidationError(String message) {
    throw PrismaClientValidationError(message: message);
  }

  dmmf.Model? get model => datamodel.models
      .where((element) => element.name == modelName)
      .firstOrNull;

  dmmf.Field? findField(String name) {
    return model?.fields.where((element) => element.name == name).firstOrNull;
  }

  bool isRawAction() => const <JsonQueryAction>[
        JsonQueryAction.executeRaw,
        JsonQueryAction.findRaw,
        JsonQueryAction.aggregateRaw,
        JsonQueryAction.queryRaw,
        JsonQueryAction.runCommandRaw,
      ].contains(action);
}

JsonQuery serializeJsonQuery({
  required dmmf.DataModel datamodel,
  required JsonQueryAction action,
  String? modelName,
  Map? args,
}) {
  final context = _Context(
    datamodel: datamodel,
    modelName: modelName,
    action: action,
  );

  return JsonQuery(
    action: action,
    modelName: modelName,
    query: _serializeFieldSelection(context, args ?? const {}),
  );
}

Map<String, dynamic> _serializeFieldSelection(_Context context,
    [Map args = const {}]) {
  final Map<String, dynamic> select =
      switch (JsonConvertible.serialize(args['select'])) {
    Map select => select.cast(),
    _ => const <String, dynamic>{},
  };
  final Map<String, dynamic> include =
      switch (JsonConvertible.serialize(args['include'])) {
    Map include => include.cast(),
    _ => const <String, dynamic>{},
  };

  final arguments = _serializeArgumentsObject(
      context, args.withoutKeys(['select', 'include']));
  final selection = _serializeSelection(context, select, include);

  return {
    'arguments': _nullsSerialize(arguments),
    'selection': _nullsSerialize(selection),
  };
}

Map<String, dynamic> _serializeSelection(_Context context,
    Map<String, dynamic> select, Map<String, dynamic> include) {
  if (select.isNotEmpty && include.isNotEmpty) {
    throw context.throwValidationError(
      'Can not use `select` and `include` at the same time',
    );
  }

  return select.isNotEmpty
      ? _createExplicitSelection(context, select)
      : _createImplicitSelection(context, include);
}

Map<String, dynamic> _createImplicitSelection(
    _Context context, Map<String, dynamic> include) {
  final fill = context.model != null && !context.isRawAction();
  final result = <String, dynamic>{
    if (fill) r'$composites': true,
    if (fill) r'$scalars': true,
  };

  return {
    ...result,
    ..._createIncludeRelations(context, include),
  };
}

Map<String, dynamic> _createIncludeRelations(
    _Context context, Map<String, dynamic> include) {
  final result = include.map((key, value) {
    final field = context.findField(key);
    if (field != null && field.kind != dmmf.FieldKind.object) {
      throw context.throwValidationError(
        'Can not include field `$key` because it is not a relation',
      );
    }

    final result = switch (value) {
      true => true,
      Map child => _serializeFieldSelection(context.nestSelection(key), child),
      _ => null,
    };

    return MapEntry(key, result);
  });

  return result.withoutNulls();
}

Map<String, dynamic> _createExplicitSelection(
    _Context context, Map<String, dynamic> select) {
  final result = select.map((key, value) {
    final result = switch (value) {
      true => true,
      Map child => _serializeFieldSelection(context.nestSelection(key), child),
      _ => null,
    };

    return MapEntry(key, result);
  });

  return result.withoutNulls();
}

Map<String, dynamic> _serializeArgumentsObject(_Context context, Map args) {
  if (args.containsKey(r'$type')) {
    return {r'$type': 'Raw', 'value': args};
  }

  return args.withoutNulls().map((key, value) {
    return MapEntry(key,
        _serializeArgumentValue(context.nestArgument(key.toString()), value));
  });
}

Map<String, dynamic> _createTypedValue(String type, dynamic value) => {
      r'$type': type,
      r'value': value,
    };

dynamic _serializeArgumentValue(_Context context, dynamic value) {
  return switch (value) {
    String() || int() || double() || num() || bool() => value,
    PrismaNull() => value,
    BigInt value => _createTypedValue('BigInt', value.toString()),
    DateTime value =>
      _createTypedValue('DateTime', value.toUtc().toIso8601String()),
    Uint8List bytes => _createTypedValue('Bytes', base64.encode(bytes)),
    ByteBuffer bytes => _serializeArgumentValue(context, bytes.asUint8List()),
    TypedData bytes => _serializeArgumentValue(context, bytes.buffer),
    Reference ref => _createTypedValue(
        'FieldRef', {'_container': ref.model, '_ref': ref.name}),
    Decimal value => _createTypedValue('Decimal', value.toString()),
    PrismaEnum value => _createTypedValue('Enum', value.name),
    PrismaJson(value: final value) =>
      _createTypedValue('Json', json.encode(value)),
    Enum value => _createTypedValue('Enum', value.name),
    JsonConvertible value => _serializeArgumentValue(context, value.toJson()),
    Iterable value => _serializeIterable(context, value).toList(),
    Map value => _serializeArgumentsObject(context, value),
    _ =>
      context.throwValidationError('Argument value `$value` is not supported'),
  };
}

Iterable _serializeIterable(_Context context, Iterable iterable) {
  return iterable.indexed.map((element) {
    final elementContext = context.nestArgument(element.$1.toString());
    if (element.$2 == null) {
      throw context.throwValidationError(
          'Can not serialize iterable with null value, If you want to serialize null value, use `PrismaNull` instead');
    }

    return _serializeArgumentValue(elementContext, element.$2);
  });
}

_nullsSerialize<T>(T value) {
  return switch (value) {
    Iterable value => value.map((e) => _nullsSerialize(e)).toList(),
    Map value => value.map((k, v) => MapEntry(k, _nullsSerialize(v))),
    PrismaNull _ => null,
    _ => value,
  };
}
