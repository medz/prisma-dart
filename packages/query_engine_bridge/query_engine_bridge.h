#include "query_engine.h"

#if _WIN32
#include <windows.h>
#endif

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

#ifndef QueryEngine
typedef struct QueryEngine {} QueryEngine;
#endif

/**
 * function returns status code.
 *
 * see:
 *  - [QueryEngineBindings.create]
 *  - [QueryEngineBindings.destroy]
 *  - [QueryEngineBindings.start]
 *  - [QueryEngineBindings.stop]
 *  - [QueryEngineBindings.applyMigrations]
 */
FFI_PLUGIN_EXPORT enum Status {
    /** Success */
    ok = 0,

    /** Error */
    err = 1,

    /** Missing pointer, only create returns. */
    miss = 2,
};

/**
    Create a new [QueryEngine]

    Returns a [Status] code.
*/
FFI_PLUGIN_EXPORT enum Status create(struct ConstructorOptions options,
                             struct QueryEngine **qePtr,
                             char **errorStringPtr);

/**
    Destroy a [QueryEngine]
*/
FFI_PLUGIN_EXPORT enum Status destroy(struct QueryEngine *qe);

/** Start a [QueryEngine] */
FFI_PLUGIN_EXPORT enum Status start(struct QueryEngine *qe,
                            const char *trace,
                            char **errorStringPtr);

/** Stop a [QueryEngine] */
FFI_PLUGIN_EXPORT enum Status stop(struct QueryEngine *qe,
                           const char *headerStr);

/** Apply migrations */
FFI_PLUGIN_EXPORT enum Status applyMigrations(struct QueryEngine *qe,
                                      const char *migrationsPath,
                                      char **errorStringPtr);

/** Query a prisma request */
FFI_PLUGIN_EXPORT const char *query(struct QueryEngine *qe,
                                    const char *bodyStr,
                                    const char *headerStr,
                                    const char *txIdStr,
                                    char **errorStringPtr);

/** Statr a transaction */
FFI_PLUGIN_EXPORT const char *startTransaction(struct QueryEngine *qe,
                                               const char *optionsStr,
                                               const char *headerStr);

/** Commit a transaction querys */
FFI_PLUGIN_EXPORT const char *commitTransaction(struct QueryEngine *qe,
                                                const char *txIdStr,
                                                const char *headerStr);

/** Roolback a transaction */
FFI_PLUGIN_EXPORT const char *rollbackTransaction(struct QueryEngine *qe,
                                                  const char *txIdStr,
                                                  const char *headerStr);
