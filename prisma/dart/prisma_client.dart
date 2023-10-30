// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:orm/orm.dart' as _i1;
import 'user_delegate.dart' as _i2;
import 'post_delegate.dart' as _i3;

class PrismaClient<T> {
  const PrismaClient._({
    required _i1.Engine<T> engine,
    _i1.InteractiveTransactionInfo<T>? transaction,
  })  : _engine = engine,
        _transaction = transaction;

  final _i1.Engine<T> _engine;

  final _i1.InteractiveTransactionInfo<T>? _transaction;

  _i2.UserDelegate<T> get user => _i2.UserDelegate<T>(
        _engine,
        _transaction,
      );

  _i3.PostDelegate<T> get post => _i3.PostDelegate<T>(
        _engine,
        _transaction,
      );
}
