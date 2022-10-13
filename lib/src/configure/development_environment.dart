import 'dart:async';
import 'dart:convert';

import 'package:orm/configure.dart';

import '_internal/internal.dart';

/// Development environment.
class PrismaDevelopment {
  /// Create a new development environment.
  PrismaDevelopment._internal();

  static const int _lineMaxLength = 40;

  /// Start keyword,
  static final String _start =
      '${'=' * 20} PRISMA DEVELOPMENT START ${'=' * 20}';

  /// End keyword.
  static final String _end = '${'=' * 20}  PRISMA DEVELOPMENT END  ${'=' * 20}';

  /// Prisma development environment server.
  static Future<void> server(
    FutureOr<void> Function(PrismaDevelopment) configurator,
  ) async {
    final PrismaDevelopment development = PrismaDevelopment._internal();

    // Calls the configurator.
    await configurator(development);

    // Create encoded environment.
    final String encoded =
        base64.encode(utf8.encode(json.encode(development._environment)));

    // Print the start keyword.
    printToConsole(_start);

    // Add encoded environment. split into multiple lines.
    // line length is 80 characters.
    for (int i = 0; i < encoded.length; i += _lineMaxLength) {
      int end = i + _lineMaxLength;
      if (end > encoded.length) {
        end = encoded.length;
      }

      printToConsole(encoded.substring(i, end));
    }

    // Write end keyword.
    print(_end);
  }

  /// Prisma development environment client.
  static client({
    required PrismaEnvironment environment,
    required String encoded,
  }) {
    final Iterable<String> lines = encoded
        .split(RegExp(r'\r?\n'))
        .map((e) => e.trim())
        .toList()
      ..removeWhere((element) => element.isEmpty);

    final List<String> encodeds = <String>[];
    final Iterator<String> iterator = lines.iterator;

    String? current;
    while (iterator.moveNext()) {
      if (iterator.current == _start) {
        current = '';
      } else if (current != null && iterator.current == _end) {
        encodeds.add(current.trim());
        current = null;
      } else if (current != null) {
        current += iterator.current.trim();
      }
    }

    for (final String encoded in encodeds) {
      final Map<String, String?> decoded =
          (json.decode(utf8.decode(base64.decode(encoded))) as Map)
              .cast<String, String?>();

      for (final MapEntry<String, String?> entry in decoded.entries) {
        if (entry.value == null) {
          environment.remove(entry.key);
          continue;
        }

        environment[entry.key] = entry.value!;
      }
    }
  }

  /// Environment variable store.
  final Map<String, String?> _environment = {};

  /// Override a environment variable.
  void override(String key, String value) => _environment[key] = value;

  /// Remove a environment variable.
  void remove(String key) => _environment[key] = null;
}
