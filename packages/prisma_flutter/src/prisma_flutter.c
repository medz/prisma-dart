#include "prisma_flutter.h"

FFI_PLUGIN_EXPORT int initialize_prisma_query_engine(struct ConstructorOptions options, struct QueryEngine **qe_ptr, char **error_string_ptr) {
    return prisma_create(options, qe_ptr, error_string_ptr);
}
