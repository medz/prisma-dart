import '../graphql/field.dart';

/// Prisma enum
abstract class PrismaEnum implements Enum {
  abstract final String? originalName;
}

extension PrismaEnumExtension on PrismaEnum {
  /// Convert Prisma enum to GraphQL field
  GraphQLField toGraphQLField() => GraphQLField(originalName ?? name);
}

extension PrismaEnumsExtension on Iterable<PrismaEnum> {
  /// Convert Prisma enums to GraphQL fields
  Iterable<GraphQLField> toGraphQLFields() => map((e) => e.toGraphQLField());
}
