import '_internal/json_serializable_annotation.dart';

part 'types.freezed.dart';
part 'types.g.dart';

@jsonSerializable
class EnvValue with _$EnvValue {
  const factory EnvValue({
    final String? fromEnvVar,
    final String? value,
  }) = _EnvValue;
}

@jsonSerializable
class GeneratorConfig with _$GeneratorConfig {
  const factory GeneratorConfig({
    required final String name,
  }) = _GeneratorConfig;
}
