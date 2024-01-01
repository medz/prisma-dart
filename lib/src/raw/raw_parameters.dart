import 'raw_parameter_codec.dart';

class RawParameters {
  final String values;

  const RawParameters(this.values);

  factory RawParameters.fromRaw(dynamic raw) {
    if (raw is RawParameters) return raw;

    return RawParameters(rawParameter.encode(raw));
  }
}
