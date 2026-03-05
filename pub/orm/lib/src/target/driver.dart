abstract interface class TargetDriver<TRequest, TRawResponse> {
  Future<void> open();

  Future<void> close();

  Future<TRawResponse> execute(TRequest request);
}
