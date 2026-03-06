import 'package:meta/meta.dart';

/// Annotation to map a model or field to a database name.
@immutable
final class MapTo {
  final String name;

  /// Creates a mapping annotation with the given database name.
  const MapTo(this.name);
}
