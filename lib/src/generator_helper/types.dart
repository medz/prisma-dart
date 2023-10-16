import '_internal/json_serializable_annotation.dart';

part 'types.freezed.dart';
part 'types.g.dart';

@jsonSerializable
sealed class EnvValue with _$EnvValue {
  const factory EnvValue.env(final String env) = FormEnvVar;
  const factory EnvValue.value(final String value) = FormEnvValue;
}

@jsonSerializable
class GeneratorConfig with _$GeneratorConfig {
  const factory GeneratorConfig({
    required final String name,
  }) = _GeneratorConfig;
}
