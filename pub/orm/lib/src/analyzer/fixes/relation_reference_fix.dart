import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

import '../relation_utils.dart';

const int maxRelationReferenceFixes = 10;

class ReplaceWithRelationReferenceFix extends ResolvedCorrectionProducer {
  final int candidateIndex;
  String? _candidate;

  ReplaceWithRelationReferenceFix({
    required super.context,
    required this.candidateIndex,
  });

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

  @override
  FixKind get fixKind => FixKind(
    'orm_replace_relation_reference',
    DartFixKindPriority.standard - candidateIndex,
    "Replace with '{0}'.",
  );

  @override
  List<String> get fixArguments => [_candidate ?? ''];

  @override
  Future<void> compute(ChangeBuilder builder) async {
    var literal = _findStringLiteral();
    if (literal == null) return;

    var field = literal.thisOrAncestorOfType<RecordTypeAnnotationNamedField>();
    if (field == null) return;

    var record = literal.thisOrAncestorOfType<RecordTypeAnnotation>();
    if (record == null) return;

    var alias = literal.thisOrAncestorOfType<GenericTypeAlias>();
    if (alias == null || findModelAnnotation(alias.metadata) == null) return;

    if (findRelationAnnotation(field.metadata) == null) return;

    var candidates = _rankCandidates(
      collectNonRelationRecordFieldNames(record).toList(),
      literal.value,
    );
    if (candidateIndex < 0 || candidateIndex >= candidates.length) return;

    var chosen = candidates[candidateIndex];
    _candidate = chosen;
    var replacement = _formatLiteral(literal, chosen);

    await builder.addDartFileEdit(file, (builder) {
      builder.addSimpleReplacement(
        SourceRange(literal.offset, literal.length),
        replacement,
      );
    });
  }

  SimpleStringLiteral? _findStringLiteral() {
    var literal = coveringNode?.thisOrAncestorOfType<StringLiteral>();
    if (literal is SimpleStringLiteral) {
      return literal;
    }
    return null;
  }

  String _formatLiteral(SimpleStringLiteral literal, String value) {
    var quote = literal.isSingleQuoted ? "'" : '"';
    var rawPrefix = literal.isRaw ? 'r' : '';
    return '$rawPrefix$quote$value$quote';
  }
}

List<String> _rankCandidates(List<String> candidates, String? target) {
  var scored = <({String name, int score})>[];
  for (var name in candidates) {
    var score = _scoreCandidate(name, target);
    scored.add((name: name, score: score));
  }
  scored.sort((a, b) {
    var byScore = a.score.compareTo(b.score);
    if (byScore != 0) return byScore;
    return a.name.compareTo(b.name);
  });
  return [for (var entry in scored.take(maxRelationReferenceFixes)) entry.name];
}

int _scoreCandidate(String candidate, String? target) {
  if (target == null || target.isEmpty) {
    return candidate.length;
  }
  if (candidate == target) return 0;
  if (candidate.startsWith(target)) return 1;
  if (candidate.contains(target)) return 2;
  return 10 + _levenshtein(candidate, target);
}

int _levenshtein(String a, String b) {
  if (a == b) return 0;
  if (a.isEmpty) return b.length;
  if (b.isEmpty) return a.length;

  var prev = List<int>.generate(b.length + 1, (i) => i);
  var curr = List<int>.filled(b.length + 1, 0);

  for (var i = 1; i <= a.length; i++) {
    curr[0] = i;
    var ca = a.codeUnitAt(i - 1);
    for (var j = 1; j <= b.length; j++) {
      var cb = b.codeUnitAt(j - 1);
      var cost = ca == cb ? 0 : 1;
      var deletion = prev[j] + 1;
      var insertion = curr[j - 1] + 1;
      var substitution = prev[j - 1] + cost;
      var best = deletion < insertion ? deletion : insertion;
      if (substitution < best) best = substitution;
      curr[j] = best;
    }
    var swap = prev;
    prev = curr;
    curr = swap;
  }

  return prev[b.length];
}
