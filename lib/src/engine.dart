import 'dart:async';

import 'json_protocol/protocol.dart';
import 'metrics/metrics_format.dart';
import 'transaction/isolation_level.dart';
import 'transaction/transaction_headers.dart';
import 'transaction/transaction.dart';

abstract interface class Engine<T> {
  /// Starts the engine.
  ///
  /// This method is used to start the engine and perform any necessary initialization.
  /// It returns a [Future] that completes when the engine has started successfully.
  /// If any error occurs during the startup process, the [Future] will complete with an error.
  Future<void> start();

  /// Stops the engine.
  ///
  /// Returns a [Future] that completes when the engine has stopped.
  /// Throws an error if the engine fails to stop.
  Future<void> stop();

  /// Sends a request to the engine.
  ///
  /// - [query] is the query to be sent to the engine.
  /// - [headers] are the headers to be sent with the request.
  /// - [transaction] is the transaction to be used for the request.
  Future<Map> request(
    JsonQuery query, {
    TransactionHeaders? headers,
    Transaction<T>? transaction,
  });

  /// Starts a transaction.
  ///
  /// - [headers] are the headers to be sent with the request.
  /// - [maxWait] is the maximum amount of time to wait for the transaction to start.
  /// - [timeout] is the maximum amount of time to wait for the transaction to complete.
  /// - [isolationLevel] is the isolation level to be used for the transaction.
  Future<Transaction<T>> startTransaction({
    required TransactionHeaders headers,
    int maxWait = 2000,
    int timeout = 5000,
    IsolationLevel? isolationLevel,
  });

  /// Commits a transaction.
  ///
  /// - [headers] are the headers to be sent with the request.
  /// - [transaction] is the transaction to be committed.
  Future<void> commitTransaction({
    required TransactionHeaders headers,
    required Transaction<T> transaction,
  });

  /// Rolls back a transaction.
  ///
  /// - [headers] are the headers to be sent with the request.
  /// - [transaction] is the transaction to be rolled back.
  Future<void> rollbackTransaction({
    required TransactionHeaders headers,
    required Transaction<T> transaction,
  });

  /// Returns the metrics for the engine.
  Future<dynamic> metrics(
      {Map<String, String>? globalLabels, required MetricsFormat format});
}
