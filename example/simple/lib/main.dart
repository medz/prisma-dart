import 'prisma_client.dart';

final PrismaClient prisma = createPrismaClient();

void main() async {
  try {
    SaySomething? result = await prisma.saySomething.findFirst();
    result ??= await prisma.saySomething.create(
      data: CreateOneSaySomethingData.withSaySomethingUncheckedCreateInput(
        SaySomethingUncheckedCreateInput(
          text: 'Hello World',
        ),
      ),
    );

    print(result.text);
  } catch (e) {
    print(e);
  } finally {
    await prisma.$disconnect();
  }
}
