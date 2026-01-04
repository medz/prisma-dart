import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';

class ReferenceEntry {
  final String? value;
  final AstNode node;

  ReferenceEntry(this.value, this.node);
}

Annotation? findRelationAnnotation(NodeList<Annotation> metadata) {
  for (var annotation in metadata) {
    if (_isRelationAnnotation(annotation)) {
      return annotation;
    }
  }
  return null;
}

Annotation? findModelAnnotation(NodeList<Annotation> metadata) {
  for (var annotation in metadata) {
    if (_isModelAnnotation(annotation)) {
      return annotation;
    }
  }
  return null;
}

Expression? findReferencesExpression(Annotation annotation) {
  var arguments = annotation.arguments;
  if (arguments == null) return null;

  for (var argument in arguments.arguments) {
    if (argument is NamedExpression &&
        argument.name.label.name == 'references') {
      return argument.expression;
    }
  }

  if (arguments.arguments.isNotEmpty) {
    var first = arguments.arguments.first;
    if (first is! NamedExpression) {
      return first;
    }
  }

  return null;
}

Set<String> collectNonRelationFieldNames(ClassDeclaration declaration) {
  var names = <String>{};
  for (var member in declaration.members) {
    if (member is FieldDeclaration) {
      if (member.isStatic) continue;
      for (var variable in member.fields.variables) {
        names.add(variable.name.lexeme);
      }
      continue;
    }
    if (member is MethodDeclaration) {
      if (!member.isGetter || member.isStatic) continue;
      if (findRelationAnnotation(member.metadata) != null) continue;
      names.add(member.name.lexeme);
    }
  }
  return names;
}

Set<String> collectNonRelationRecordFieldNames(RecordTypeAnnotation record) {
  var names = <String>{};
  var namedFields = record.namedFields?.fields;
  if (namedFields == null) return names;
  for (var field in namedFields) {
    if (findRelationAnnotation(field.metadata) != null) continue;
    names.add(field.name.lexeme);
  }
  return names;
}

List<ReferenceEntry> extractReferenceEntries(Expression expression) {
  if (expression is SetOrMapLiteral) {
    if (expression.isMap) {
      return [ReferenceEntry(null, expression)];
    }
    return _entriesFromCollectionElements(expression.elements);
  }
  if (expression is ListLiteral) {
    return _entriesFromCollectionElements(expression.elements);
  }
  return [ReferenceEntry(null, expression)];
}

bool _isRelationAnnotation(Annotation annotation) {
  var element = annotation.element;
  if (element is ConstructorElement) {
    var enclosing = element.enclosingElement;
    if (enclosing.name != 'Relation') return false;
    return true;
  }

  var name = annotation.name;
  if (name is SimpleIdentifier) {
    return name.name == 'Relation';
  }
  if (name is PrefixedIdentifier) {
    return name.identifier.name == 'Relation';
  }
  return false;
}

bool _isModelAnnotation(Annotation annotation) {
  var element = annotation.element;
  if (element is PropertyAccessorElement) {
    if (element.name != 'model') return false;
    return true;
  }
  if (element is TopLevelVariableElement) {
    if (element.name != 'model') return false;
    return true;
  }

  var name = annotation.name;
  if (name is SimpleIdentifier) {
    return name.name == 'model';
  }
  if (name is PrefixedIdentifier) {
    return name.identifier.name == 'model';
  }
  return false;
}

List<ReferenceEntry> _entriesFromCollectionElements(
  Iterable<CollectionElement> elements,
) {
  var entries = <ReferenceEntry>[];
  for (var element in elements) {
    if (element is Expression) {
      entries.add(_entryFromExpression(element));
    } else {
      entries.add(ReferenceEntry(null, element));
    }
  }
  return entries;
}

ReferenceEntry _entryFromExpression(Expression expression) {
  if (expression is StringLiteral) {
    return ReferenceEntry(expression.stringValue, expression);
  }
  return ReferenceEntry(null, expression);
}
