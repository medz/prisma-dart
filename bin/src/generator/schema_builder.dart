import 'package:code_builder/code_builder.dart' as code_builder;
import 'package:orm/dmmf.dart' as dmmf;
import 'package:orm/src/runtime/language_keyword.dart';

import 'generator_options.dart';
import 'utils/dart_style.dart';
import 'utils/scalar.dart';
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
            updates.url = 'package:json_annotation/json_annotation.dart';
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

        if (field.name != updates.name) {
          updates.annotations.add(code_builder.TypeReference(
              (code_builder.TypeReferenceBuilder updates) {
            updates.symbol = 'JsonKey';
            updates.url = 'package:json_annotation/json_annotation.dart';
          }).newInstance([], {
            'name': code_builder.literalString(field.name),
          }));
        }

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

        // for (final dmmf.SchemaArg arg in input.fields) {
        //   arg.inputTypes;
        //   final Iterable<code_builder.Reference> types = buildSchemaTypes(
        //       arg.inputTypes, arg.isNullable || !arg.isRequired);
        //   if (types.length == 1) {
        //     updates.constructors.add(code_builder.Constructor((c) {}));
        //   }

        //   // for (final code_builder.Reference type in types) {}
        // }

        // updates.annotations.add(
        //   code_builder.TypeReference(
        //       (code_builder.TypeReferenceBuilder updates) {
        //     updates.symbol = 'JsonSerializable';
        //     updates.url = 'package:json_annotation/json_annotation.dart';
        //   }).newInstance(
        //     [],
        //     {
        //       'createToJson': code_builder.literalTrue,
        //       'createFactory': code_builder.literalTrue,
        //       'explicitToJson': code_builder.literalTrue,
        //     },
        //   ),
        // );

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

        // updates.methods.add(code_builder.Method(
        //   (code_builder.MethodBuilder builder) {
        //     builder.name = 'toJson';
        //     builder.returns = code_builder.Reference('Map<String, dynamic>');
        //     builder.body = code_builder.Code('_\$${updates.name}ToJson(this)');
        //     builder.lambda = true;
        //     builder.annotations.add(code_builder.Reference('override'));
        //   },
        // ));

        _constructorBuilder(updates, input);
        // _fieldsBuilder(updates, input);
      }));
    }
  }

  /// Fields builder.
  void _fieldsBuilder(
      code_builder.ClassBuilder updates, dmmf.InputType inputType) {
    for (final dmmf.SchemaArg field in inputType.fields) {
      updates.fields
          .add(code_builder.Field((code_builder.FieldBuilder updates) {
        updates.annotations.add(code_builder.TypeReference(
            (code_builder.TypeReferenceBuilder updates) {
          updates.symbol = 'JsonKey';
          updates.url = 'package:json_annotation/json_annotation.dart';
        }).newInstance([], {
          'name': code_builder.literalString(field.name),
        }));

        updates.modifier = code_builder.FieldModifier.final$;
        updates.name = languageKeywordEncode(field.name);
        updates.type = schemaTypeResolver(
            field.inputTypes, field.isNullable == true || !field.isRequired);

        if (field.comment != null) {
          updates.docs.add(field.comment!);
        }
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
          // updates.toThis = true;
          parameterBuilder.required = field.isRequired;
          parameterBuilder.name = languageKeywordEncode(field.name);
          parameterBuilder.type = schemaArgBuilder(updates, field);

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
      return schemaTypeResolver(arg.inputTypes, nullable);
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
              updates.type = schemaTypeResolver([type], false);
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

        // Add toJson method.
        // updates.methods
        //     .add(code_builder.Method((code_builder.MethodBuilder builder) {
        //   builder.name = 'toJson';
        //   builder.returns = code_builder.Reference('Map<String, dynamic>');
        //   builder.body = code_builder.Code('_\$${updates.name}ToJson(this)');
        //   builder.lambda = true;
        //   builder.annotations.add(code_builder.Reference('override'));
        // }));
      }),
    );

    return code_builder.refer(classname + (nullable ? '?' : ''));
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
        updates.name = dartClassnameFixer(element.name);
        updates.values.addAll(element.values.map(_buildEnumValue));
      }));
    }
  }

  /// Build enum value.
  code_builder.EnumValue _buildEnumValue(String value) {
    return code_builder.EnumValue((code_builder.EnumValueBuilder updates) {
      updates.name = languageKeywordEncode(value);

      if (updates.name != value) {
        updates.annotations.add(code_builder.TypeReference((updates) {
          updates.symbol = 'JsonValue';
          updates.url = 'package:json_annotation/json_annotation.dart';
        }).newInstance([code_builder.literalString(value)]));
      }
    });
  }
}
