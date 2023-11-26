import 'engine.dart';
import 'prisma_client.dart';
import 'transaction.dart';

class ModelDelegate<M, T> {
  final PrismaClient<T> _client;

  const ModelDelegate(PrismaClient<T> client) : _client = client;

  static PrismaClient<T> $getPrismaClient<T>(
          ModelDelegate<dynamic, T> delegate) =>
      delegate._client;

  static TransactionHeaders? $getPrismaClientHeaders(ModelDelegate delegate) =>
      PrismaClient.$getPrismaClientHeaders(delegate._client);

  static Transaction<T>? $getPrismaClientTransaction<T>(
          ModelDelegate<dynamic, T> delegate) =>
      PrismaClient.$getPrismaClientTransaction(delegate._client);

  static Engine<T> $getPrismaEngine<T>(ModelDelegate<dynamic, T> delegate) =>
      PrismaClient.$getPrismaEngine(delegate._client);
}
