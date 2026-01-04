import 'package:meta/meta.dart';

enum DatabaseProvider { sqlite }

@immutable
final class Config {
  final DatabaseProvider provider;
  final String output;
  final String? schema;
  final String? migrations;

  @literal
  const Config({
    required this.provider,
    required this.output,
    this.schema,
    this.migrations,
  });
}
