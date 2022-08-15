import 'dart:convert';

import 'package:orm/orm.dart';

class Entity {
  final String name;
  final bool isScaler;
  final Object? scaler;
  final List<Entity>? entity;

  Entity(this.name, this.isScaler, this.scaler, this.entity);
}

class Input {
  final String name;
  final List<Field> fields;
  final Object? value;
  final bool wrapList;

  Input(this.name, this.value, this.fields, this.wrapList);
}

class Output {
  final String name;
  final List<Input> input;
  final List<Output> output;

  const Output(this.name, this.input, this.output);
}

class Field {
  final String name;
  final bool list;
  final bool wrapList;
  final Object? value;
  final List<Field>? fields;

  Field(this.name, this.list, this.wrapList, this.value, this.fields);
}

abstract class ToField {
  const ToField();
  List<Field> toFields();
}

class Query {
  final Engine engine;
  final String operation;
  // describe the operation useful for tracking
  final String name;
  final String method;
  final String model;
  final List<Entity> entity;
  final List<Input> input = [];
  final List<Output> output;
  late DateTime startTime;

  Query({
    required this.engine,
    required this.operation,
    required this.name,
    required this.method,
    required this.model,
    required this.entity,
    required this.output,
  });

  String build() {
    return """$operation {result: ${buildInner()}}""";
  }

  String buildInner() {
    var entityCode = buildEntity(entity, false, true);
    if(entityCode=="(),") entityCode = "";
    return """$method$model$entityCode ${buildOutputs(output)}""";
  }

  String buildEntity(List<Entity> entity, bool wrap, bool start) {
    if (entity.isEmpty) return "";
    final builder = StringBuffer("");
    if (start) builder.write("(");
    if (wrap) builder.write("{");
    for (var item in entity) {
      if ((item.entity == null || item.entity!.isEmpty) && item.scaler == null) continue;
      builder.write(item.name);
      builder.write(":");
      if (item.isScaler) {
        builder.write(jsonEncode(item.scaler));
      } else {
        builder.write(buildEntity(item.entity!, true, false));
      }
    }
    if (wrap) builder.write("},");
    if (start) builder.write("),");
    return builder.toString();
  }

  String buildInputs(List<Input> input) {
    if (input.isEmpty) return "";
    final builder = StringBuffer("(");
    for (var val in input) {
      if (val.fields.isEmpty && val.value == null) continue;
      builder.write(val.name);
      builder.write(":");
      if (val.value != null) {
        builder.write(jsonEncode(val.value));
      } else {
        if (val.wrapList) {
          builder.write("[");
          builder.write(buildFields(val.wrapList, val.wrapList, val.fields));
          builder.write("]");
        }
      }
      builder.write(",");
    }
    builder.write(")");
    final res = builder.toString();
    if (res == "()") return "";
    return res;
  }

  String buildOutputs(List<Output> output) {
    if (output.isEmpty) return "";

    final builder = StringBuffer("{");
    for (var val in output) {
      builder.write(val.name);
      builder.write(" ");
      if (val.input.isNotEmpty) {
        builder.write(buildInputs(val.input));
      }
      if (val.output.isNotEmpty) {
        builder.write(buildOutputs(val.output));
      }
    }
    builder.write("}");
    return builder.toString();
  }

  String buildFields(bool list, bool wrapList, List<Field> fields) {
    final finals = <Field>[];
    final uniqueNames = <String>[];

    final uniques = <String, Field>{};

    for (var i = 0; i < fields.length; i++) {
      final field = fields[i];
      if (uniques.containsKey(field.name)) {
        const noField = ["AND", "OR", "NOT"];
        if (field.fields != null &&
            noField.every((element) => element != field.name)) {
          uniques[field.name]!.fields!.addAll(field.fields!);
        } else {
          finals.add(field);
        }
      } else {
        uniques[field.name] = field;
        uniqueNames.add(field.name);
      }
    }

    for (var name in uniqueNames) {
      finals.add(uniques[name]!);
    }

    final builder = StringBuffer();
    if (!list) builder.write("{");

    for (var f in finals) {
      if ((f.fields == null || f.fields!.isEmpty) && f.value == null) continue;
      if (wrapList) {
        builder.write("{");
      }
      if (f.name.isNotEmpty) {
        builder.write(f.name);
        builder.write(":");
      }
      if (f.list) {
        builder.write("[");
      }
      if (f.fields != null && f.fields!.isNotEmpty) {
        builder.write(buildFields(f.list, f.wrapList, f.fields!));
      } else if (f.value != null) {
        builder.write(jsonEncode(f.value));
      }

      if (f.list) {
        builder.write("]");
      }
      if (wrapList) {
        builder.write("}");
      }
      builder.write(",");
    }

    if (!list) {
      builder.write("}");
    }
    return builder.toString();
  }

  Future<GQLResponse> exec() {
    print(build());
    final payload = GQLRequest(build(), {});
    return engine.request(payload)..then((value) => print(value.data?.result));
  }
}
