/// Auto incerement id.
class AutoIncrementId {
  /// Current id.
  int _id = 0;

  /// Next id.
  int next() => _id++;

  /// To string.
  @override
  String toString() => '$_id';
}
