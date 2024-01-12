import 'dart:async';

class ActionClient<T> implements Future<T> {
  final Future<Map> _result;
  final String _action;
  final T Function(dynamic) _factory;

  const ActionClient({
    required String action,
    required Future<Map> result,
    required T Function(dynamic unserialized) factory,
  })  : _action = action,
        _result = result,
        _factory = factory;

  Future<dynamic> unserialized() =>
      Future.value(_result).then((value) => value[_action]);

  @override
  Stream<T> asStream() => unserialized().then(_factory).asStream();

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) {
    return unserialized().then(_factory).catchError(onError, test: test);
  }

  @override
  Future<R> then<R>(FutureOr<R> Function(T value) onValue,
      {Function? onError}) {
    return unserialized().then(_factory).then(onValue, onError: onError);
  }

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) {
    return unserialized()
        .then(_factory)
        .timeout(timeLimit, onTimeout: onTimeout);
  }

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) {
    return unserialized().then(_factory).whenComplete(action);
  }
}
