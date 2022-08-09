import 'package:prisma_cli/src/generator/ast/helper/dmmf_schema_helper.dart';
import 'package:prisma_cli/src/utils/naming_fix.dart';
import 'package:prisma_dmmf/prisma_dmmf.dart';

abstract class Ast {
  Ast(this.dmmf);
  final Document dmmf;
}

abstract class CodeableAst extends DMMFSchemaHelper {
  @override
  final Ast ast;
  CodeableAst(this.ast);

  String get codeString;

  /// Scalar resolve.
  String scalar(String value) {
    switch (value.toLowerCase()) {
      case 'decimal':
      case 'float':
        return 'double';
      case 'int':
        return 'int';
      case 'boolean':
        return 'bool';
      case "json":
        return 'Map<String,dynamic>';

      case "unsupported":
      case "bytes":
        return "dynamic"; //TODO
    }

    return value;
  }

  String addNullable(bool isNullable) {
    if (isNullable) return "? ";
    return " ";
  }

  String addRequired(bool isRequired) {
    if (isRequired) return "required ";
    return " ";
  }

  /// Field name resolver.
  String fieldName(String name) {
    return name.dartCase;
  }

  /// Class name resolver.
  String className(String name) {
    return name.dartClassCase;
  }

  /// Resolves the input type.
  String resolveInputType(List<SchemaType> inputTypes) {
    if (inputTypes.length == 1) {
      return scalar(inputTypes.first.type);
    }

    // remove duplicates
    final List<SchemaType> uniqueInputTypes = inputTypes.toSet().toList();
    if (uniqueInputTypes.length == 1) {
      return scalar(uniqueInputTypes.first.type);
    }

    // remove scalar
    final List<SchemaType> nonScalarInputTypes =
        uniqueInputTypes.where((element) => element.type != 'scalar').toList();
    if (nonScalarInputTypes.length == 1) {
      return scalar(nonScalarInputTypes.first.type);
    }

    return scalar(inputTypes.first.type);
  }

    String fieldSchemaArgTypeBuilder(SchemaArg field) {
    final String inputType = resolveInputType(field.inputTypes);
    final bool isList =
        field.inputTypes.where((element) => element.isList).isNotEmpty;
    if (isList) {
      return 'List<$inputType>';
    }

    return inputType;
  }

    /// Class field type builder.
  String schemaTypeTypeBuilder(SchemaType schemaType) {
    final object = schemaType.type;
    String type;
    if (object is String) {
      type = scalar(object);
    } else if (object is InputType) {
      type = className(object.name);
    } else if (object is SchemaEnum) {
      type = className(object.name);
    } else {
      throw ArgumentError('Unknown type $object');
    }
    if (schemaType.isList) {
      return 'List<$type>';
    }

    return type;
  }


}
