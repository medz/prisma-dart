import '../action.dart';

mixin Where<T> {
  Map<String, dynamic> where(T where, Map<String, dynamic> args) => args;
}

extension WhereAction<T, W> on Action<T, Where<W>> {
  Action<T, Where<W>> where(W where) => this;
}
