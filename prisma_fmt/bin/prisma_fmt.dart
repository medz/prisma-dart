import 'package:args/args.dart';
import 'package:prisma_engines_download/prisma_engines_download.dart';
import 'package:prisma_engines_platform/prisma_engines_platform.dart';
import 'package:prisma_engines_version/prisma_engines_version.dart';

final ArgParser _argParser = ArgParser()
  ..addOption('schema', help: 'Custom path to your Prisma schema')
  ..addFlag('help', abbr: 'h', help: 'Show help', negatable: false);

void main(List<String> arguments) {
  final ArgResults result = _argParser.parse(arguments);

  if (result.wasParsed('help')) {
    return print(_argParser.usage);
  }

  final path = getDownloadUrl(
    version: prismaEngineVersion,
    platform: PrismaEnginesPlatform.darwin,
    binary: PrismaBinaryType.prismaFmt,
  );

  print(path);
}
