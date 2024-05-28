# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(prisma_flutter_library VERSION 0.0.1 LANGUAGES C)

add_library(prisma_flutter SHARED
  "prisma_flutter.c"
)

set_target_properties(prisma_flutter PROPERTIES
  PUBLIC_HEADER prisma_flutter.h
  OUTPUT_NAME "prisma_flutter"
)

target_compile_definitions(prisma_flutter PUBLIC DART_SHARED_LIB)
