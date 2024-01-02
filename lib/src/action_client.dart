import 'dart:async';

class ActionClient<T, R> implements Future<R> {
  @override
  Stream<R> asStream() {
    // TODO: implement asStream
    throw UnimplementedError();
  }

  @override
  Future<R> catchError(Function onError, {bool Function(Object error)? test}) {
    // TODO: implement catchError
    throw UnimplementedError();
  }

  @override
  Future<R2> then<R2>(FutureOr<R2> Function(R value) onValue,
      {Function? onError}) {
    // TODO: implement then
    throw UnimplementedError();
  }

  @override
  Future<R> timeout(Duration timeLimit, {FutureOr<R> Function()? onTimeout}) {
    // TODO: implement timeout
    throw UnimplementedError();
  }

  @override
  Future<R> whenComplete(FutureOr<void> Function() action) {
    // TODO: implement whenComplete
    throw UnimplementedError();
  }
}
