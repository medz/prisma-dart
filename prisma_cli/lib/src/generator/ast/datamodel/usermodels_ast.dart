import 'package:prisma_cli/src/generator/ast/ast.dart';

import '../../../dmmf/datamodel/user_model.dart';

class UsermodelsAst extends CodeableAst {
  UsermodelsAst(super.ast);

  @override
  String get codeString {
    final StringBuffer code = StringBuffer();
    for (final model in ast.dmmf.datamodel.models) {
      code.writeln(
          '@JsonSerializable(explicitToJson: true, createFactory: true, createToJson: true)');
      code.writeln('class ${model.name} {');
      code.writeln(_buildConstructor(model));
      code.writeln(_buildFields(model));
      code.writeln(_buildFromJson(model));
      code.writeln(_buildToJson(model));
      code.writeln('}');
    }

    return code.toString();
  }

  /// Build toJson method.
  String _buildToJson(UserModel model) {
    final StringBuffer code = StringBuffer();
    code.writeln(
        '  Map<String, dynamic> toJson() => _\$${model.name}ToJson(this);');
    return code.toString();
  }

  /// Build the fromJson factory method.
  String _buildFromJson(UserModel model) {
    final StringBuffer code = StringBuffer();
    code.writeln(
        '  factory ${model.name}.fromJson(Map<String, dynamic> json) =>');
    code.writeln('    _\$${model.name}FromJson(json);');
    return code.toString();
  }

  /// Builds the constructor for the model.
  String _buildConstructor(UserModel model) {
    final StringBuffer code = StringBuffer();
    code.writeln('  const ${model.name}({');
    for (final field in model.fields) {
      code.writeln('    this.${field.name},');
    }
    code.writeln('  });');
    return code.toString();
  }

  /// Build model fields.
  String _buildFields(UserModel model) {
    final StringBuffer code = StringBuffer();
    for (final field in model.fields) {
      code.writeln('  final ${scalar(field.type)}? ${field.name};');
    }

    return code.toString();
  }
}
