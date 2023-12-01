import 'model_field_refercence.dart';

typedef FromJsonFactory<T> = T Function(Map<String, dynamic> json);

class Builder<I, O, T> {
  final String identifier;
  final O Function(Map<String, dynamic> json) factory;

  const Builder(this.identifier, this.factory);

  O call(I value) => factory({identifier: value});
}

extension ModelFieldRefercenceBuilder<I, O, V,
    T extends ModelFieldRefercence<V>> on Builder<I, O, T> {
  O ref(T value) => factory({identifier: value});
}
