typedef const int8_t *DartString;

typedef void (*StringCallback)(DartString);

typedef void (*VoidCallback)(void);

QueryEngine *query_engine_new(DartString options, StringCallback callback);

void query_engine_connect(QueryEngine *engine,
                          VoidCallback callback,
                          VoidCallback _error,
                          DartString trace);

void query_engine_disconnect(QueryEngine *engine,
                             VoidCallback callback,
                             VoidCallback _error,
                             DartString trace);
