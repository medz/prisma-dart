import 'package:prisma_generator_helper/dmmf.dart';

/// Prisma protocol message.
abstract interface class ProtocolMessage {
  /// Message convert to engine query.
  dynamic toEngineQuery();
}

/// Prisma protocol encoder.
abstract class ProtocolEncoder {
  /// Prisma DMMF
  final Document dmmf;

  /// Prisma protocol encoder.
  const ProtocolEncoder(this.dmmf);

  /// Encode to protocol message.
  ProtocolMessage encode({
    required ProtocolAction action,
    String model,
    Map<String, dynamic>? args,
  });
}

/// Prisma protocol action
final class ProtocolAction {
  final String name;

  /// Execute raw
  const ProtocolAction.executeRaw() : name = 'executeRaw';

  /// query raw
  const ProtocolAction.queryRaw() : name = 'queryRaw';

  /// run command raw
  const ProtocolAction.runCommand() : name = 'runCommand';

  /// Model action
  ProtocolAction.model(ModelAction action) : name = action.name;
}
