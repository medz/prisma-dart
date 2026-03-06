final class GeneratorException implements Exception {
  final String message;
  final String? path;
  final int? line;
  final int? column;
  final String? hint;

  const GeneratorException(
    this.message, {
    this.path,
    this.line,
    this.column,
    this.hint,
  });

  String formatForCli() {
    final buffer = StringBuffer()..writeln('Generate failed: $message');

    if (path != null && path!.isNotEmpty) {
      buffer.writeln('File: $path');
    }

    if (line != null && column != null) {
      buffer.writeln('Location: $line:$column');
    }

    if (hint != null && hint!.isNotEmpty) {
      buffer.writeln('Hint: $hint');
    }

    return buffer.toString().trimRight();
  }

  @override
  String toString() => formatForCli();
}
