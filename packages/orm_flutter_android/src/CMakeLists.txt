# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(orm_flutter_android_library VERSION 0.0.1 LANGUAGES C)

add_library(orm_flutter_android SHARED
  "orm_flutter_android.c"
)

set_target_properties(orm_flutter_android PROPERTIES
  PUBLIC_HEADER orm_flutter_android.h
  OUTPUT_NAME "orm_flutter_android"
)

target_compile_definitions(orm_flutter_android PUBLIC DART_SHARED_LIB)

if (ANDROID)
  # Support Android 15 16k page size
  target_link_options(orm_flutter_android PRIVATE "-Wl,-z,max-page-size=16384")
endif()
