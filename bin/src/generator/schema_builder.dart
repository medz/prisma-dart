import 'package:code_builder/code_builder.dart' as code_builder;
import 'package:orm/src/runtime/language_keyword.dart';
import 'package:prisma_dmmf/prisma_dmmf.dart' as dmmf;

import 'generator_options.dart';
import 'utils/dart_style.dart';
import 'utils/scalar.dart';

class SchemaBuilder {
  final GeneratorOptions options;
  final code_builder.LibraryBuilder library;

  const SchemaBuilder(this.options, this.library);

  /// Build schema.
  void build() {
    _EnumBuilder(library, options.dmmf.schema.enumTypes).build();
    _InputObjectTypesBuilder(library, options.dmmf.schema.inputObjectTypes)
        .build();
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

        constructorBuilder.optionalParameters.add(code_builder.Parameter(
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
        updates.name = dartClassnameFixer(input.name);
        updates.implements.add(
            code_builder.Reference('JsonSerializable', 'package:orm/orm.dart'));
        updates.mixins.add(code_builder.Reference('_\$${updates.name}'));

        // Add freezed annotation.
        updates.annotations.add(code_builder.refer('freezed'));

        updates.constructors.add(code_builder.Constructor(
          (code_builder.ConstructorBuilder builder) {
            builder.name = 'fromJson';
            builder.requiredParameters.add(code_builder.Parameter(
              (code_builder.ParameterBuilder builder) {
                builder.name = 'json';
                builder.type = code_builder.Reference('Map<String, dynamic>');
              },
            ));

            builder.body =
                code_builder.Code('_\$${updates.name}FromJson(json)');
            builder.lambda = true;

            builder.factory = true;
          },
        ));

        _constructorBuilder(updates, input);
      }));
    }
  }

  /// Constructor builder.
  void _constructorBuilder(
      code_builder.ClassBuilder updates, dmmf.InputType inputType) {
    final code_builder.Constructor constructor = code_builder.Constructor(
        (code_builder.ConstructorBuilder constructorBuilder) {
      constructorBuilder.factory = true;
      constructorBuilder.constant = true;
      constructorBuilder.redirect = code_builder.refer('_${updates.name}');

      for (final dmmf.SchemaArg field in inputType.fields) {
        final code_builder.Parameter parameter = code_builder.Parameter(
            (code_builder.ParameterBuilder parameterBuilder) {
          parameterBuilder.named = true;
          parameterBuilder.required = field.isRequired;
          parameterBuilder.name = languageKeywordEncode(field.name);
          parameterBuilder.type = schemaArgBuilder(updates, field);

          final Map<String, code_builder.Expression> annotationNamedArguments =
              {
            'name': code_builder.literalString(field.name),
          };

          // If input types is only one, add toJson.
          if (field.inputTypes.length == 1 &&
              field.inputTypes.first.type.toLowerCase() == 'datetime') {
            annotationNamedArguments['toJson'] =
                code_builder.refer('dateTimeToJson');
          }

          parameterBuilder.annotations.add(code_builder
              .refer('JsonKey')
              .newInstance([], annotationNamedArguments));

          if (field.comment != null) {
            parameterBuilder.docs.add(field.comment!);
          }
        });

        constructorBuilder.optionalParameters.add(parameter);
      }
    });

    updates.constructors.add(constructor);
  }

  /// Build schema arg
  code_builder.Reference schemaArgBuilder(
      code_builder.ClassBuilder classBuilder, dmmf.SchemaArg arg) {
    final bool nullable = arg.isNullable == true || !arg.isRequired;
    if (arg.inputTypes.length == 1) {
      return scalar(arg.inputTypes.first, nullable);
    }

    final String classname = '${classBuilder.name}_${arg.name}';
    library.body.add(
      code_builder.Class((code_builder.ClassBuilder updates) {
        updates.name = classname;
        updates.annotations.add(code_builder.refer('freezed'));
        updates.mixins.add(code_builder.refer('_\$${updates.name}'));
        updates.implements.add(
            code_builder.Reference('JsonSerializable', 'package:orm/orm.dart'));

        for (final dmmf.SchemaType type in arg.inputTypes) {
          final code_builder.Constructor constructor = code_builder.Constructor(
              (code_builder.ConstructorBuilder constructorBuilder) {
            constructorBuilder.name =
                'with${languageKeywordEncode(type.type)}${type.isList ? 'List' : ''}';
            constructorBuilder.factory = true;
            constructorBuilder.constant = true;
            constructorBuilder.redirect = code_builder
                .refer('${updates.name}_${constructorBuilder.name}');

            constructorBuilder.requiredParameters.add(
                code_builder.Parameter((code_builder.ParameterBuilder updates) {
              updates.name = 'value';
              updates.type = scalar(type, false);

              // If the type is DateTime, add JsonKey annotation.
              if (type.type.toLowerCase() == 'datetime') {
                updates.annotations
                    .add(code_builder.refer('JsonKey').newInstance([], {
                  'toJson': code_builder.refer('dateTimeToJson'),
                }));
              }
            }));
          });

          updates.constructors.add(constructor);
        }

        // Add fromJson constructor.
        updates.constructors.add(code_builder.Constructor(
          (code_builder.ConstructorBuilder builder) {
            builder.name = 'fromJson';
            builder.requiredParameters.add(code_builder.Parameter(
              (code_builder.ParameterBuilder builder) {
                builder.name = 'json';
                builder.type = code_builder.Reference('Map<String, dynamic>');
              },
            ));

            builder.body =
                code_builder.Code('_\$${updates.name}FromJson(json)');
            builder.lambda = true;

            builder.factory = true;
          },
        ));
      }),
    );

    return code_builder.refer(classname + (nullable ? '?' : ''));
  }
}
