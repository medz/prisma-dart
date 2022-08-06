

import 'package:example/src/prisma_generated.dart';

void main(List<String> args) async{
  final client = PrismaClient();
  await client.engine.start();

}