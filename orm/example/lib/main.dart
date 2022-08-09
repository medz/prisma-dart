import 'package:example/src/prisma_generated.dart';

void main(List<String> args) async {
  final client = PrismaClient();

  client.post.groupBy(by: [PostScalarFieldEnum.id]);
  client.user.findFirst(
      where: UserWhereInput(
          post: PostListRelationFilter(
              every: PostWhereInput(id: IntFilter(gt: 4)))));
  await client.engine.start();
}
