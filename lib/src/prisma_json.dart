import 'package:orm/orm.dart';

class PrismaJson implements JsonConvertible<Object> {
  final Object value;

  const PrismaJson(this.value);

  @override
  Object toJson() => value;
}
