import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

@immutable
@Target({.typedefType})
final class _Model {
  @literal
  const _Model();
}

const model = _Model();
