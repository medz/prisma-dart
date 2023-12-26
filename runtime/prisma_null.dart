import 'json_convertible.dart';

class PrismaNull implements JsonConvertible<Null> {
  const PrismaNull();

  @override
  Null toJson() => null;
}
