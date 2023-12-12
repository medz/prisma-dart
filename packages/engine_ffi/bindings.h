typedef const int8_t *DartString;

typedef void (*StringCallback)(DartString);

typedef void (*QueryEngineNewCallback)(QueryEngine*);

typedef void (*VoidCallback)(void);

void query_engine_new(DartString options,
                      StringCallback callback,
                      QueryEngineNewCallback created,
                      VoidCallback error);

void query_engine_connect(QueryEngine *engine,
                          VoidCallback callback,
                          VoidCallback _error,
                          DartString trace);

void query_engine_disconnect(QueryEngine *engine,
                             VoidCallback callback,
                             VoidCallback _error,
                             DartString trace);
