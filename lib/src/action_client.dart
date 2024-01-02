import 'dart:async';

class ActionClient<T, R> implements Future<R> {
  final FutureOr<Map> _result;
  final String _action;
  final R Function(T) _factory;

  const ActionClient({
    required String action,
    required FutureOr<Map> result,
    required R Function(T unserialized) factory,
  })  : _action = action,
        _result = result,
        _factory = factory;

  Future<T> unserialized() =>
      Future.value(_result).then((value) => value[_action]);

  @override
  Stream<R> asStream() => unserialized().then(_factory).asStream();

  @override
  Future<R> catchError(Function onError, {bool Function(Object error)? test}) {
    return unserialized().then(_factory).catchError(onError, test: test);
  }

  @override
  Future<R2> then<R2>(FutureOr<R2> Function(R value) onValue,
      {Function? onError}) {
    return unserialized().then(_factory).then(onValue, onError: onError);
  }

  @override
  Future<R> timeout(Duration timeLimit, {FutureOr<R> Function()? onTimeout}) {
    return unserialized()
        .then(_factory)
        .timeout(timeLimit, onTimeout: onTimeout);
  }

  @override
  Future<R> whenComplete(FutureOr<void> Function() action) {
    return unserialized().then(_factory).whenComplete(action);
  }
}
