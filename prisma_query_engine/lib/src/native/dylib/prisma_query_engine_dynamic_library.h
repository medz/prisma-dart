/**
 * The Prisma query engine dynamid liobrary version info.
 */
typedef struct Version {
  /**
   * The commit hash of https://github.com/odroe/prisma repository.
   */
  const char *commit;
  /**
   * The version of the library.
   */
  const char *version;
} Version;

/**
 * Get current version of the library.
 */
struct Version version(void);
