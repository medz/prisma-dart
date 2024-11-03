import 'dart:ffi';
import 'dart:io';

import '_generate_bindings.dart';

DynamicLibrary get _dl {
  if (Platform.isIOS) {
    return DynamicLibrary.open(
        'orm_flutter_ios.framework/query_engine_bridge/bridge');
  }

  throw UnsupportedError('Susupported platform: ${Platform.operatingSystem}');
}

final bindings = QueryEngineBindings(_dl);
