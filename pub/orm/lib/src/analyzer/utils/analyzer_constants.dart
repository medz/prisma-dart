const String ormConfigFileName = 'orm.config.dart';
const String ormConfigImportUri = 'package:orm/config.dart';
const String configClassName = 'Config';
const String configVariableName = 'config';

const String configRequiredRuleName = 'orm_config_required';

const String configFixSnippet =
    'const $configVariableName = $configClassName(...)';
const String configFixMessageDefine = 'Define ORM config: $configFixSnippet';
const String configFixMessageReplace =
    'Replace ORM config: $configFixSnippet';

const String configFixIdRequired = 'orm.fix.config_required';
const String configFixIdRequiredReplace = 'orm.fix.config_required_replace';
