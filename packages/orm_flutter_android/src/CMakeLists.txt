# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(orm_flutter_android_library VERSION 0.0.1 LANGUAGES C)

add_library(orm_flutter_android SHARED
  "query_engine_bridge/bridge.c"
)

set_target_properties(orm_flutter_android PROPERTIES
  PUBLIC_HEADER query_engine_bridge/headers/bridge.h
  OUTPUT_NAME "orm_flutter_android"
)

target_compile_definitions(orm_flutter_android PUBLIC DART_SHARED_LIB)

if (ANDROID)
  # Support Android 15 16k page size
  target_link_options(orm_flutter_android PRIVATE "-Wl,-z,max-page-size=16384")
endif()

add_library(prisma_query_engine STATIC IMPORTED)

if ((CMAKE_VERSION GREATER 3.20) OR (CMAKE_VERSION EQUAL 3.20))
    cmake_path(SET PRISMA_QUERY_ENGINE_LIB ${CMAKE_CURRENT_SOURCE_DIR}/jniLibs/${ANDROID_ABI}/libquery_engine.a NORMALIZE)
else()
    set(PRISMA_QUERY_ENGINE_LIB ${CMAKE_CURRENT_SOURCE_DIR}/jniLibs/${ANDROID_ABI}/libquery_engine.a)
endif()

set_target_properties(prisma_query_engine PROPERTIES
    IMPORTED_LOCATION ${PRISMA_QUERY_ENGINE_LIB}
    PUBLIC_HEADER query_engine_bridge/include/query_engine.h
)

target_link_libraries(
    orm_flutter_android
    prisma_query_engine
)
