import 'dart:async';

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
  final Future<T> _original;

  const PrismaFluent(Future<T> original) : _original = original;

  @override
  Stream<T> asStream() => _original.asStream();

  @override
  PrismaFluent<T> catchError(Function onError,
      {bool Function(Object error)? test}) {
    if (_original is PrismaFluent<T>) {
      return _original.catchError(onError, test: test) as PrismaFluent<T>;
    }

    return PrismaFluent(_original.catchError(onError, test: test));
  }

  @override
  PrismaFluent<R> then<R>(FutureOr<R> Function(T value) onValue,
      {Function? onError}) {
    if (_original is PrismaFluent<T>) {
      return _original.then(onValue, onError: onError) as PrismaFluent<R>;
    }

    return PrismaFluent(_original.then(onValue, onError: onError));
  }

  @override
  PrismaFluent<T> timeout(Duration timeLimit,
      {FutureOr<T> Function()? onTimeout}) {
    if (_original is PrismaFluent<T>) {
      return _original.timeout(timeLimit, onTimeout: onTimeout)
          as PrismaFluent<T>;
    }
    return PrismaFluent(_original.timeout(timeLimit, onTimeout: onTimeout));
  }

  @override
  PrismaFluent<T> whenComplete(FutureOr<void> Function() action) {
    if (_original is PrismaFluent<T>) {
      return _original.whenComplete(action) as PrismaFluent<T>;
    }
    return PrismaFluent(_original.whenComplete(action));
  }
}
