#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>


typedef struct JsonResponse JsonResponse;

/**
 * Get the version of the library.
 */
struct JsonResponse *version(void);
