import 'binary_targets_env_value.dart';
import 'env_value.dart';

class GeneratorConfig {
  final String name;
  final Env? output;
  final bool isCustomOutput;
  final Env provider;
  final Map<String, dynamic> config;
  final Iterable<BinaryTargetsEnvValue> binaryTargets;
  final Iterable<String> previewFeatures;

  const GeneratorConfig({
    required this.name,
    this.output,
    required this.isCustomOutput,
    required this.provider,
    required this.config,
    required this.binaryTargets,
    required this.previewFeatures,
  });

  factory GeneratorConfig.fromJson(Map json) {
    return GeneratorConfig(
      name: json['name'] as String,
      output:
          json['output'] == null ? null : Env.fromJson(json['output'] as Map),
      isCustomOutput: (json['isCustomOutput'] as bool?) ?? false,
      provider: Env.fromJson(json['provider'] as Map),
      config: (json['config'] as Map).cast(),
      binaryTargets: (json['binaryTargets'] as Iterable)
          .map((e) => BinaryTargetsEnvValue.fromJson(e as Map)),
      previewFeatures: (json['previewFeatures'] as Iterable).cast(),
    );
  }
}
