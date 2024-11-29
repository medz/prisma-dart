import 'dart:ffi';
import 'dart:io';

import '_generate_bindings.dart';

DynamicLibrary get _dl {
  if (Platform.isIOS) {
    // Try open SPM generated library.
    try {
      return DynamicLibrary.open('orm-flutter-ios.framework/orm-flutter-ios');

      // Fallback open podspec defined library.
    } catch (_) {
      return DynamicLibrary.open('orm_flutter_ios.framework/orm_flutter_ios');
    }
  } else if (Platform.isAndroid) {
    return DynamicLibrary.open("liborm_flutter_android.so");
  }

  throw UnsupportedError('Susupported platform: ${Platform.operatingSystem}');
}

final bindings = QueryEngineBindings(_dl);
