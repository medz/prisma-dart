import 'dart:convert';

import 'package:orm/orm.dart';

class Input {
  final String name;
  final List<Field>? fields;
  final Object? value;
  final bool wrapList;

  Input(
    this.name,
    this.wrapList,
    this.value,
    this.fields,
  );
}

class Output {
  final String name;

  const Output(this.name);
}

class Field {
  final String name;

  // List saves whether the fields is a list of items
  final bool list;

  // WrapList saves whether the a list field should be wrapped in an object
  final bool wrapList;
  final Object? value;
  final List<Field>? fields;

  Field(this.name, this.list, this.wrapList, this.value, this.fields);
}

abstract class ToField {
  List<Field> toFields();
}

class Query {
  final Engine engine;
  final String operation;
  // describe the operation useful for tracking
  final String name;
  final String method;
  final String model;
  final List<Input> input;
  final List<Output> output;
  late DateTime startTime;

  Query({
    required this.engine,
    required this.operation,
    required this.name,
    required this.method,
    required this.model,
    required this.input,
    required this.output,
  });

  String build() {
    return """$operation {result: ${buildInner()}}""";
  }

  String buildInner() {
    return """$method$model${buildInputs(input)} ${buildOutputs(output)}""";
  }

  String buildInputs(List<Input> input) {
    if (input.isEmpty) return "";
    final builder = StringBuffer("(");
    for (int i = 0; i < input.length; i++) {
      var val = input[i];
      if ((val.fields ?? []).isEmpty && val.value == null) continue;
      builder.write(val.name);
      builder.write(":");
      if (val.value != null) {
        builder.write(jsonEncode(val.value));
      } else {
        if (val.wrapList) {
          builder.write("[");
        }
        builder.write(buildFields(val.wrapList, val.wrapList, val.fields!));
        if (val.wrapList) {
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
        if (field.fields != null &&
            field.name != "AND" &&
            field.name != "OR" &&
            field.name != "NOT") {
          if (uniques[field.name]!.fields == field.fields)
            continue; //TODO sometime we try to add a list to the same list
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
      // if (wrapList) {
      //   builder.write("{");
      // }
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
      // if (wrapList) {
      //   builder.write("}");
      // }
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

List<Field> toEnumsField(List<PrismaEnum> list) {
  return list.map((e) => Field("", false, false, e.value, null)).toList();
}

List<Field> toScalerField(List<Object> list) {
  return list.map((e) => Field("", false, false, e, null)).toList();
}

List<Field> toObjectField(List<ToField> list) {
  return list.map((e) => Field("", false, false, null, e.toFields())).toList();
}
