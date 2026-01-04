import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

/// Marks a typedef as a model in the schema.
const model = _Model();

@immutable
@Target({.typedefType})
final class _Model {
  @literal
  const _Model();
}
