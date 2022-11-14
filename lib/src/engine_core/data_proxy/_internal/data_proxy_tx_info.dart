import '../../common/types/transaction.dart';

class DataProxyTxInfo extends TransactionInfo {
  DataProxyTxInfo(super.id, {required this.endpoint});

  /// Transaction endpoint.
  final Uri endpoint;
}
