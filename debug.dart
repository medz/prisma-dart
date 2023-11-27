import 'dart:convert';
import 'dart:io';

import 'package:orm/prisma_generator_helper/prisma_generator_helper.dart';

void main() {
  final dmmf = json.decode(
    File('dmmf.json').readAsStringSync(),
  );

  GeneratorOptions.fromJson(dmmf);
}
