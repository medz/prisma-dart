library prisma.client; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:json_annotation/json_annotation.dart';
import 'package:orm/binary_engine.dart' as _i5;
import 'package:orm/engine_core.dart' as _i3;
import 'package:orm/graphql.dart' as _i2;
import 'package:orm/logger.dart' as _i4;
import 'package:orm/orm.dart' as _i1;

part 'prisma_client.g.dart';

enum SaySomethingScalarFieldEnum implements _i1.PrismaEnum {
  id,
  createdAt,
  updatedAt,
  text;

  @override
  String? get originalName => null;
}

enum SortOrder implements _i1.PrismaEnum {
  asc,
  desc;

  @override
  String? get originalName => null;
}

@_i1.jsonSerializable
class SaySomethingWhereInput implements _i1.JsonSerializable {
  const SaySomethingWhereInput({
    this.AND,
    this.OR,
    this.NOT,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.text,
  });

  factory SaySomethingWhereInput.fromJson(Map<String, dynamic> json) =>
      _$SaySomethingWhereInputFromJson(json);

  final Iterable<SaySomethingWhereInput>? AND;

  final Iterable<SaySomethingWhereInput>? OR;

  final Iterable<SaySomethingWhereInput>? NOT;

  final IntFilter? id;

  final DateTimeFilter? createdAt;

  final DateTimeFilter? updatedAt;

  final StringFilter? text;

  @override
  Map<String, dynamic> toJson() => _$SaySomethingWhereInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingOrderByWithRelationInput implements _i1.JsonSerializable {
  const SaySomethingOrderByWithRelationInput({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.text,
  });

  factory SaySomethingOrderByWithRelationInput.fromJson(
          Map<String, dynamic> json) =>
      _$SaySomethingOrderByWithRelationInputFromJson(json);

  final SortOrder? id;

  final SortOrder? createdAt;

  final SortOrder? updatedAt;

  final SortOrder? text;

  @override
  Map<String, dynamic> toJson() =>
      _$SaySomethingOrderByWithRelationInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingWhereUniqueInput implements _i1.JsonSerializable {
  const SaySomethingWhereUniqueInput({this.id});

  factory SaySomethingWhereUniqueInput.fromJson(Map<String, dynamic> json) =>
      _$SaySomethingWhereUniqueInputFromJson(json);

  final int? id;

  @override
  Map<String, dynamic> toJson() => _$SaySomethingWhereUniqueInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingOrderByWithAggregationInput implements _i1.JsonSerializable {
  const SaySomethingOrderByWithAggregationInput({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.text,
    this.$count,
    this.$avg,
    this.$max,
    this.$min,
    this.$sum,
  });

  factory SaySomethingOrderByWithAggregationInput.fromJson(
          Map<String, dynamic> json) =>
      _$SaySomethingOrderByWithAggregationInputFromJson(json);

  final SortOrder? id;

  final SortOrder? createdAt;

  final SortOrder? updatedAt;

  final SortOrder? text;

  @JsonKey(name: r'_count')
  final SaySomethingCountOrderByAggregateInput? $count;

  @JsonKey(name: r'_avg')
  final SaySomethingAvgOrderByAggregateInput? $avg;

  @JsonKey(name: r'_max')
  final SaySomethingMaxOrderByAggregateInput? $max;

  @JsonKey(name: r'_min')
  final SaySomethingMinOrderByAggregateInput? $min;

  @JsonKey(name: r'_sum')
  final SaySomethingSumOrderByAggregateInput? $sum;

  @override
  Map<String, dynamic> toJson() =>
      _$SaySomethingOrderByWithAggregationInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingScalarWhereWithAggregatesInput
    implements _i1.JsonSerializable {
  const SaySomethingScalarWhereWithAggregatesInput({
    this.AND,
    this.OR,
    this.NOT,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.text,
  });

  factory SaySomethingScalarWhereWithAggregatesInput.fromJson(
          Map<String, dynamic> json) =>
      _$SaySomethingScalarWhereWithAggregatesInputFromJson(json);

  final Iterable<SaySomethingScalarWhereWithAggregatesInput>? AND;

  final Iterable<SaySomethingScalarWhereWithAggregatesInput>? OR;

  final Iterable<SaySomethingScalarWhereWithAggregatesInput>? NOT;

  final IntWithAggregatesFilter? id;

  final DateTimeWithAggregatesFilter? createdAt;

  final DateTimeWithAggregatesFilter? updatedAt;

  final StringWithAggregatesFilter? text;

  @override
  Map<String, dynamic> toJson() =>
      _$SaySomethingScalarWhereWithAggregatesInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingCreateInput implements _i1.JsonSerializable {
  const SaySomethingCreateInput({
    this.createdAt,
    this.updatedAt,
    required this.text,
  });

  factory SaySomethingCreateInput.fromJson(Map<String, dynamic> json) =>
      _$SaySomethingCreateInputFromJson(json);

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final String text;

  @override
  Map<String, dynamic> toJson() => _$SaySomethingCreateInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingUncheckedCreateInput implements _i1.JsonSerializable {
  const SaySomethingUncheckedCreateInput({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.text,
  });

  factory SaySomethingUncheckedCreateInput.fromJson(
          Map<String, dynamic> json) =>
      _$SaySomethingUncheckedCreateInputFromJson(json);

  final int? id;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final String text;

  @override
  Map<String, dynamic> toJson() =>
      _$SaySomethingUncheckedCreateInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingUpdateInput implements _i1.JsonSerializable {
  const SaySomethingUpdateInput({
    this.createdAt,
    this.updatedAt,
    this.text,
  });

  factory SaySomethingUpdateInput.fromJson(Map<String, dynamic> json) =>
      _$SaySomethingUpdateInputFromJson(json);

  final DateTimeFieldUpdateOperationsInput? createdAt;

  final DateTimeFieldUpdateOperationsInput? updatedAt;

  final StringFieldUpdateOperationsInput? text;

  @override
  Map<String, dynamic> toJson() => _$SaySomethingUpdateInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingUncheckedUpdateInput implements _i1.JsonSerializable {
  const SaySomethingUncheckedUpdateInput({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.text,
  });

  factory SaySomethingUncheckedUpdateInput.fromJson(
          Map<String, dynamic> json) =>
      _$SaySomethingUncheckedUpdateInputFromJson(json);

  final IntFieldUpdateOperationsInput? id;

  final DateTimeFieldUpdateOperationsInput? createdAt;

  final DateTimeFieldUpdateOperationsInput? updatedAt;

  final StringFieldUpdateOperationsInput? text;

  @override
  Map<String, dynamic> toJson() =>
      _$SaySomethingUncheckedUpdateInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingUpdateManyMutationInput implements _i1.JsonSerializable {
  const SaySomethingUpdateManyMutationInput({
    this.createdAt,
    this.updatedAt,
    this.text,
  });

  factory SaySomethingUpdateManyMutationInput.fromJson(
          Map<String, dynamic> json) =>
      _$SaySomethingUpdateManyMutationInputFromJson(json);

  final DateTimeFieldUpdateOperationsInput? createdAt;

  final DateTimeFieldUpdateOperationsInput? updatedAt;

  final StringFieldUpdateOperationsInput? text;

  @override
  Map<String, dynamic> toJson() =>
      _$SaySomethingUpdateManyMutationInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingUncheckedUpdateManyInput implements _i1.JsonSerializable {
  const SaySomethingUncheckedUpdateManyInput({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.text,
  });

  factory SaySomethingUncheckedUpdateManyInput.fromJson(
          Map<String, dynamic> json) =>
      _$SaySomethingUncheckedUpdateManyInputFromJson(json);

  final IntFieldUpdateOperationsInput? id;

  final DateTimeFieldUpdateOperationsInput? createdAt;

  final DateTimeFieldUpdateOperationsInput? updatedAt;

  final StringFieldUpdateOperationsInput? text;

  @override
  Map<String, dynamic> toJson() =>
      _$SaySomethingUncheckedUpdateManyInputToJson(this);
}

@_i1.jsonSerializable
class IntFilter implements _i1.JsonSerializable {
  const IntFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  factory IntFilter.fromJson(Map<String, dynamic> json) =>
      _$IntFilterFromJson(json);

  final int? equals;

  @JsonKey(name: r'in')
  final Iterable<int>? $in;

  final Iterable<int>? notIn;

  final int? lt;

  final int? lte;

  final int? gt;

  final int? gte;

  final NestedIntFilter? not;

  @override
  Map<String, dynamic> toJson() => _$IntFilterToJson(this);
}

@_i1.jsonSerializable
class DateTimeFilter implements _i1.JsonSerializable {
  const DateTimeFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  factory DateTimeFilter.fromJson(Map<String, dynamic> json) =>
      _$DateTimeFilterFromJson(json);

  final DateTime? equals;

  @JsonKey(name: r'in')
  final Iterable<DateTime>? $in;

  final Iterable<DateTime>? notIn;

  final DateTime? lt;

  final DateTime? lte;

  final DateTime? gt;

  final DateTime? gte;

  final NestedDateTimeFilter? not;

  @override
  Map<String, dynamic> toJson() => _$DateTimeFilterToJson(this);
}

@_i1.jsonSerializable
class StringFilter implements _i1.JsonSerializable {
  const StringFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.not,
  });

  factory StringFilter.fromJson(Map<String, dynamic> json) =>
      _$StringFilterFromJson(json);

  final String? equals;

  @JsonKey(name: r'in')
  final Iterable<String>? $in;

  final Iterable<String>? notIn;

  final String? lt;

  final String? lte;

  final String? gt;

  final String? gte;

  final String? contains;

  final String? startsWith;

  final String? endsWith;

  final NestedStringFilter? not;

  @override
  Map<String, dynamic> toJson() => _$StringFilterToJson(this);
}

@_i1.jsonSerializable
class SaySomethingCountOrderByAggregateInput implements _i1.JsonSerializable {
  const SaySomethingCountOrderByAggregateInput({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.text,
  });

  factory SaySomethingCountOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$SaySomethingCountOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  final SortOrder? createdAt;

  final SortOrder? updatedAt;

  final SortOrder? text;

  @override
  Map<String, dynamic> toJson() =>
      _$SaySomethingCountOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingAvgOrderByAggregateInput implements _i1.JsonSerializable {
  const SaySomethingAvgOrderByAggregateInput({this.id});

  factory SaySomethingAvgOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$SaySomethingAvgOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  @override
  Map<String, dynamic> toJson() =>
      _$SaySomethingAvgOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingMaxOrderByAggregateInput implements _i1.JsonSerializable {
  const SaySomethingMaxOrderByAggregateInput({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.text,
  });

  factory SaySomethingMaxOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$SaySomethingMaxOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  final SortOrder? createdAt;

  final SortOrder? updatedAt;

  final SortOrder? text;

  @override
  Map<String, dynamic> toJson() =>
      _$SaySomethingMaxOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingMinOrderByAggregateInput implements _i1.JsonSerializable {
  const SaySomethingMinOrderByAggregateInput({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.text,
  });

  factory SaySomethingMinOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$SaySomethingMinOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  final SortOrder? createdAt;

  final SortOrder? updatedAt;

  final SortOrder? text;

  @override
  Map<String, dynamic> toJson() =>
      _$SaySomethingMinOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class SaySomethingSumOrderByAggregateInput implements _i1.JsonSerializable {
  const SaySomethingSumOrderByAggregateInput({this.id});

  factory SaySomethingSumOrderByAggregateInput.fromJson(
          Map<String, dynamic> json) =>
      _$SaySomethingSumOrderByAggregateInputFromJson(json);

  final SortOrder? id;

  @override
  Map<String, dynamic> toJson() =>
      _$SaySomethingSumOrderByAggregateInputToJson(this);
}

@_i1.jsonSerializable
class IntWithAggregatesFilter implements _i1.JsonSerializable {
  const IntWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.$count,
    this.$avg,
    this.$sum,
    this.$min,
    this.$max,
  });

  factory IntWithAggregatesFilter.fromJson(Map<String, dynamic> json) =>
      _$IntWithAggregatesFilterFromJson(json);

  final int? equals;

  @JsonKey(name: r'in')
  final Iterable<int>? $in;

  final Iterable<int>? notIn;

  final int? lt;

  final int? lte;

  final int? gt;

  final int? gte;

  final NestedIntWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_avg')
  final NestedFloatFilter? $avg;

  @JsonKey(name: r'_sum')
  final NestedIntFilter? $sum;

  @JsonKey(name: r'_min')
  final NestedIntFilter? $min;

  @JsonKey(name: r'_max')
  final NestedIntFilter? $max;

  @override
  Map<String, dynamic> toJson() => _$IntWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class DateTimeWithAggregatesFilter implements _i1.JsonSerializable {
  const DateTimeWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  factory DateTimeWithAggregatesFilter.fromJson(Map<String, dynamic> json) =>
      _$DateTimeWithAggregatesFilterFromJson(json);

  final DateTime? equals;

  @JsonKey(name: r'in')
  final Iterable<DateTime>? $in;

  final Iterable<DateTime>? notIn;

  final DateTime? lt;

  final DateTime? lte;

  final DateTime? gt;

  final DateTime? gte;

  final NestedDateTimeWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_min')
  final NestedDateTimeFilter? $min;

  @JsonKey(name: r'_max')
  final NestedDateTimeFilter? $max;

  @override
  Map<String, dynamic> toJson() => _$DateTimeWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class StringWithAggregatesFilter implements _i1.JsonSerializable {
  const StringWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  factory StringWithAggregatesFilter.fromJson(Map<String, dynamic> json) =>
      _$StringWithAggregatesFilterFromJson(json);

  final String? equals;

  @JsonKey(name: r'in')
  final Iterable<String>? $in;

  final Iterable<String>? notIn;

  final String? lt;

  final String? lte;

  final String? gt;

  final String? gte;

  final String? contains;

  final String? startsWith;

  final String? endsWith;

  final NestedStringWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_min')
  final NestedStringFilter? $min;

  @JsonKey(name: r'_max')
  final NestedStringFilter? $max;

  @override
  Map<String, dynamic> toJson() => _$StringWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class DateTimeFieldUpdateOperationsInput implements _i1.JsonSerializable {
  const DateTimeFieldUpdateOperationsInput({this.set});

  factory DateTimeFieldUpdateOperationsInput.fromJson(
          Map<String, dynamic> json) =>
      _$DateTimeFieldUpdateOperationsInputFromJson(json);

  final DateTime? set;

  @override
  Map<String, dynamic> toJson() =>
      _$DateTimeFieldUpdateOperationsInputToJson(this);
}

@_i1.jsonSerializable
class StringFieldUpdateOperationsInput implements _i1.JsonSerializable {
  const StringFieldUpdateOperationsInput({this.set});

  factory StringFieldUpdateOperationsInput.fromJson(
          Map<String, dynamic> json) =>
      _$StringFieldUpdateOperationsInputFromJson(json);

  final String? set;

  @override
  Map<String, dynamic> toJson() =>
      _$StringFieldUpdateOperationsInputToJson(this);
}

@_i1.jsonSerializable
class IntFieldUpdateOperationsInput implements _i1.JsonSerializable {
  const IntFieldUpdateOperationsInput({
    this.set,
    this.increment,
    this.decrement,
    this.multiply,
    this.divide,
  });

  factory IntFieldUpdateOperationsInput.fromJson(Map<String, dynamic> json) =>
      _$IntFieldUpdateOperationsInputFromJson(json);

  final int? set;

  final int? increment;

  final int? decrement;

  final int? multiply;

  final int? divide;

  @override
  Map<String, dynamic> toJson() => _$IntFieldUpdateOperationsInputToJson(this);
}

@_i1.jsonSerializable
class NestedIntFilter implements _i1.JsonSerializable {
  const NestedIntFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  factory NestedIntFilter.fromJson(Map<String, dynamic> json) =>
      _$NestedIntFilterFromJson(json);

  final int? equals;

  @JsonKey(name: r'in')
  final Iterable<int>? $in;

  final Iterable<int>? notIn;

  final int? lt;

  final int? lte;

  final int? gt;

  final int? gte;

  final NestedIntFilter? not;

  @override
  Map<String, dynamic> toJson() => _$NestedIntFilterToJson(this);
}

@_i1.jsonSerializable
class NestedDateTimeFilter implements _i1.JsonSerializable {
  const NestedDateTimeFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  factory NestedDateTimeFilter.fromJson(Map<String, dynamic> json) =>
      _$NestedDateTimeFilterFromJson(json);

  final DateTime? equals;

  @JsonKey(name: r'in')
  final Iterable<DateTime>? $in;

  final Iterable<DateTime>? notIn;

  final DateTime? lt;

  final DateTime? lte;

  final DateTime? gt;

  final DateTime? gte;

  final NestedDateTimeFilter? not;

  @override
  Map<String, dynamic> toJson() => _$NestedDateTimeFilterToJson(this);
}

@_i1.jsonSerializable
class NestedStringFilter implements _i1.JsonSerializable {
  const NestedStringFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.not,
  });

  factory NestedStringFilter.fromJson(Map<String, dynamic> json) =>
      _$NestedStringFilterFromJson(json);

  final String? equals;

  @JsonKey(name: r'in')
  final Iterable<String>? $in;

  final Iterable<String>? notIn;

  final String? lt;

  final String? lte;

  final String? gt;

  final String? gte;

  final String? contains;

  final String? startsWith;

  final String? endsWith;

  final NestedStringFilter? not;

  @override
  Map<String, dynamic> toJson() => _$NestedStringFilterToJson(this);
}

@_i1.jsonSerializable
class NestedIntWithAggregatesFilter implements _i1.JsonSerializable {
  const NestedIntWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.$count,
    this.$avg,
    this.$sum,
    this.$min,
    this.$max,
  });

  factory NestedIntWithAggregatesFilter.fromJson(Map<String, dynamic> json) =>
      _$NestedIntWithAggregatesFilterFromJson(json);

  final int? equals;

  @JsonKey(name: r'in')
  final Iterable<int>? $in;

  final Iterable<int>? notIn;

  final int? lt;

  final int? lte;

  final int? gt;

  final int? gte;

  final NestedIntWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_avg')
  final NestedFloatFilter? $avg;

  @JsonKey(name: r'_sum')
  final NestedIntFilter? $sum;

  @JsonKey(name: r'_min')
  final NestedIntFilter? $min;

  @JsonKey(name: r'_max')
  final NestedIntFilter? $max;

  @override
  Map<String, dynamic> toJson() => _$NestedIntWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class NestedFloatFilter implements _i1.JsonSerializable {
  const NestedFloatFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  factory NestedFloatFilter.fromJson(Map<String, dynamic> json) =>
      _$NestedFloatFilterFromJson(json);

  final double? equals;

  @JsonKey(name: r'in')
  final Iterable<double>? $in;

  final Iterable<double>? notIn;

  final double? lt;

  final double? lte;

  final double? gt;

  final double? gte;

  final NestedFloatFilter? not;

  @override
  Map<String, dynamic> toJson() => _$NestedFloatFilterToJson(this);
}

@_i1.jsonSerializable
class NestedDateTimeWithAggregatesFilter implements _i1.JsonSerializable {
  const NestedDateTimeWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  factory NestedDateTimeWithAggregatesFilter.fromJson(
          Map<String, dynamic> json) =>
      _$NestedDateTimeWithAggregatesFilterFromJson(json);

  final DateTime? equals;

  @JsonKey(name: r'in')
  final Iterable<DateTime>? $in;

  final Iterable<DateTime>? notIn;

  final DateTime? lt;

  final DateTime? lte;

  final DateTime? gt;

  final DateTime? gte;

  final NestedDateTimeWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_min')
  final NestedDateTimeFilter? $min;

  @JsonKey(name: r'_max')
  final NestedDateTimeFilter? $max;

  @override
  Map<String, dynamic> toJson() =>
      _$NestedDateTimeWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class NestedStringWithAggregatesFilter implements _i1.JsonSerializable {
  const NestedStringWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  factory NestedStringWithAggregatesFilter.fromJson(
          Map<String, dynamic> json) =>
      _$NestedStringWithAggregatesFilterFromJson(json);

  final String? equals;

  @JsonKey(name: r'in')
  final Iterable<String>? $in;

  final Iterable<String>? notIn;

  final String? lt;

  final String? lte;

  final String? gt;

  final String? gte;

  final String? contains;

  final String? startsWith;

  final String? endsWith;

  final NestedStringWithAggregatesFilter? not;

  @JsonKey(name: r'_count')
  final NestedIntFilter? $count;

  @JsonKey(name: r'_min')
  final NestedStringFilter? $min;

  @JsonKey(name: r'_max')
  final NestedStringFilter? $max;

  @override
  Map<String, dynamic> toJson() =>
      _$NestedStringWithAggregatesFilterToJson(this);
}

@_i1.jsonSerializable
class SaySomething implements _i1.JsonSerializable {
  const SaySomething({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.text,
  });

  factory SaySomething.fromJson(Map<String, dynamic> json) =>
      _$SaySomethingFromJson(json);

  final int id;

  final DateTime createdAt;

  final DateTime updatedAt;

  final String text;

  @override
  Map<String, dynamic> toJson() => _$SaySomethingToJson(this);
}

class SaySomethingFluent<T> extends _i1.PrismaFluent<T> {
  const SaySomethingFluent(
    super.original,
    super.$query,
  );
}

extension SaySomethingModelDelegateExtension
    on _i1.ModelDelegate<SaySomething> {
  SaySomethingFluent<SaySomething?> findUnique(
      {required SaySomethingWhereUniqueInput where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findUniqueSaySomething',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findUniqueSaySomething',
    );
    final future = query(SaySomethingScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? SaySomething.fromJson(json.cast<String, dynamic>())
            : null);
    return SaySomethingFluent<SaySomething?>(
      future,
      query,
    );
  }

  SaySomethingFluent<SaySomething> findUniqueOrThrow(
      {required SaySomethingWhereUniqueInput where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findUniqueSaySomethingOrThrow',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findUniqueSaySomethingOrThrow',
    );
    final future = query(SaySomethingScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? SaySomething.fromJson(json.cast<String, dynamic>())
            : throw Exception('Not found SaySomething'));
    return SaySomethingFluent<SaySomething>(
      future,
      query,
    );
  }

  SaySomethingFluent<SaySomething?> findFirst({
    SaySomethingWhereInput? where,
    Iterable<SaySomethingOrderByWithRelationInput>? orderBy,
    SaySomethingWhereUniqueInput? cursor,
    int? take,
    int? skip,
    Iterable<SaySomethingScalarFieldEnum>? distinct,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
      _i2.GraphQLArg(
        r'distinct',
        distinct,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findFirstSaySomething',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findFirstSaySomething',
    );
    final future = query(SaySomethingScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? SaySomething.fromJson(json.cast<String, dynamic>())
            : null);
    return SaySomethingFluent<SaySomething?>(
      future,
      query,
    );
  }

  SaySomethingFluent<SaySomething> findFirstOrThrow({
    SaySomethingWhereInput? where,
    Iterable<SaySomethingOrderByWithRelationInput>? orderBy,
    SaySomethingWhereUniqueInput? cursor,
    int? take,
    int? skip,
    Iterable<SaySomethingScalarFieldEnum>? distinct,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
      _i2.GraphQLArg(
        r'distinct',
        distinct,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findFirstSaySomethingOrThrow',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findFirstSaySomethingOrThrow',
    );
    final future = query(SaySomethingScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? SaySomething.fromJson(json.cast<String, dynamic>())
            : throw Exception('Not found SaySomething'));
    return SaySomethingFluent<SaySomething>(
      future,
      query,
    );
  }

  Future<Iterable<SaySomething>> findMany({
    SaySomethingWhereInput? where,
    Iterable<SaySomethingOrderByWithRelationInput>? orderBy,
    SaySomethingWhereUniqueInput? cursor,
    int? take,
    int? skip,
    Iterable<SaySomethingScalarFieldEnum>? distinct,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
      _i2.GraphQLArg(
        r'distinct',
        distinct,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'findManySaySomething',
          fields: fields,
          args: args,
        )
      ]),
      key: r'findManySaySomething',
    );
    final fields = SaySomethingScalarFieldEnum.values.toGraphQLFields();
    compiler(Iterable<Map> findManySaySomething) =>
        findManySaySomething.map((Map findManySaySomething) =>
            SaySomething.fromJson(findManySaySomething.cast()));
    return query(fields).then((json) => json is Iterable
        ? compiler(json.cast())
        : throw Exception('Unable to parse response'));
  }

  SaySomethingFluent<SaySomething> create(
      {required SaySomethingCreateInput data}) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'createOneSaySomething',
          fields: fields,
          args: args,
        )
      ]),
      key: r'createOneSaySomething',
    );
    final future = query(SaySomethingScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? SaySomething.fromJson(json.cast<String, dynamic>())
            : throw Exception('Not found SaySomething'));
    return SaySomethingFluent<SaySomething>(
      future,
      query,
    );
  }

  SaySomethingFluent<SaySomething?> update({
    required SaySomethingUpdateInput data,
    required SaySomethingWhereUniqueInput where,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      ),
      _i2.GraphQLArg(
        r'where',
        where,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'updateOneSaySomething',
          fields: fields,
          args: args,
        )
      ]),
      key: r'updateOneSaySomething',
    );
    final future = query(SaySomethingScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? SaySomething.fromJson(json.cast<String, dynamic>())
            : null);
    return SaySomethingFluent<SaySomething?>(
      future,
      query,
    );
  }

  Future<AffectedRowsOutput> updateMany({
    required SaySomethingUpdateManyMutationInput data,
    SaySomethingWhereInput? where,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'data',
        data,
      ),
      _i2.GraphQLArg(
        r'where',
        where,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'updateManySaySomething',
          fields: fields,
          args: args,
        )
      ]),
      key: r'updateManySaySomething',
    );
    final fields = const ['count'].map((e) => _i2.GraphQLField(e));
    compiler(Map updateManySaySomething) =>
        AffectedRowsOutput.fromJson(updateManySaySomething.cast());
    return query(fields).then((json) => json is Map
        ? compiler(json)
        : throw Exception('Unable to parse response'));
  }

  SaySomethingFluent<SaySomething> upsert({
    required SaySomethingWhereUniqueInput where,
    required SaySomethingCreateInput create,
    required SaySomethingUpdateInput update,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'create',
        create,
      ),
      _i2.GraphQLArg(
        r'update',
        update,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'upsertOneSaySomething',
          fields: fields,
          args: args,
        )
      ]),
      key: r'upsertOneSaySomething',
    );
    final future = query(SaySomethingScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? SaySomething.fromJson(json.cast<String, dynamic>())
            : throw Exception('Not found SaySomething'));
    return SaySomethingFluent<SaySomething>(
      future,
      query,
    );
  }

  SaySomethingFluent<SaySomething?> delete(
      {required SaySomethingWhereUniqueInput where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'deleteOneSaySomething',
          fields: fields,
          args: args,
        )
      ]),
      key: r'deleteOneSaySomething',
    );
    final future = query(SaySomethingScalarFieldEnum.values.toGraphQLFields())
        .then((json) => json is Map
            ? SaySomething.fromJson(json.cast<String, dynamic>())
            : null);
    return SaySomethingFluent<SaySomething?>(
      future,
      query,
    );
  }

  Future<AffectedRowsOutput> deleteMany({SaySomethingWhereInput? where}) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      )
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'deleteManySaySomething',
          fields: fields,
          args: args,
        )
      ]),
      key: r'deleteManySaySomething',
    );
    final fields = const ['count'].map((e) => _i2.GraphQLField(e));
    compiler(Map deleteManySaySomething) =>
        AffectedRowsOutput.fromJson(deleteManySaySomething.cast());
    return query(fields).then((json) => json is Map
        ? compiler(json)
        : throw Exception('Unable to parse response'));
  }

  AggregateSaySomething aggregate({
    SaySomethingWhereInput? where,
    Iterable<SaySomethingOrderByWithRelationInput>? orderBy,
    SaySomethingWhereUniqueInput? cursor,
    int? take,
    int? skip,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'cursor',
        cursor,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'aggregateSaySomething',
          fields: fields,
          args: args,
        )
      ]),
      key: r'aggregateSaySomething',
    );
    return AggregateSaySomething(query);
  }

  Future<Iterable<SaySomethingGroupByOutputType>> groupBy({
    SaySomethingWhereInput? where,
    Iterable<SaySomethingOrderByWithAggregationInput>? orderBy,
    required Iterable<SaySomethingScalarFieldEnum> by,
    SaySomethingScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
  }) {
    final args = [
      _i2.GraphQLArg(
        r'where',
        where,
      ),
      _i2.GraphQLArg(
        r'orderBy',
        orderBy,
      ),
      _i2.GraphQLArg(
        r'by',
        by,
      ),
      _i2.GraphQLArg(
        r'having',
        having,
      ),
      _i2.GraphQLArg(
        r'take',
        take,
      ),
      _i2.GraphQLArg(
        r'skip',
        skip,
      ),
    ];
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'groupBySaySomething',
          fields: fields,
          args: args,
        )
      ]),
      key: r'groupBySaySomething',
    );
    final fields = by.map((e) => _i2.GraphQLField(e.originalName ?? e.name));
    compiler(Iterable<Map> groupBySaySomething) =>
        groupBySaySomething.map((Map groupBySaySomething) =>
            SaySomethingGroupByOutputType.fromJson(groupBySaySomething.cast()));
    return query(fields).then((json) => json is Iterable
        ? compiler(json.cast())
        : throw Exception('Unable to parse response'));
  }
}

@_i1.jsonSerializable
class SaySomethingGroupByOutputType implements _i1.JsonSerializable {
  const SaySomethingGroupByOutputType({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.text,
  });

  factory SaySomethingGroupByOutputType.fromJson(Map<String, dynamic> json) =>
      _$SaySomethingGroupByOutputTypeFromJson(json);

  final int? id;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final String? text;

  @override
  Map<String, dynamic> toJson() => _$SaySomethingGroupByOutputTypeToJson(this);
}

@_i1.jsonSerializable
class AffectedRowsOutput implements _i1.JsonSerializable {
  const AffectedRowsOutput({this.count});

  factory AffectedRowsOutput.fromJson(Map<String, dynamic> json) =>
      _$AffectedRowsOutputFromJson(json);

  final int? count;

  @override
  Map<String, dynamic> toJson() => _$AffectedRowsOutputToJson(this);
}

class AggregateSaySomething {
  const AggregateSaySomething(this.$query);

  final _i1.PrismaFluentQuery $query;

  SaySomethingCountAggregateOutputType $count() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_count',
          fields: fields,
        )
      ]),
      key: r'_count',
    );
    return SaySomethingCountAggregateOutputType(query);
  }

  SaySomethingAvgAggregateOutputType $avg() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_avg',
          fields: fields,
        )
      ]),
      key: r'_avg',
    );
    return SaySomethingAvgAggregateOutputType(query);
  }

  SaySomethingSumAggregateOutputType $sum() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_sum',
          fields: fields,
        )
      ]),
      key: r'_sum',
    );
    return SaySomethingSumAggregateOutputType(query);
  }

  SaySomethingMinAggregateOutputType $min() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_min',
          fields: fields,
        )
      ]),
      key: r'_min',
    );
    return SaySomethingMinAggregateOutputType(query);
  }

  SaySomethingMaxAggregateOutputType $max() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_max',
          fields: fields,
        )
      ]),
      key: r'_max',
    );
    return SaySomethingMaxAggregateOutputType(query);
  }
}

class SaySomethingCountAggregateOutputType {
  const SaySomethingCountAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> createdAt() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'createdAt',
          fields: fields,
        )
      ]),
      key: r'createdAt',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> updatedAt() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'updatedAt',
          fields: fields,
        )
      ]),
      key: r'updatedAt',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> text() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'text',
          fields: fields,
        )
      ]),
      key: r'text',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<int> $all() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'_all',
          fields: fields,
        )
      ]),
      key: r'_all',
    );
    return query(const []).then((value) => (value as int));
  }
}

class SaySomethingAvgAggregateOutputType {
  const SaySomethingAvgAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<double?> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as double));
  }
}

class SaySomethingSumAggregateOutputType {
  const SaySomethingSumAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int?> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as int));
  }
}

class SaySomethingMinAggregateOutputType {
  const SaySomethingMinAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int?> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<DateTime?> createdAt() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'createdAt',
          fields: fields,
        )
      ]),
      key: r'createdAt',
    );
    return query(const [])
        .then((value) => value is String ? DateTime.parse(value) : null);
  }

  Future<DateTime?> updatedAt() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'updatedAt',
          fields: fields,
        )
      ]),
      key: r'updatedAt',
    );
    return query(const [])
        .then((value) => value is String ? DateTime.parse(value) : null);
  }

  Future<String?> text() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'text',
          fields: fields,
        )
      ]),
      key: r'text',
    );
    return query(const []).then((value) => (value as String));
  }
}

class SaySomethingMaxAggregateOutputType {
  const SaySomethingMaxAggregateOutputType(this.$query);

  final _i1.PrismaFluentQuery $query;

  Future<int?> id() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'id',
          fields: fields,
        )
      ]),
      key: r'id',
    );
    return query(const []).then((value) => (value as int));
  }

  Future<DateTime?> createdAt() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'createdAt',
          fields: fields,
        )
      ]),
      key: r'createdAt',
    );
    return query(const [])
        .then((value) => value is String ? DateTime.parse(value) : null);
  }

  Future<DateTime?> updatedAt() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'updatedAt',
          fields: fields,
        )
      ]),
      key: r'updatedAt',
    );
    return query(const [])
        .then((value) => value is String ? DateTime.parse(value) : null);
  }

  Future<String?> text() {
    final query = _i1.PrismaFluent.queryBuilder(
      query: (fields) => $query([
        _i2.GraphQLField(
          r'text',
          fields: fields,
        )
      ]),
      key: r'text',
    );
    return query(const []).then((value) => (value as String));
  }
}

@JsonSerializable(
  createFactory: false,
  createToJson: true,
  includeIfNull: false,
)
class Datasources implements _i1.JsonSerializable {
  const Datasources({this.db = r'file:./db.sqlite'});

  final String? db;

  @override
  Map<String, dynamic> toJson() => _$DatasourcesToJson(this);
}

class PrismaClient extends _i1.BasePrismaClient<PrismaClient> {
  PrismaClient._internal(
    _i3.Engine engine, {
    _i3.QueryEngineRequestHeaders? headers,
    _i3.TransactionInfo? transaction,
  })  : _engine = engine,
        _headers = headers,
        _transaction = transaction,
        super(
          engine,
          headers: headers,
          transaction: transaction,
        );

  factory PrismaClient({
    Datasources? datasources,
    Iterable<_i4.Event>? stdout,
    Iterable<_i4.Event>? event,
  }) {
    final logger = _i4.Logger(
      stdout: stdout,
      event: event,
    );
    final engine = _i5.BinaryEngine(
      logger: logger,
      schema:
          r'Ly8gVGhpcyBpcyB5b3VyIFByaXNtYSBzY2hlbWEgZmlsZSwKLy8gbGVhcm4gbW9yZSBhYm91dCBpdCBpbiB0aGUgZG9jczogaHR0cHM6Ly9wcmlzLmx5L2QvcHJpc21hLXNjaGVtYQoKZ2VuZXJhdG9yIGNsaWVudCB7CiAgcHJvdmlkZXIgPSAiZGFydCBydW4gb3JtIgp9CgpkYXRhc291cmNlIGRiIHsKICBwcm92aWRlciA9ICJzcWxpdGUiCiAgdXJsICAgICAgPSAiZmlsZTouL2RiLnNxbGl0ZSIKfQoKbW9kZWwgU2F5U29tZXRoaW5nIHsKICBpZCAgICAgICAgSW50ICAgICAgQGlkIEBkZWZhdWx0KGF1dG9pbmNyZW1lbnQoKSkKICBjcmVhdGVkQXQgRGF0ZVRpbWUgQGRlZmF1bHQobm93KCkpCiAgdXBkYXRlZEF0IERhdGVUaW1lIEB1cGRhdGVkQXQKICB0ZXh0ICAgICAgU3RyaW5nCn0K',
      datasources: datasources?.toJson().cast() ?? const {},
      executable:
          r'/Users/seven/workspace/prisma-dart/node_modules/prisma/query-engine-darwin',
    );
    return PrismaClient._internal(engine);
  }

  final _i3.Engine _engine;

  final _i3.QueryEngineRequestHeaders? _headers;

  final _i3.TransactionInfo? _transaction;

  @override
  PrismaClient copyWith({
    _i3.QueryEngineRequestHeaders? headers,
    _i3.TransactionInfo? transaction,
  }) =>
      PrismaClient._internal(
        _engine,
        headers: headers ?? _headers,
        transaction: transaction ?? _transaction,
      );
  _i1.ModelDelegate<SaySomething> get saySomething =>
      _i1.ModelDelegate<SaySomething>(
        _engine,
        headers: _headers,
        transaction: _transaction,
      );
}
