import 'dart:async';
import 'dart:convert' as convert;
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

import 'generated_bindings.dart';

class Engine {
  final Pointer<Int> _ref;
  final NativeLibrary _library;

  const Engine._(this._ref, this._library);

  factory Engine() {
    final dl = DynamicLibrary.open('../../target/debug/libengine_ffi.dylib');
    final library = NativeLibrary(dl);
    Pointer<Int> ref = nullptr;

    final options = convert.json.encode({
      'datamodel': File('../../prisma/schema.prisma').readAsStringSync(),
      'logLevel': 'info',
      'logQueries': true,
      'configDir': Directory.current.path,
      'env': Platform.environment,
    });

    void log(DartString ptr) {
      print(ptr.cast<Utf8>().toDartString());
    }

    final NativeCallable<StringCallbackFunction> callback =
        NativeCallable.isolateLocal(log);

    void createdFn(Pointer<Int> ptr) {
      print('created');
      ref = ptr;
    }

    final NativeCallable<QueryEngineNewCallbackFunction> created =
        NativeCallable.isolateLocal(createdFn);

    void errorFn() {
      print('error');
    }

    final NativeCallable<VoidCallbackFunction> error =
        NativeCallable.isolateLocal(errorFn);

    library.query_engine_new(
      options.toNativeUtf8().cast(),
      callback.nativeFunction,
      created.nativeFunction,
      error.nativeFunction,
    );

    return Engine._(ref, library);
  }

  // Connect
  Future<void> connect() async {
    final completer = Completer<void>();

    void callback() {
      print('connected');
      completer.complete();
    }

    final NativeCallable<VoidCallbackFunction> connected =
        NativeCallable.isolateLocal(callback);

    void errorFn() {
      print('error');
    }

    final NativeCallable<VoidCallbackFunction> error =
        NativeCallable.isolateLocal(errorFn);

    _library.query_engine_connect(
      _ref,
      connected.nativeFunction,
      error.nativeFunction,
      'trace'.toNativeUtf8().cast(),
    );

    await completer.future;

    connected.close();
    error.close();
  }
}

void main() async {
  final engine = Engine();

  // Connect
  await engine.connect();
}
