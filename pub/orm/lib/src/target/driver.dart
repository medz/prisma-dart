abstract interface class TargetDriver<TRequest, TRawResponse> {
  Future<void> open();

  Future<void> close();

  Future<TRawResponse> execute(TRequest request);
}

abstract interface class TargetDriverConnection<TRequest, TRawResponse> {
  Future<TRawResponse> execute(TRequest request);

  Future<TargetDriverTransaction<TRequest, TRawResponse>> transaction();

  Future<void> release();
}

abstract interface class TargetDriverTransaction<TRequest, TRawResponse> {
  Future<TRawResponse> execute(TRequest request);

  Future<void> commit();

  Future<void> rollback();
}

abstract interface class TargetDriverConnectionCapable<TRequest, TRawResponse> {
  Future<TargetDriverConnection<TRequest, TRawResponse>> connection();
}
