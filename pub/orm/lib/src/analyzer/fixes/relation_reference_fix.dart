import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/fixes/fixes.dart';

import '../relation_utils.dart';
import '../relation_suggestions.dart';

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

    var candidates = rankReferenceCandidates(
      collectNonRelationRecordFieldNamesInOrder(record),
      literal.value,
      limit: maxRelationReferenceFixes,
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
