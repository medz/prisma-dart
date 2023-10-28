import 'package:orm/generator_helper.dart';

class Generator {
  final GeneratorOptions options;

  Generator(this.options);

  Future<void> handle() async {
    options.dmmf.datamodel.enums;
  }
}
