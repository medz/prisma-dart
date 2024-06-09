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

#---------------- Download & link Prisma C-ABI engine --------------------#

file(STRINGS ${CMAKE_CURRENT_SOURCE_DIR}/../prisma-engines-version.txt PRISMA_QUERY_ENGINE_VERSION)
set(PRISMA_QUERY_ENGINE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/.prisma-query-engines/${PRISMA_QUERY_ENGINE_VERSION})

if ((CMAKE_VERSION GREATER 3.20) OR (CMAKE_VERSION EQUAL 3.20))
    cmake_path(SET PRISMA_QUERY_ENGINE_LIB ${PRISMA_QUERY_ENGINE_DIR}/android/jniLibs/${ANDROID_ABI}/libquery_engine.a NORMALIZE)
else()
    set(PRISMA_QUERY_ENGINE_LIB ${PRISMA_QUERY_ENGINE_DIR}/android/jniLibs/${ANDROID_ABI}/libquery_engine.a)
endif()

if (NOT EXISTS ${PRISMA_QUERY_ENGINE_LIB})
    set(PRISMA_DOWNLOAD_FILE ${PRISMA_QUERY_ENGINE_DIR}/binaries.zip)

    if (EXISTS ${PRISMA_QUERY_ENGINE_DIR})
        file(REMOVE_RECURSE ${PRISMA_QUERY_ENGINE_DIR})
    endif ()

    file(MAKE_DIRECTORY ${PRISMA_QUERY_ENGINE_DIR})

    message(STATUS "Download Prisma C-ABI engine")
    file(DOWNLOAD "https://binaries.prisma.sh/all_commits/${PRISMA_QUERY_ENGINE_VERSION}/react-native/binaries.zip" ${PRISMA_DOWNLOAD_FILE})

    message(STATUS "Unzip ${PRISMA_DOWNLOAD_FILE}")
    file(
            ARCHIVE_EXTRACT
            INPUT ${PRISMA_DOWNLOAD_FILE}
            DESTINATION ${PRISMA_QUERY_ENGINE_DIR}
    )
endif ()

add_library(query_engine STATIC IMPORTED)

set_target_properties(query_engine PROPERTIES
    IMPORTED_LOCATION ${PRISMA_QUERY_ENGINE_LIB}
    PUBLIC_HEADER ${PRISMA_QUERY_ENGINE_DIR}/android/query_engine.h
)

target_link_libraries(
    orm_flutter
    ${PRISMA_QUERY_ENGINE_LIB}
)
