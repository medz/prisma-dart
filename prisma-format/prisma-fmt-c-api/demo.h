#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

/**
 * Format a Prisma schema.
 */
const char *format(const char *schema, const char *params);

/**
 * Lint a Prisma schema.
 */
const char *lint(const char *schema);
