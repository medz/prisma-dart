export 'src/system_environment_empty.dart'
    if (dart.library.io) 'src/system_environment_io.dart';

export 'src/print2console.dart'
    if (dart.library.io) 'src/print2console_io.dart';
