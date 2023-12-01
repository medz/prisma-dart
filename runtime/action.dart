import 'dart:async';

class Action<T, P> implements Future<T> {
  final String model;
  final String action;
  final Map<String, dynamic> args = {};

  Action(this.model, this.action);

  @override
  Stream<T> asStream() {
    // TODO: implement asStream
    throw UnimplementedError();
  }

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) {
    // TODO: implement catchError
    throw UnimplementedError();
  }

  @override
  Future<R> then<R>(FutureOr<R> Function(T value) onValue,
      {Function? onError}) {
    // TODO: implement then
    throw UnimplementedError();
  }

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) {
    // TODO: implement timeout
    throw UnimplementedError();
  }

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) {
    // TODO: implement whenComplete
    throw UnimplementedError();
  }
}
