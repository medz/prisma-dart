import 'package:orm/dmmf.dart';

extension DmmfSchemaTypes<T> on SchemaTypes<T> {
  Iterable<T> get pattern => [...model, ...prisma];
}
