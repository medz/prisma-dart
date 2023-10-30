// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:orm/orm.dart' as _i1;

class UserDelegate<T> {
  const UserDelegate(
    _i1.Engine<T> engine, [
    _i1.InteractiveTransactionInfo<T>? transaction,
  ])  : _engine = engine,
        _transaction = transaction;

  final _i1.Engine<T> _engine;

  final _i1.InteractiveTransactionInfo<T>? _transaction;

  findUnique();
  findUniqueOrThrow();
  findFirst();
  findMany();
  create();
  createMany();
  update();
  updateMany();
  upsert();
  delete();
  deleteMany();
  aggregate();
  groupBy();
}
