import 'package:io/ansi.dart';

/// ORM executable name.
const String executableName = r'prisma';

/// ORM executable name with color.
String get executableNameWithColor => green.wrap(executableName)!;
