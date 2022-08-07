/**
 * Engine Errors.
 */
typedef enum ApiError_Tag {
  Conversion,
  Configuration,
  Core,
  Connector,
  AlreadyConnected,
  NotConnected,
  JsonDecode,
} ApiError_Tag;

typedef struct Conversion_Body {
  char *_0;
  char *_1;
} Conversion_Body;

typedef struct ApiError {
  ApiError_Tag tag;
  union {
    Conversion_Body conversion;
    struct {
      char *configuration;
    };
    struct {
      char *core;
    };
    struct {
      char *connector;
    };
    struct {
      char *json_decode;
    };
  };
} ApiError;

/**
 * Result returned by the engine.
 */
typedef enum Result______c_char_Tag {
  /**
   * Success.
   */
  Ok______c_char,
  /**
   * Error.
   */
  Err______c_char,
} Result______c_char_Tag;

typedef struct Result______c_char {
  Result______c_char_Tag tag;
  union {
    struct {
      const char *ok;
    };
    struct {
      struct ApiError err;
    };
  };
} Result______c_char;

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
 * Get DMMF json string from the schema.
 */
struct Result______c_char dmmf(const char *datamodel_string);

/**
 * Get current version of the library.
 */
struct Version version(void);
