import '../core/engine.dart';
import '../core/transaction.dart';
import '../dmmf.dart' as dmmf show Datamodel;

class Context {
  final Engine engine;
  final dmmf.Datamodel datamodel;
  final String clientVersion;
  final String modelName;
  final InteractiveTransactionInfo? transaction;

  const Context({
    required this.engine,
    required this.datamodel,
    required this.clientVersion,
    required this.modelName,
    this.transaction,
  });
}

abstract class WithRuntimeContext {
  final Context context;

  const WithRuntimeContext({required this.context});
}
