typedef struct Context {

} Context;

typedef const char *(*LogCallback)(const char*);

struct Context *query_engine_new(const char *options, LogCallback callback);

const char *schema_format(const char *schema, const char *params);

const char *schema_get_configuration(const char *params);

const char *schema_get_dmmf(const char *params);
