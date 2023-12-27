import '../../input.dart';
import '../where_builder.dart';

extension NumFilter<Where extends Input, Value extends num, Ref, Nullable>
    on WhereBuilder<Where, Value, Ref, bool, Nullable> {
  /// Equals filter
  WhereBuilder<Where, Value, Ref, Null, Nullable> get equals =>
      WhereBuilder([...keys, 'equals'], factory);

  /// In filter
  WhereBuilder<Where, Value, Ref, Null, Nullable> get in_ =>
      WhereBuilder([...keys, 'in'], factory);

  /// Not in filter
  WhereBuilder<Where, Value, Ref, Null, Nullable> get notIn =>
      WhereBuilder([...keys, 'notIn'], factory);

  /// Less than filter
  WhereBuilder<Where, Value, Ref, Null, Nullable> get lt =>
      WhereBuilder([...keys, 'lt'], factory);

  /// Less than or equals filter
  WhereBuilder<Where, Value, Ref, Null, Nullable> get lte =>
      WhereBuilder([...keys, 'lte'], factory);

  /// Greater than filter
  WhereBuilder<Where, Value, Ref, Null, Nullable> get gt =>
      WhereBuilder([...keys, 'gt'], factory);

  /// Greater than or equals filter
  WhereBuilder<Where, Value, Ref, Null, Nullable> get gte =>
      WhereBuilder([...keys, 'gte'], factory);

  /// Not filter
  WhereBuilder<Where, Value, Ref, Null, Nullable> get not =>
      WhereBuilder([...keys, 'not'], factory);
}
