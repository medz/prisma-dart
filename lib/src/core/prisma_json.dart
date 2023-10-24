import 'json_convertible.dart';

class PrismaJson implements JsonConvertible {
  final dynamic value;

  const PrismaJson(this.value);

  @override
  toJson() => value;
}
