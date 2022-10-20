export 'print2console/print2console.dart'
    if (dart.library.io) 'print2console/print2console_io.dart';

const Iterable<String> truthy = ['true', '1', 'yes', 'on'];
const Iterable<String> falsey = ['false', '0', 'no', 'off'];

/// Environment [bool] parser.
bool parseBool(String? value) {
  final String? trimmed = value?.trim().toLowerCase();
  if (truthy.contains(trimmed)) return true;
  if (falsey.contains(trimmed)) return false;

  return trimmed?.isNotEmpty ?? false;
}
