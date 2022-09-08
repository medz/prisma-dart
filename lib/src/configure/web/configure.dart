import 'package:rc/rc.dart';

import '../environment.dart';

/// Create a [RuntimeConfiguration].
final _prismarc = RuntimeConfiguration(contents: r'');

/// Create a new [Environment] from [RuntimeConfiguration].
final Environment environment = Environment(_prismarc);
