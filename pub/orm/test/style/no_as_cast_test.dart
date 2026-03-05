import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:test/test.dart';

void main() {
  test('forbids as-casts in package source and tests', () {
    final packageRoot = File.fromUri(Platform.script).parent.parent.parent;
    final targets = <Directory>[
      Directory('${packageRoot.path}${Platform.pathSeparator}lib'),
      Directory('${packageRoot.path}${Platform.pathSeparator}test'),
    ];

    final violations = <String>[];

    for (final file in _collectDartFiles(targets)) {
      final result = parseString(
        content: file.readAsStringSync(),
        path: file.path,
        throwIfDiagnostics: false,
      );
      final visitor = _AsCastVisitor();
      result.unit.visitChildren(visitor);

      for (final expression in visitor.expressions) {
        final location = result.lineInfo.getLocation(
          expression.asOperator.offset,
        );
        violations.add(
          '${file.path}:${location.lineNumber}:${location.columnNumber}',
        );
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Avoid using "as" casts. Use pattern matching or stronger static types.\n'
          'Violations:\n${violations.join('\n')}',
    );
  });
}

Iterable<File> _collectDartFiles(Iterable<Directory> roots) sync* {
  for (final root in roots) {
    if (!root.existsSync()) {
      continue;
    }

    final entries = root.listSync(recursive: true, followLinks: false);
    for (final entry in entries) {
      if (entry is! File) {
        continue;
      }
      if (!entry.path.endsWith('.dart')) {
        continue;
      }
      yield entry;
    }
  }
}

final class _AsCastVisitor extends RecursiveAstVisitor<void> {
  final List<AsExpression> expressions = <AsExpression>[];

  @override
  void visitAsExpression(AsExpression node) {
    expressions.add(node);
    super.visitAsExpression(node);
  }
}
