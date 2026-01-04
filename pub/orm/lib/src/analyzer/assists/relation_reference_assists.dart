import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:analysis_server_plugin/edit/dart/dart_fix_kind_priority.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer_plugin/utilities/assist/assist.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';

import '../relation_suggestions.dart';
import '../relation_utils.dart';

class ReplaceWithClosestRelationReferenceAssist
    extends ResolvedCorrectionProducer {
  static const AssistKind _kind = AssistKind(
    'orm.assist.replaceRelationReference',
    DartFixKindPriority.standard,
    "Replace with '{0}'.",
  );

  String? _replacement;

  ReplaceWithClosestRelationReferenceAssist({required super.context});

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

  @override
  AssistKind get assistKind => _kind;

  @override
  List<String> get assistArguments => [_replacement ?? ''];

  @override
  Future<void> compute(ChangeBuilder builder) async {
    var literal = _findStringLiteral(node);
    if (literal == null) return;

    var relationContext = _findRelationContext(literal);
    if (relationContext == null) return;
    if (!_isWithin(relationContext.relation, literal)) return;

    var candidates = rankReferenceCandidates(
      collectNonRelationRecordFieldNamesInOrder(relationContext.record),
      literal.value,
      limit: 1,
    );
    if (candidates.isEmpty) return;

    var chosen = candidates.first;
    if (chosen == literal.value) return;

    _replacement = chosen;
    var replacement = _formatLiteral(literal, chosen);

    await builder.addDartFileEdit(file, (builder) {
      builder.addSimpleReplacement(
        SourceRange(literal.offset, literal.length),
        replacement,
      );
    });
  }
}

class FillRelationReferencesAssist extends ResolvedCorrectionProducer {
  static const AssistKind _kind = AssistKind(
    'orm.assist.fillRelationReferences',
    DartFixKindPriority.standard - 1,
    'Fill references from record fields.',
  );

  FillRelationReferencesAssist({required super.context});

  @override
  CorrectionApplicability get applicability =>
      CorrectionApplicability.singleLocation;

  @override
  AssistKind get assistKind => _kind;

  @override
  Future<void> compute(ChangeBuilder builder) async {
    var relationContext = _findRelationContext(node);
    if (relationContext == null) return;

    var fields = collectNonRelationRecordFieldNamesInOrder(
      relationContext.record,
    );
    if (fields.isEmpty) return;

    var setLiteral = _formatSetLiteral(fields);
    var referencesExpression = findReferencesExpression(
      relationContext.relation,
    );

    await builder.addDartFileEdit(file, (builder) {
      if (referencesExpression != null) {
        builder.addSimpleReplacement(
          SourceRange(referencesExpression.offset, referencesExpression.length),
          setLiteral,
        );
        return;
      }

      var arguments = relationContext.relation.arguments;
      if (arguments != null) {
        var insertOffset = arguments.rightParenthesis.offset;
        var prefix = arguments.arguments.isEmpty ? '' : ', ';
        builder.addSimpleInsertion(
          insertOffset,
          '${prefix}references: $setLiteral',
        );
        return;
      }

      builder.addSimpleInsertion(
        relationContext.relation.end,
        '(references: $setLiteral)',
      );
    });
  }
}

class _RelationContext {
  final RecordTypeAnnotationNamedField field;
  final RecordTypeAnnotation record;
  final GenericTypeAlias alias;
  final Annotation relation;

  _RelationContext({
    required this.field,
    required this.record,
    required this.alias,
    required this.relation,
  });
}

_RelationContext? _findRelationContext(AstNode node) {
  var field = node.thisOrAncestorOfType<RecordTypeAnnotationNamedField>();
  if (field == null) return null;

  var relation = findRelationAnnotation(field.metadata);
  if (relation == null) return null;

  var record = field.thisOrAncestorOfType<RecordTypeAnnotation>();
  if (record == null) return null;

  var alias = field.thisOrAncestorOfType<GenericTypeAlias>();
  if (alias == null || findModelAnnotation(alias.metadata) == null) return null;

  return _RelationContext(
    field: field,
    record: record,
    alias: alias,
    relation: relation,
  );
}

SimpleStringLiteral? _findStringLiteral(AstNode node) {
  var literal = node.thisOrAncestorOfType<StringLiteral>();
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

String _formatSetLiteral(List<String> fields) {
  var body = fields.map((name) => "'$name'").join(', ');
  return '{$body}';
}

bool _isWithin(AstNode parent, AstNode child) {
  return parent.offset <= child.offset && child.end <= parent.end;
}
