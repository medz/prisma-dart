import 'dart:ffi';
import 'package:ffi/ffi.dart';

final class ConstructorOptionsNative extends Struct {
  external Pointer<Utf8> config_dir;

  ConstructorOptionsNative({required String configDir}) : super() {
    config_dir = configDir.toNativeUtf8();
  }
}

final class ConstructorOptions extends Struct {
  external Pointer<Utf8> id;
  external Pointer<Utf8> datamodel;
  external Pointer<Utf8> base_path;
  external Pointer<Utf8> log_level;

  @Bool()
  external bool log_queries;

  external Pointer<Utf8> datasource_overrides;
  external Pointer<Utf8> env;

  @Bool()
  external bool ignore_env_var_errors;
  external ConstructorOptionsNative native;

  main() {
    final deo = calloc<ConstructorOptionsNative>(1);

    deo.ref.config_dir = "demo".toNativeUtf8();
  }
}
