import '../input.dart';
import '../input_builder.dart';

extension NumFilter<R extends Input, T extends num, Ref, N>
    on InputBuilder<R, T, Ref, bool, N> {
  /// Equals filter
  InputBuilder<R, T, Ref, Null, N> get equals =>
      InputBuilder([...keys, 'equals'], factory);

  /// In filter
  InputBuilder<R, T, Ref, Null, N> get in_ =>
      InputBuilder([...keys, 'in'], factory);

  /// Not in filter
  InputBuilder<R, T, Ref, Null, N> get notIn =>
      InputBuilder([...keys, 'notIn'], factory);

  /// Less than filter
  InputBuilder<R, T, Ref, Null, N> get lt =>
      InputBuilder([...keys, 'lt'], factory);

  /// Less than or equals filter
  InputBuilder<R, T, Ref, Null, N> get lte =>
      InputBuilder([...keys, 'lte'], factory);

  /// Greater than filter
  InputBuilder<R, T, Ref, Null, N> get gt =>
      InputBuilder([...keys, 'gt'], factory);

  /// Greater than or equals filter
  InputBuilder<R, T, Ref, Null, N> get gte =>
      InputBuilder([...keys, 'gte'], factory);

  /// Not filter
  InputBuilder<R, T, Ref, bool, N> get not =>
      InputBuilder([...keys, 'not'], factory);
}
