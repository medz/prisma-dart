import '../_internal/public_builder_properties.dart';
import '../builder.dart';
import '../model_field_refercence.dart';

extension StringFilter<O, V, S extends ModelFieldRefercence<V>,
    T extends Builder<String, O, S>> on Builder<String, O, T> {
  Builder<String, O, S> get equals =>
      Builder('equals', (filter) => $factory({$identifier: filter}));
}
