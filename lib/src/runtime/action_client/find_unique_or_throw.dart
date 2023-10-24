import '../../../protocol.dart';
import '../../core/json_convertible.dart';
import 'action_client.dart';

class FindUniqueOrThrowActionClient<
        R,
        Where extends JsonConvertible<Map<String, dynamic>>,
        Select extends JsonConvertible<Map<String, dynamic>>,
        Include extends JsonConvertible<Map<String, dynamic>>>
    extends ActionClient<R> {
  final Iterable<Where> _where;
  final Iterable<Select> _select;
  final Iterable<Include> _include;

  const FindUniqueOrThrowActionClient(
    super.context, [
    Iterable<Where>? where,
    Iterable<Select>? select,
    Iterable<Include>? include,
  ])  : _where = where ?? const [],
        _select = select ?? const [],
        _include = include ?? const [];

  FindUniqueOrThrowActionClient<R, Where, Select, Include> where(Where where) =>
      FindUniqueOrThrowActionClient(
          RUNTIME_CONTEXT, [..._where, where], _select, _include);

  FindUniqueOrThrowActionClient<R, Where, Select, Include> select(
          Select select) =>
      FindUniqueOrThrowActionClient(
          RUNTIME_CONTEXT, _where, [..._select, select], _include);

  FindUniqueOrThrowActionClient<R, Where, Select, Include> include(
          Include include) =>
      FindUniqueOrThrowActionClient(
          RUNTIME_CONTEXT, _where, _select, [..._include, include]);

  @override
  Future<R> toFuture() {
    final query = serializeJsonQuery(
      modelName: RUNTIME_CONTEXT.modelName,
      action: ModelAction.findUniqueOrThrow,
      args: toJson(),
      datamodel: RUNTIME_CONTEXT.datamodel,
      clientVersion: RUNTIME_CONTEXT.clientVersion,
      errorFormat: RUNTIME_CONTEXT.errorFormat,
    );

    final result = RUNTIME_CONTEXT.engine.request(
      query,
      isWrite: false,
      traceparent: RUNTIME_CONTEXT.traceparent,
      transaction: RUNTIME_CONTEXT.transaction,
    );

    return result.then(deserializeJsonResponse) as Future<R>;
  }

  @override
  Map? toJson() {
    final args = {
      if (_where.isNotEmpty)
        'where': Map.fromEntries(
          _where.map((e) => e.toJson().entries).expand((e) => e),
        ),
      if (_select.isNotEmpty)
        'select': Map.fromEntries(
          _select.map((e) => e.toJson().entries).expand((e) => e),
        ),
      if (_include.isNotEmpty)
        'include': Map.fromEntries(
          _include.map((e) => e.toJson().entries).expand((e) => e),
        ),
    };

    return args.isNotEmpty ? args : null;
  }
}
