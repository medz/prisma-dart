import 'package:example/src/prisma_generated.dart';

void main(List<String> args) async {
  final client = PrismaClient();
  await client.engine.start();

  final res = await client.post.createOne(
      data: PostCreateInput(
    published: true,
    title: "Create by dart",
  ));
  print(res.title);

  final val = await client.post.findFirst(
      where: PostWhereInput(
          desc: StringNullableFilter(endsWith: "ali"),
          id: StringFilter(equals: "1")));
  print(val?.desc);
  
  await client.engine.stop();
}
