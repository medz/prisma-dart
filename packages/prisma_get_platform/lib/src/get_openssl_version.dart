import 'dart:convert';
import 'dart:io';

/// Get OpenSSL version.
///
/// Returns format:
/// - 1.0.x
/// - 1.1.x
/// - 3.0.x
///
/// If OpenSSL version is not found, throws [UnsupportedError].
///
/// If OpenSSL version > 3.0, returns 3.0.x.
String getOpenSSLVersion() {
  final Iterable<List<String>> libsslCommands = [
    'ls -l /lib/libssl.so.3',
    'ls -l /lib/libssl.so.1.1',
    'ls -l /lib64',
    'ls -l /usr/lib64',
  ].map((e) => e.split(' '));
  final String? libssl = _getFirstSuccessCommandResult(libsslCommands);
  if (libssl != null) {
    final RegExp regex = RegExp(r'libssl\.so\.(\d)(\.\d)?',
        multiLine: true, caseSensitive: false);
    final Iterable<String> lines = LineSplitter.split(libssl);

    for (final String line in lines) {
      if (!line.contains('ssl')) {
        continue;
      }

      final Match? match = regex.firstMatch(line);
      if (match != null) {
        final String major = match.group(1)!.trim();
        final String? minor = match.group(2)?.trim();
        final String version = '$major${minor ?? '.0'}.x';

        return _senitseOpensslVersion(version);
      }
    }
  }

  final Iterable<List<String>> opensslCommands = [
    'openssl version -v',
  ].map((e) => e.split(' '));
  final String? openssl = _getFirstSuccessCommandResult(opensslCommands);
  if (openssl != null) {
    final RegExp regex =
        RegExp(r'.*?(\d+)\.(\d+)\.\d+', multiLine: true, caseSensitive: false);
    final Match? match = regex.firstMatch(openssl);

    if (match != null) {
      final String major = match.group(1)!.trim();
      final String minor = match.group(2)!.trim();
      final String version = '$major.$minor.x';

      return _senitseOpensslVersion(version);
    }
  }

  throw UnsupportedError('OpenSSL not found');
}

/// Get first success command result.
String? _getFirstSuccessCommandResult(Iterable<Iterable<String>> commands) {
  for (final Iterable<String> command in commands) {
    final String executable = command.first;
    final List<String> arguments = command.skip(1).toList();

    final ProcessResult result = Process.runSync(executable, arguments,
        stdoutEncoding: utf8, stderrEncoding: utf8);
    if (result.exitCode == 0) {
      return result.stdout.toString().trim();
    }
  }
  return null;
}

/// Senitse OpenSSL/LibSSL version
///
/// OpenSSL 3+, E.g: `3.1.x` -> `3.0.x`
String _senitseOpensslVersion(String version) {
  if (version.startsWith('3.')) {
    return '3.0.x';
  }

  return version;
}
