#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#if _WIN32
#include <windows.h>
#else
#include <pthread.h>
#include <unistd.h>
#endif

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

#include "query_engine.h"

FFI_PLUGIN_EXPORT int initialize_prisma_query_engine(
    struct ConstructorOptions options,
    struct QueryEngine **qe_ptr,
    char **error_string_ptr);
