import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'error.dart';
import 'snapshot.dart';

const _defaultOutputPath = 'lib/orm_client.g.dart';

GeneratorConfigSnapshot loadGeneratorConfig({required Directory cwd}) {
  final configFile = File(_join(cwd.path, 'orm.config.dart'));
  if (!configFile.existsSync()) {
    throw GeneratorException(
      'Cannot find orm.config.dart in current working directory.',
      path: configFile.path,
      hint: 'Create orm.config.dart with a top-level config declaration.',
    );
  }

  final source = configFile.readAsStringSync();
  final parsed = parseString(
    content: source,
    path: configFile.path,
    throwIfDiagnostics: false,
  );

  if (parsed.errors.isNotEmpty) {
    final diagnostic = parsed.errors.first;
    final location = parsed.lineInfo.getLocation(diagnostic.offset);
    throw GeneratorException(
      'orm.config.dart contains invalid Dart syntax.',
      path: configFile.path,
      line: location.lineNumber,
      column: location.columnNumber,
      hint: diagnostic.message,
    );
  }

  final configArguments = _findConfigArguments(
    parsed.unit,
    configFilePath: configFile.path,
  );
  if (configArguments == null) {
    throw GeneratorException(
      'Missing top-level config declaration.',
      path: configFile.path,
      hint: "Define: const config = Config(provider: ..., output: '...');",
    );
  }

  final namedArguments = _readNamedArguments(configArguments);
  final output = _readStringArg(
    namedArguments,
    key: 'output',
    file: configFile,
    defaultValue: _defaultOutputPath,
  );
  final schema = _readNullableStringArg(
    namedArguments,
    key: 'schema',
    file: configFile,
  );

  return GeneratorConfigSnapshot(
    configFile: configFile,
    outputPath: output,
    schemaPath: schema,
  );
}

ArgumentList? _findConfigArguments(
  CompilationUnit unit, {
  required String configFilePath,
}) {
  for (final declaration in unit.declarations) {
    if (declaration is! TopLevelVariableDeclaration) {
      continue;
    }

    for (final variable in declaration.variables.variables) {
      if (variable.name.lexeme != 'config') {
        continue;
      }

      final initializer = variable.initializer;
      if (initializer == null) {
        throw GeneratorException(
          'Top-level config must initialize Config(...).',
          path: configFilePath,
          hint: "Use: const config = Config(provider: ..., output: '...');",
        );
      }

      if (initializer is InstanceCreationExpression) {
        final typeName = initializer.constructorName.type.name.lexeme;
        if (typeName != 'Config') {
          throw GeneratorException(
            'Top-level config must be an instance of Config.',
            path: configFilePath,
            hint: 'Update config initializer to Config(...).',
          );
        }
        return initializer.argumentList;
      }

      if (initializer is MethodInvocation &&
          initializer.methodName.name == 'Config') {
        return initializer.argumentList;
      }

      throw GeneratorException(
        'Top-level config must initialize Config(...).',
        path: configFilePath,
        hint: "Use: const config = Config(provider: ..., output: '...');",
      );
    }
  }

  return null;
}

Map<String, Expression> _readNamedArguments(ArgumentList argumentList) {
  final named = <String, Expression>{};
  for (final argument in argumentList.arguments) {
    if (argument is! NamedExpression) {
      continue;
    }

    final key = argument.name.label.name;
    named[key] = argument.expression;
  }
  return named;
}

String _readStringArg(
  Map<String, Expression> namedArguments, {
  required String key,
  required File file,
  required String defaultValue,
}) {
  final expression = namedArguments[key];
  if (expression == null) {
    return defaultValue;
  }

  final value = _readSimpleStringLiteral(expression);
  if (value == null) {
    throw GeneratorException(
      'Config.$key must be a string literal.',
      path: file.path,
      hint: "Example: $key: 'path/to/file.dart'",
    );
  }

  if (value.trim().isEmpty) {
    return defaultValue;
  }

  return value;
}

String? _readNullableStringArg(
  Map<String, Expression> namedArguments, {
  required String key,
  required File file,
}) {
  if (!namedArguments.containsKey(key)) {
    return null;
  }

  final expression = namedArguments[key]!;
  if (expression is NullLiteral) {
    return null;
  }

  final value = _readSimpleStringLiteral(expression);
  if (value == null || value.trim().isEmpty) {
    throw GeneratorException(
      'Config.$key must be null or a non-empty string literal.',
      path: file.path,
      hint: "Example: $key: 'orm.schema.dart'",
    );
  }

  return value;
}

String? _readSimpleStringLiteral(Expression expression) {
  if (expression is SimpleStringLiteral) {
    return expression.value;
  }
  return null;
}

String _join(String base, String child) {
  if (base.endsWith(Platform.pathSeparator)) {
    return '$base$child';
  }
  return '$base${Platform.pathSeparator}$child';
}
