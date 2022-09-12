import 'package:code_builder/code_builder.dart' as code_builder;
import 'package:orm/dmmf.dart' as dmmf;
import 'package:orm/src/runtime/language_keyword.dart';

import 'generator_options.dart';
import 'utils/schema_type.dart';

class SchemaBuilder {
  final GeneratorOptions options;
  final code_builder.LibraryBuilder library;

  const SchemaBuilder(this.options, this.library);

  /// Build schema.
  void build() {
    _EnumBuilder(library, options.dmmf.schema.enumTypes).build();
    _InputObjectTypesBuilder(library, options.dmmf.schema.inputObjectTypes)
        .build();
  }
}

class _InputObjectTypesBuilder {
  final code_builder.LibraryBuilder library;
  final dmmf.InputObjectTypes inputObjectTypes;

  const _InputObjectTypesBuilder(this.library, this.inputObjectTypes);

  /// Build input object types.
  void build() {
    _buildInputTypes(inputObjectTypes.prisma ?? []);
    _buildInputTypes(inputObjectTypes.model ?? []);
  }

  /// Build input types.
  void _buildInputTypes(List<dmmf.InputType> inputs) {
    for (final dmmf.InputType input in inputs) {
      library.body.add(code_builder.Class((code_builder.ClassBuilder updates) {
        updates.name = languageKeywordEncode(input.name);
        updates.implements.add(
            code_builder.Reference('JsonSerializable', 'package:orm/orm.dart'));

        _constructorBuilder(updates, input);
        _fieldsBuilder(updates, input);
        _toJsonBuilder(updates, input);
      }));
    }
  }

  /// Input object to Json builder.
  void _toJsonBuilder(code_builder.ClassBuilder updates, dmmf.InputType input) {
    updates.methods
        .add(code_builder.Method((code_builder.MethodBuilder updates) {
      updates.annotations.add(code_builder.Reference('override'));
      updates.name = 'toJson';
      updates.returns = code_builder.TypeReference(
          (code_builder.TypeReferenceBuilder updates) {
        updates.symbol = 'Map';
        updates.types.addAll([
          code_builder.Reference('String'),
          code_builder.Reference('dynamic'),
        ]);
      });

      updates.body = code_builder.Block((code_builder.BlockBuilder updates) {
        updates.statements.add(code_builder.Code('return <String, dynamic>'));
        updates.statements.add(code_builder.Code('{'));

        for (final dmmf.SchemaArg field in input.fields) {
          updates.statements.add(code_builder.Code(
              "'${field.name}': ${languageKeywordEncode(field.name)},"));
        }

        updates.statements.add(code_builder.Code('};'));
      });
    }));
  }

  /// Fields builder.
  void _fieldsBuilder(
      code_builder.ClassBuilder updates, dmmf.InputType inputType) {
    for (final dmmf.SchemaArg field in inputType.fields) {
      updates.fields
          .add(code_builder.Field((code_builder.FieldBuilder updates) {
        updates.modifier = code_builder.FieldModifier.final$;
        updates.name = languageKeywordEncode(field.name);
        updates.type = schemaTypeResolver(field.inputTypes);

        if (!field.isRequired) {
          updates.type = code_builder.Reference(
              '${updates.type?.symbol}?', updates.type?.url);
        }

        if (field.comment != null) {
          updates.docs.add(field.comment!);
        }
      }));
    }
  }

  /// Constructor builder.
  void _constructorBuilder(
      code_builder.ClassBuilder updates, dmmf.InputType inputType) {
    final code_builder.Constructor constructor =
        code_builder.Constructor((code_builder.ConstructorBuilder updates) {
      updates.constant = true;

      for (final dmmf.SchemaArg field in inputType.fields) {
        final code_builder.Parameter parameter =
            code_builder.Parameter((code_builder.ParameterBuilder updates) {
          updates.named = true;
          updates.toThis = true;
          updates.required = field.isRequired;
          updates.name = languageKeywordEncode(field.name);

          if (field.comment != null) {
            updates.docs.add(field.comment!);
          }
        });

        updates.optionalParameters.add(parameter);
      }
    });

    updates.constructors.add(constructor);
  }
}

class _EnumBuilder {
  final code_builder.LibraryBuilder library;
  final dmmf.EnumTypes enumTypes;

  const _EnumBuilder(this.library, this.enumTypes);

  static final Iterable<String> ignores =
      ['TransactionIsolationLevel'].map((e) => e.toLowerCase());

  /// Build enum.
  void build() {
    _buildEnum(enumTypes.prisma);
    _buildEnum(enumTypes.model ?? []);
  }

  /// Build enum of [List<SchemaEnum>].
  void _buildEnum(List<dmmf.SchemaEnum> enums) {
    for (final dmmf.SchemaEnum element in enums) {
      // If enum is ignored, then skip.
      if (ignores.contains(element.name.toLowerCase())) {
        library.directives.add(code_builder.Directive.export(
          'package:orm/orm.dart',
          show: [element.name],
        ));
        continue;
      }

      library.body.add(code_builder.Enum((code_builder.EnumBuilder updates) {
        updates.name = languageKeywordEncode(element.name);
        updates.values.addAll(element.values.map(_buildEnumValue));
      }));
    }
  }

  /// Build enum value.
  code_builder.EnumValue _buildEnumValue(String value) {
    return code_builder.EnumValue((code_builder.EnumValueBuilder updates) {
      updates.name = languageKeywordEncode(value);
    });
  }
}
