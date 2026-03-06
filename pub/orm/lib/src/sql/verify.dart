import '../runtime/core.dart';
import 'marker_reader.dart';

RuntimeVerifyOptions sqlRuntimeVerifyOptions({
  required SqlMarkerQueryExecutor executor,
  RuntimeVerifyMode mode = RuntimeVerifyMode.onFirstUse,
  bool requireMarker = true,
  SqlMarkerQuery? query,
  String hashColumn = SqlContractMarkerReader.defaultHashColumn,
}) {
  return RuntimeVerifyOptions(
    mode: mode,
    requireMarker: requireMarker,
    markerReader: SqlContractMarkerReader(
      executor: executor,
      query: query,
      hashColumn: hashColumn,
    ),
  );
}
