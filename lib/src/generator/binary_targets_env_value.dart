class BinaryTargetsEnvValue {
  final String? fromEnvVar;
  final bool native;
  final String value;

  const BinaryTargetsEnvValue({
    this.fromEnvVar,
    required this.native,
    required this.value,
  });

  factory BinaryTargetsEnvValue.fromJson(Map json) {
    return BinaryTargetsEnvValue(
      fromEnvVar: json['fromEnvVar'] as String?,
      native: (json['native'] as bool?) ?? false,
      value: json['value'] as String,
    );
  }
}
