import 'package:code_builder/code_builder.dart' as code_builder;
import 'package:orm/src/runtime/language_keyword.dart';
import 'package:prisma_dmmf/prisma_dmmf.dart' as dmmf;

import 'generator_options.dart';
import '../../generator/scalars.dart';

class SchemaBuilder {
  final GeneratorOptions options;
  final code_builder.LibraryBuilder library;

  const SchemaBuilder(this.options, this.library);

  /// Build schema.
  void build() {
    _OutputObjectTypesBuilder(
      library,
      options.dmmf.schema.outputObjectTypes,
      options,
    ).build();
  }
}

class _OutputObjectTypesBuilder {
  final code_builder.LibraryBuilder library;
  final dmmf.OutputObjectTypes outputObjectTypes;
  final GeneratorOptions options;

  const _OutputObjectTypesBuilder(
      this.library, this.outputObjectTypes, this.options);

  /// Build output object types.
  void build() {
    _buildOutputTypes(outputObjectTypes.prisma);
    _buildOutputTypes(outputObjectTypes.model ?? []);
  }

  /// Build output object types.
  void _buildOutputTypes(List<dmmf.OutputType> outputTypes) {
    for (final dmmf.OutputType type in outputTypes) {
      // If type name is query or mutation, skip it.
      if (['query', 'mutation'].contains(type.name.toLowerCase())) continue;

      library.body.add(code_builder.Class((code_builder.ClassBuilder builder) {
        builder.annotations.add(
          code_builder.TypeReference(
              (code_builder.TypeReferenceBuilder updates) {
            updates.symbol = 'JsonSerializable';
          }).newInstance(
            [],
            {
              'createToJson': code_builder.literalTrue,
              'createFactory': code_builder.literalTrue,
              'explicitToJson': code_builder.literalTrue,
            },
          ),
        );
        builder.name = dartClassnameFixer(type.name);
        builder.implements.add(
            code_builder.Reference('JsonSerializable', 'package:orm/orm.dart'));

        // Fields builder
        _fieldsBuilder(type.fields, builder);

        // Constructor builder
        _constructorBuilder(type.fields, builder);

        builder.constructors.add(code_builder.Constructor(
          (code_builder.ConstructorBuilder builder) {
            builder.name = 'fromJson';
            builder.requiredParameters.add(code_builder.Parameter(
              (code_builder.ParameterBuilder builder) {
                builder.name = 'json';
                builder.type = code_builder.Reference('Map<String, dynamic>');
              },
            ));

            builder.body = code_builder.Code(
                '_\$${dartClassnameFixer(type.name)}FromJson(json)');
            builder.lambda = true;

            builder.factory = true;
          },
        ));

        builder.methods.add(code_builder.Method(
          (code_builder.MethodBuilder builder) {
            builder.name = 'toJson';
            builder.returns = code_builder.Reference('Map<String, dynamic>');
            builder.body = code_builder.Code(
                '_\$${dartClassnameFixer(type.name)}ToJson(this)');
            builder.lambda = true;
            builder.annotations.add(code_builder.Reference('override'));
          },
        ));
      }));
    }
  }

  /// Check the field is skip.
  bool _fieldIsModel(String name) {
    return options.dmmf.datamodel.models
        .where((element) => element.name == name)
        .isNotEmpty;
  }

  /// Constructor builder.
  void _constructorBuilder(
      List<dmmf.SchemaField> fields, code_builder.ClassBuilder classBuilder) {
    classBuilder.constructors
        .add(code_builder.Constructor((constructorBuilder) {
      constructorBuilder.constant = true;
      for (final dmmf.SchemaField field in fields) {
        if (_fieldIsSkip(field, classBuilder.name)) continue;

        constructorBuilder.optionalParameters.updates.fields.add(code.Field((updates) {
          updates
            ..name = 'originalName'
            ..type = code.refer('String').nullable
            ..modifier = code.FieldModifier.final$
            ..annotations.add(code.refer('override'));
        }));(code_builder.Parameter(
            (code_builder.ParameterBuilder parameterBuilder) {
          parameterBuilder.name = languageKeywordEncode(field.name);
          parameterBuilder.named = true;
          parameterBuilder.toThis = true;
          parameterBuilder.required = field.isNullable == false;
        }));
      }
    }));
  }

  /// Build fields.
  void _fieldsBuilder(
      List<dmmf.SchemaField> fields, code_builder.ClassBuilder updates) {
    for (final dmmf.SchemaField field in fields) {
      if (_fieldIsSkip(field, updates.name)) continue;

      updates.fields
          .add(code_builder.Field((code_builder.FieldBuilder updates) {
        updates.name = languageKeywordEncode(field.name);
        updates.modifier = code_builder.FieldModifier.final$;
        updates.type = scalar(field.outputType, field.isNullable ?? true);

        final Map<String, code_builder.Expression> annotationNamedArguments = {
          'name': code_builder.literalString(field.name),
        };
        if (field.outputType.type.toLowerCase() == 'datetime') {
          annotationNamedArguments['toJson'] =
              code_builder.refer('dateTimeToJson');
        }

        updates.annotations.add(code_builder
            .refer('JsonKey')
            .newInstance([], annotationNamedArguments));

        if (field.documentation != null) {
          updates.docs.add(field.documentation!);
        }
      }));
    }
  }

  /// Check field is skip.
  bool _fieldIsSkip(dmmf.SchemaField field, [String? classname]) {
    if (_fieldIsModel(field.outputType.type)) return true;

    if (field.name == '_count' &&
        classname != null &&
        _fieldIsModel(classname)) {
      return true;
    }

    return false;
  }
}
