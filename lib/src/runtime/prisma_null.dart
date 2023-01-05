import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_serializable.dart' as internal;

part 'prisma_null.g.dart';
part 'prisma_null.freezed.dart';

@freezed
class PrismaNull with _$PrismaNull implements internal.JsonSerializable {
  const factory PrismaNull() = _PrismaNull;

  factory PrismaNull.fromJson(Map<String, dynamic> json) =>
      _$PrismaNullFromJson(json);
}

typedef PrismaNullable<T> = T?;
