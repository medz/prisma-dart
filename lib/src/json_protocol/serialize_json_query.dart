import 'dart:convert';
import 'dart:typed_data';

import 'package:decimal/decimal.dart';
import 'package:orm/src/prisma_null.dart';

import '../_internal/extension.dart';
import '../json_convertible.dart';
import '_internal/serialize_context.dart';

const Map<String, String> _modelActionRestoration = {
  'count': 'aggregate',
  'create': 'createOne',
  'update': 'updateOne',
  'delete': 'deleteOne',
};

Map<String, dynamic> serializeJsonQuery({
  required Map datamodel,
  String? modelName,
  required String action,
  Map? args,
}) {
  final context = SerializeContext(
    modelName: modelName,
    datamodel: datamodel,
    action: _modelActionRestoration[action] ?? action,
  );

  return {
    if (modelName != null) 'modelName': modelName,
    'action': context.action,
    'query': _serializeFieldSelection(args ?? const {}, context),
  };
}

Map<String, dynamic> _serializeFieldSelection(
    Map args, SerializeContext context) {
  final Map<String, dynamic>? select = switch (args['select']) {
    Map select => select.cast(),
    _ => null,
  };

  final Map<String, dynamic>? include = switch (args['include']) {
    Map include => include.cast(),
    _ => null,
  };

  final argsWithoutSelectAndInclude = Map.from(args)
    ..remove('select')
    ..remove('include');

  return {
    'arguments':
        _serializeArgumentsObject(argsWithoutSelectAndInclude, context),
    'selection': _serializeSelectionSet(select, include, context),
  };
}

Map _serializeSelectionSet(Map<String, dynamic>? select,
    Map<String, dynamic>? include, SerializeContext context) {
  if (select != null && include != null) {
    throw context.throwValidationError(
        'Can not use `select` and `include` at the same time');
  }

  return select != null
      ? _createExplicitSelection(select, context)
      : _createImplicitSelection(include, context);
}

Map<String, dynamic> _createImplicitSelection(
    Map<String, dynamic>? include, SerializeContext context) {
  final fill = context.model != null && !context.isRawAction();
  final base = {
    if (fill) r'$composites': true,
    if (fill) r'$scalars': 'true',
  };
  if (include == null) base;

  return {
    ...base,
    ..._createIncludeSelection(include!, context),
  };
}

Map<String, dynamic> _createIncludeSelection(
    Map<String, dynamic> include, SerializeContext context) {
  return include.map((key, value) {
    final field = context.findField(key);
    if (field?['kind'] != 'object') {
      throw context.throwValidationError(
          'Can not include field `$key` because it is not an object');
    }

    final resolved = switch (value) {
      Map value => _serializeFieldSelection(value, context.nestSelection(key)),
      true => true,
      _ => null,
    };

    return MapEntry(key, resolved);
  }).withoutNulls;
}

Map<String, dynamic> _createExplicitSelection(
    Map<String, dynamic> select, SerializeContext context) {
  return select.map((key, value) {
    final resolved = switch (value) {
      Map value => _serializeFieldSelection(value, context.nestSelection(key)),
      true => true,
      _ => null,
    };

    return MapEntry(key, resolved);
  }).withoutNulls;
}

Map<String, String> _createTyped(String type, String value) => {
      r'$type': type,
      r'value': value,
    };

Map _serializeArgumentsObject(Map args, SerializeContext context) {
  if (args.containsKey(r'$type')) {
    return _createTyped('Json', json.encode(args));
  }

  return args.withoutNulls.map((key, value) => MapEntry(
        key,
        _serializeArgumentsValue(value, context.nestArgument(key)),
      ));
}

dynamic _serializeArgumentsValue(value, SerializeContext context) {
  return switch (value) {
    String value => value,
    num value => value,
    bool value => value,
    BigInt value => _createTyped('BigInt', value.toString()),
    DateTime value => _createTyped('DateTime', value.toUtc().toIso8601String()),
    Decimal value => _createTyped('Decimal', value.toString()),
    Int8List value => _createTyped('Bytes', base64.encode(value)),
    JsonConvertible value => _serializeArgumentsValue(value, context),
    Iterable value => _serializeIterable(value, context),
    Map value => _serializeArgumentsObject(value, context),
    PrismaNull() => null,
    _ => throw context.throwValidationError(
        'Can not serialize value of type `${value.runtimeType}`'),
  };
}

Iterable _serializeIterable(Iterable iterable, SerializeContext context) sync* {
  for (final MapEntry(key: key, value: value) in iterable.asMap().entries) {
    final itemContext = context.nestArgument(key.toString());
    if (value == null) {
      throw itemContext.throwValidationError(
          'Can not use `null` value within array. Use `PrismaNull()` or filter out `null` values');
    }

    yield _serializeArgumentsValue(value, itemContext);
  }
}
