#include "query_engine.h"
#include "query_engine_bridge.h"

/**
    Create a new [QueryEngine]

    Returns a [Status] code.
*/
FFI_PLUGIN_EXPORT enum Status create(struct ConstructorOptions options,
                             struct QueryEngine **qePtr,
                             char **errorStringPtr)
{
    return prisma_create(options, qePtr, errorStringPtr);
}

/**
    Destroy a [QueryEngine]
*/
FFI_PLUGIN_EXPORT enum Status destroy(struct QueryEngine *qe) {
    return prisma_destroy(qe);
}

/** Start a [QueryEngine] */
FFI_PLUGIN_EXPORT enum Status start(struct QueryEngine *qe,
                            const char *trace,
                            char **errorStringPtr) {
    return prisma_connect(qe, trace, errorStringPtr);
}

/** Stop a [QueryEngine] */
FFI_PLUGIN_EXPORT enum Status stop(struct QueryEngine *qe,
                           const char *headerStr) {
    return prisma_disconnect(qe, headerStr);
}

/** Apply migrations */
FFI_PLUGIN_EXPORT enum Status applyMigrations(struct QueryEngine *qe,
                                      const char *migrationsPath,
                                      char **errorStringPtr) {
    return prisma_apply_pending_migrations(qe, migrationsPath, errorStringPtr);
}

/** Query a prisma request */
FFI_PLUGIN_EXPORT const char *query(struct QueryEngine *qe,
                                    const char *bodyStr,
                                    const char *headerStr,
                                    const char *txIdStr,
                                    char **errorStringPtr){
    return prisma_query(qe, bodyStr, headerStr, txIdStr, errorStringPtr);
}

/** Statr a transaction */
FFI_PLUGIN_EXPORT const char *startTransaction(struct QueryEngine *qe,
                                               const char *optionsStr,
                                               const char *headerStr) {
    return prisma_start_transaction(qe, optionsStr, headerStr);
}

/** Commit a transaction querys */
FFI_PLUGIN_EXPORT const char *commitTransaction(struct QueryEngine *qe,
                                                const char *txIdStr,
                                                const char *headerStr)
{
    return prisma_commit_transaction(qe, txIdStr, headerStr);
}
/** Roolback a transaction */
FFI_PLUGIN_EXPORT const char *rollbackTransaction(struct QueryEngine *qe,
                                                  const char *txIdStr,
                                                  const char *headerStr)
{
    return prisma_rollback_transaction(qe, txIdStr, headerStr);
}
