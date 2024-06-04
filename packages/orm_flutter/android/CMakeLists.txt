# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(orm_flutter_library VERSION 0.0.1 LANGUAGES C)

add_library(orm_flutter SHARED
  "../src/orm_flutter.c"
)

set_target_properties(orm_flutter PROPERTIES
  PUBLIC_HEADER ../src/orm_flutter.h
  OUTPUT_NAME "orm_flutter"
)

target_compile_definitions(orm_flutter PUBLIC DART_SHARED_LIB)

if ((CMAKE_VERSION GREATER 3.20) OR (CMAKE_VERSION EQUAL 3.20))
    cmake_path(SET QUERY_ENGINE_LIB ${CMAKE_CURRENT_SOURCE_DIR}/query_engine/${ANDROID_ABI}/libquery_engine.a NORMALIZE)
else()
    set (QUERY_ENGINE_LIB ${CMAKE_CURRENT_SOURCE_DIR}/query_engine/${ANDROID_ABI}/libquery_engine.a)
endif()

add_custom_command(OUTPUT ${QUERY_ENGINE_LIB}
    COMMAND dart run orm_flutter:dl_engine
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../
)

add_custom_target(query_engine DEPENDS ${QUERY_ENGINE_LIB})

# add_library(query_engine STATIC IMPORTED)

set_target_properties(query_engine PROPERTIES
    IMPORTED_LOCATION ${QUERY_ENGINE_LIB}
)

target_link_libraries(
    orm_flutter
    ${QUERY_ENGINE_LIB}
)
