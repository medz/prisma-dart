import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'error.dart';
import 'snapshot.dart';

const _defaultOutputPath = 'lib/orm_client.g.dart';

GeneratorConfigSnapshot loadGeneratorConfig({
  required Directory cwd,
  String? configPath,
  String? schemaOverridePath,
  String? outputOverridePath,
}) {
  final configFile = _resolveConfigFile(cwd: cwd, configPath: configPath);
  if (!configFile.existsSync()) {
    final configOverride = _readOverridePath(
      configPath,
      optionName: '--config',
    );
    throw GeneratorException(
      configOverride == null
          ? 'Cannot find orm.config.dart in current working directory.'
          : 'Cannot find config file.',
      path: configFile.path,
      hint: configOverride == null
          ? 'Create orm.config.dart with a top-level config declaration.'
          : 'Check the --config path and ensure it points to a Dart file.',
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
      'Config file contains invalid Dart syntax.',
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
  final output =
      _readOverridePath(outputOverridePath, optionName: '--output') ??
      _readStringArg(
        namedArguments,
        key: 'output',
        file: configFile,
        defaultValue: _defaultOutputPath,
      );
  final schema =
      _readOverridePath(schemaOverridePath, optionName: '--schema') ??
      _readNullableStringArg(namedArguments, key: 'schema', file: configFile);
  final provider = _readProviderArg(namedArguments, file: configFile);

  return GeneratorConfigSnapshot(
    configFile: configFile,
    provider: provider,
    outputPath: output,
    schemaPath: schema,
  );
}

File _resolveConfigFile({required Directory cwd, required String? configPath}) {
  final configuredPath = _readOverridePath(configPath, optionName: '--config');
  if (configuredPath == null) {
    return File(_join(cwd.path, 'orm.config.dart'));
  }

  final configuredFile = File(configuredPath);
  if (configuredFile.isAbsolute) {
    return configuredFile;
  }

  return File(_join(cwd.path, configuredPath));
}

String? _readOverridePath(String? value, {required String optionName}) {
  if (value == null) {
    return null;
  }

  final normalized = value.trim();
  if (normalized.isEmpty) {
    throw GeneratorException(
      'Generate option $optionName requires a non-empty path.',
      hint: 'Pass a non-empty file path to $optionName.',
    );
  }

  return normalized;
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

String? _readProviderArg(
  Map<String, Expression> namedArguments, {
  required File file,
}) {
  final expression = namedArguments['provider'];
  if (expression == null || expression is NullLiteral) {
    return null;
  }

  final identifier = _readProviderIdentifier(expression);
  final literal = _readSimpleStringLiteral(expression);
  final value = identifier ?? literal;
  if (value == null || value.trim().isEmpty) {
    throw GeneratorException(
      'Config.provider must be an enum value or string literal.',
      path: file.path,
      hint: "Example: provider: DatabaseProvider.sqlite or provider: 'sqlite'",
    );
  }

  return _normalizeProvider(value);
}

String? _readProviderIdentifier(Expression expression) {
  if (expression is SimpleIdentifier) {
    return expression.name;
  }

  if (expression is PrefixedIdentifier) {
    return expression.identifier.name;
  }

  if (expression is PropertyAccess) {
    if (_isSimpleNameChain(expression.target)) {
      return expression.propertyName.name;
    }
  }

  return null;
}

bool _isSimpleNameChain(Expression? expression) {
  if (expression == null) {
    return true;
  }

  if (expression is SimpleIdentifier || expression is PrefixedIdentifier) {
    return true;
  }

  if (expression is PropertyAccess) {
    return _isSimpleNameChain(expression.target);
  }

  return false;
}

String _normalizeProvider(String provider) {
  final normalized = provider.trim();
  final marker = normalized.contains('.')
      ? normalized.split('.').last
      : normalized;
  return marker.toLowerCase();
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
