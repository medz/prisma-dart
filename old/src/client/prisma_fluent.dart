import 'dart:async';

import '../graphql/field.dart';

typedef PrismaFluentQuery = Future<Object?> Function(
    Iterable<GraphQLField> fields);

/// Prisma Model fluent.
///
/// This class is used to wrap the result of a Prisma Model query.
///
/// Example (User Fluent):
/// ```dart
/// final fluent = prisma.user.findUniqueOrThrow();
/// final user = await fluent;
/// final posts = await fluent.posts(take: 10);
/// final postsCount = await fluent.$count().posts();
/// ```
///
/// Example (Aggregate User Fluent):
/// ```dart
/// final fluent = prisma.user.aggregate();
///
/// final idCount = await fluent.$count().id();
/// final idAvg = await fluent.$avg().id();
/// final idSum = await fluent.$sum().id();
/// final idMin = await fluent.$min().id();
/// final idMax = await fluent.$max().id();
/// ```
class PrismaFluent<T> implements Future<T> {
  /// Query Builder
  static PrismaFluentQuery queryBuilder({
    required PrismaFluentQuery query,
    String? key,
  }) {
    return (Iterable<GraphQLField> fields) async {
      final result = await query(fields);
      if (key == null) return result;

      return result is Map ? result[key] : null;
    };
  }

  final Future<T> _original;
  final PrismaFluentQuery $query;

  const PrismaFluent(Future<T> original, this.$query) : _original = original;

  @override
  Stream<T> asStream() => _original.asStream();

  @override
  PrismaFluent<T> catchError(Function onError,
      {bool Function(Object error)? test}) {
    if (_original is PrismaFluent<T>) {
      return _original.catchError(onError, test: test) as PrismaFluent<T>;
    }

    return PrismaFluent(_original.catchError(onError, test: test), $query);
  }

  @override
  PrismaFluent<R> then<R>(FutureOr<R> Function(T value) onValue,
      {Function? onError}) {
    if (_original is PrismaFluent<T>) {
      return _original.then(onValue, onError: onError) as PrismaFluent<R>;
    }

    return PrismaFluent(_original.then(onValue, onError: onError), $query);
  }

  @override
  PrismaFluent<T> timeout(Duration timeLimit,
      {FutureOr<T> Function()? onTimeout}) {
    if (_original is PrismaFluent<T>) {
      return _original.timeout(timeLimit, onTimeout: onTimeout)
          as PrismaFluent<T>;
    }
    return PrismaFluent(
        _original.timeout(timeLimit, onTimeout: onTimeout), $query);
  }

  @override
  PrismaFluent<T> whenComplete(FutureOr<void> Function() action) {
    if (_original is PrismaFluent<T>) {
      return _original.whenComplete(action) as PrismaFluent<T>;
    }
    return PrismaFluent(_original.whenComplete(action), $query);
  }
}
