import 'package:code_builder/code_builder.dart';

final Reference ormVersion = refer('version', 'package:orm/version.dart');

Reference ormCoreRefer(String symbol) => refer(symbol, 'package:orm/orm.dart');
