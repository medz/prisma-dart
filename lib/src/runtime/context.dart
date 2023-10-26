import '../core/engine.dart';
import '../core/error_format.dart';
import '../core/transaction.dart';
import '../dmmf.dart' as dmmf show Datamodel;

class Context {
  final Engine engine;
  final dmmf.Datamodel datamodel;
  final String clientVersion;
  final ErrorFormat errorFormat;
  final String modelName;
  final String? traceparent;
  final InteractiveTransactionInfo? transaction;

  const Context({
    required this.engine,
    required this.datamodel,
    required this.clientVersion,
    required this.errorFormat,
    required this.modelName,
    this.traceparent,
    this.transaction,
  });
}

abstract class WithRuntimeContext {
  final Context context;

  const WithRuntimeContext({required this.context});
}
