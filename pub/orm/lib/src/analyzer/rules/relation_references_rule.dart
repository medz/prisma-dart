import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/diagnostic/diagnostic.dart' show DiagnosticMessage;
import 'package:analyzer/error/error.dart';
// ignore: implementation_imports
import 'package:analyzer/src/diagnostic/diagnostic.dart'
    show DiagnosticMessageImpl;

import '../relation_utils.dart';

class RelationReferencesRule extends MultiAnalysisRule {
  static const LintCode invalidLiteral = LintCode(
    'orm_relation_invalid_reference',
    'Relation references must be string literals.',
    correctionMessage: 'Use a string literal field name.',
    severity: DiagnosticSeverity.ERROR,
  );

  static const LintCode unknownField = LintCode(
    'orm_relation_unknown_reference',
    "Unknown reference field '{0}' in @Relation.",
    correctionMessage: 'Use a field declared on the same record.',
    severity: DiagnosticSeverity.ERROR,
  );

  RelationReferencesRule()
    : super(
        name: 'orm_relation_references',
        description:
            'Ensure @Relation(references: ...) uses non-relation fields declared on the same record.',
      );

  @override
  List<LintCode> get diagnosticCodes => [invalidLiteral, unknownField];

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addGenericTypeAlias(this, _Visitor(this, context));
  }

  void reportInvalid(AstNode node) {
    reportAtNode(node, diagnosticCode: invalidLiteral);
  }

  void reportUnknown(
    AstNode node,
    String name, {
    List<DiagnosticMessage>? contextMessages,
  }) {
    reportAtNode(
      node,
      diagnosticCode: unknownField,
      arguments: [name],
      contextMessages: contextMessages,
    );
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final RelationReferencesRule rule;
  final RuleContext context;

  _Visitor(this.rule, this.context);

  @override
  void visitGenericTypeAlias(GenericTypeAlias node) {
    if (findModelAnnotation(node.metadata) == null) return;

    var record = node.type;
    if (record is! RecordTypeAnnotation) return;

    var namedFields = record.namedFields?.fields;
    if (namedFields == null || namedFields.isEmpty) return;

    var availableNamesList = collectNonRelationRecordFieldNamesInOrder(record);
    var availableNames = availableNamesList.toSet();
    for (var field in namedFields) {
      var relation = findRelationAnnotation(field.metadata);
      if (relation == null) continue;

      var referencesExpression = findReferencesExpression(relation);
      if (referencesExpression == null) continue;

      var entries = extractReferenceEntries(referencesExpression);
      for (var entry in entries) {
        var value = entry.value;
        if (value == null) {
          rule.reportInvalid(entry.node);
          continue;
        }
        if (!availableNames.contains(value)) {
          rule.reportUnknown(
            entry.node,
            value,
            contextMessages: _allowedFieldsContextMessages(
              entry.node,
              availableNamesList,
              context,
            ),
          );
        }
      }
    }
  }
}

List<DiagnosticMessage> _allowedFieldsContextMessages(
  AstNode node,
  List<String> allowed,
  RuleContext context,
) {
  var message = allowed.isEmpty
      ? 'Allowed fields: (none).'
      : 'Allowed fields: ${allowed.join(', ')}.';
  var filePath =
      context.currentUnit?.file.path ?? context.definingUnit.file.path;
  return [
    DiagnosticMessageImpl(
      filePath: filePath,
      offset: node.offset,
      length: node.length,
      message: message,
      url: null,
    ),
  ];
}
