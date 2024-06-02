# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(orm_flutter_library VERSION 0.0.1 LANGUAGES C)

add_library(orm_flutter SHARED
  "../src/query_engine.h"
  "../src/orm_flutter.c"
)

include_directories(
    ../src
    query_engine
)

set_target_properties(orm_flutter PROPERTIES
  PUBLIC_HEADER ../src/orm_flutter.h
  OUTPUT_NAME "orm_flutter"
)

target_compile_definitions(orm_flutter PUBLIC DART_SHARED_LIB)

# cmake_path(SET QUERY_ENGINE_LIB ${CMAKE_CURRENT_SOURCE_DIR}/query_engine/${ANDROID_ABI}/libquery_engine.a NORMALIZE)
set (QUERY_ENGINE_LIB ${CMAKE_CURRENT_SOURCE_DIR}/query_engine/${ANDROID_ABI}/libquery_engine.a)

add_library(query_engine STATIC IMPORTED)

set_target_properties(query_engine PROPERTIES
    IMPORTED_LOCATION ${QUERY_ENGINE_LIB}
    PUBLIC_HEADERS ../src/query_engine.h
    OUTPUT_NAME "query_engine"
)

target_link_libraries(
    orm_flutter
    ${QUERY_ENGINE_LIB}
)
