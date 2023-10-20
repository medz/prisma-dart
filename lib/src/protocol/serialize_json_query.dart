import 'dart:convert';

import '../dmmf.dart' as dmmf;
import '../engines/common/errors/engine_validation_error.dart';
import '../runtime/error_format.dart';
import '../runtime/errors/validation_error.dart';
import '../runtime/field_ref.dart';
import '../runtime/prisma_null.dart';
import 'model_action.dart';
import 'serialize_context.dart';

Map serializeJsonQuery({
  final String? modelName,
  required final ModelAction action,
  final Map? args,
  required final dmmf.Datamodel datamodel,
  required final String clientMethod,
  required final String clientVersion,
  required final ErrorFormat errorFormat,
}) {
  final context = SerializeContext(
    datamodel: datamodel,
    modelName: modelName,
    rootArgs: args,
    action: action,
    originalMethod: clientMethod,
    errorFormat: errorFormat,
    clientVersion: clientVersion,
    selectionPath: const [],
    argumentPath: const [],
  );

  return <String, dynamic>{
    if (modelName != null) 'modelName': modelName,
    'action': action.value,
    'query': serializeFieldSelection(args ?? const {}, context),
  };
}

Map<String, dynamic> serializeFieldSelection(
  final Map args,
  final SerializeContext context,
) {
  final Map<String, dynamic>? select = switch (args['select']) {
    Map select => select.cast(),
    _ => null,
  };
  final Map<String, dynamic>? include = switch (args['include']) {
    Map include => include.cast(),
    _ => null,
  };

  final argsWithoutSelectAndInclude = Map<String, dynamic>.from(args)
    ..remove('select')
    ..remove('include');

  return {
    'arguments': serializeArgumentsObject(argsWithoutSelectAndInclude, context),
    'selection':
        serializeSelectionSet(context, select: select, include: include),
  };
}

Map<String, dynamic> serializeSelectionSet(
  final SerializeContext context, {
  final Map<String, dynamic>? select,
  final Map<String, dynamic>? include,
}) {
  if (select != null && include != null) {
    throw context.throwValidationError(
      IncludeAndSelectError(
        selectionPath: context.selectionPath.toList(),
      ),
    );
  }

  return select != null
      ? createExplicitSelection(select, context)
      : createImplicitSelection(context, include);
}

Map<String, dynamic> createImplicitSelection(
  final SerializeContext context, [
  final Map<String, dynamic>? include,
]) {
  final result = <String, dynamic>{};

  if (context.model != null && !context.isRawAction()) {
    result[r'$composites'] = true;
    result[r'$scalars'] = true;
  }

  if (include != null) {
    addIncludedRelations(result, include, context);
  }

  return result;
}

void addIncludedRelations(
    Map selection, final Map include, final SerializeContext context) {
  for (final MapEntry(key: key, value: value) in include.entries) {
    final field = context.findField(key);
    if (field != null && field.kind != dmmf.FieldKind.object) {
      throw context.throwValidationError(IncludeOnScalarError(
        selectionPath: context.selectionPath.toList(),
        outputType: context.getOutputTypeDescription(),
      ));
    }

    final resolved = switch (value) {
      true => true,
      Map args => serializeFieldSelection(args, context.nestSelection(key)),
      _ => null,
    };

    if (resolved != null) {
      selection[key] = resolved;
    }
  }
}

Map<String, dynamic> createExplicitSelection(
    final Map<String, dynamic> select, final SerializeContext context) {
  final result = <String, dynamic>{};

  for (final MapEntry(key: key, value: value) in select.entries) {
    final field = context.findField(key);
    if (field == null) continue;

    final resolved = switch (value) {
      true => true,
      Map args => serializeFieldSelection(args, context.nestSelection(key)),
      _ => null,
    };

    if (resolved != null) {
      result[key] = resolved;
    }
  }

  return result;
}

Map<String, dynamic> serializeArgumentsObject(
    final Map args, SerializeContext context) {
  if (args.containsKey(r'$type')) {
    return {r'$type': 'Json', 'value': json.encode(args)};
  }

  final result = <String, dynamic>{};
  for (final MapEntry(key: key, value: value) in args.entries) {
    if (value == null) continue;

    result[key] = serializeArgumentsValue(value, context.nestArgument(key));
  }

  return result;
}

dynamic serializeArgumentsValue(dynamic value, SerializeContext context) {
  return switch (value) {
    PrismaNull _ => null,
    int integer => integer,
    String string => string,
    bool boolean => boolean,
    BigInt(toString: final serialize) => {
        r'$type': 'BigInt',
        'value': serialize(),
      },
    FieldRef(name: final name, modelName: final modelName) => {
        r'$type': 'FieldRef',
        'value': {
          '_ref': name,
          '_container': modelName,
        },
      },
    Iterable iterable => serializeArgumentsArray(iterable, context),
    _ => throw context.throwValidationError(InvalidArgumentValueError(
        selectionPath: context.getSelectionPath(),
        argumentPath: context.getArgumentPath(),
        argument: ArgumentDescription(
          name: context.getArgumentName() ?? '',
          typeNames: const [],
        ),
        underlyingError:
            'Unsupported argument value type: ${value.runtimeType}',
      ))
  };
}

Iterable serializeArgumentsArray(
    Iterable iterable, SerializeContext context) sync* {
  for (int key = 0; key < iterable.length; key++) {
    final itemContext = context.nestArgument(key.toString());
    final value = iterable.elementAt(key);

    if (value == null) {
      throw context.throwValidationError(InvalidArgumentValueError(
        selectionPath: itemContext.getSelectionPath(),
        argumentPath: itemContext.getArgumentPath(),
        argument: ArgumentDescription(
          name: '${context.getArgumentName()}[$key]',
          typeNames: const [],
        ),
        underlyingError:
            'Can not use `null` value within iterable, Use [PrismaNull] instead or filter out `null` values.',
      ));
    }

    yield serializeArgumentsValue(value, itemContext);
  }
}
