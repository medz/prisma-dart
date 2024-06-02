import 'dart:io';

import 'package:webfetch/webfetch.dart' hide File;
import 'package:path/path.dart' show join, relative;

final root = File.fromUri(Platform.script).parent.parent.path;

final version = File(join(root, '.version', 'prisma-engines'))
    .readAsLinesSync()
    .join()
    .trim();
final lockFile = File(join(root, '.version', 'prisma-engines.lock'));
final String? lockVersion = () {
  if (lockFile.existsSync()) {
    return lockFile.readAsLinesSync().join().trim();
  }

  return null;
}();

final zip = File(join(root, '.dart_tool', 'prisma-libqueryengine.zip'));

Future<void> download() async {
  stdout.writeln('Doenloading Engines ($version)');

  final url =
      'https://binaries.prisma.sh/all_commits/$version/react-native/binaries.zip';
  if (zip.existsSync()) {
    zip.delete(recursive: true);
  }

  final response = await fetch(url);
  if (response.status != 200) {
    throw StateError('Engines ($url) not found.');
  }

  final stream = response.body;
  if (stream == null) {
    throw StateError('Engiens not download.');
  }

  final sink = zip.openWrite();
  await sink.addStream(stream);
  await sink.close();
}

void $(String cmd) {
  final [exe, ...args] = cmd.split(' ');
  final result = Process.runSync(exe, args);

  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    exit(result.exitCode);
  }

  stdout.write(result.stdout);
}

final source = join(root, '.dart_tool', 'prisma-engines');
void unzip() {
  stdout.writeln('Unzip ${relative(zip.path)} to ${relative(source)}');

  final dir = Directory(source);
  if (dir.existsSync()) {
    dir.deleteSync(recursive: true);
  }

  $('unzip ${relative(zip.path)} -d ${relative(source)}');
}

void copyAndroidStaticLibrary() {
  stdout.writeln('Copy static librart to Android');

  final lib = join(source, 'android', 'jniLibs');
  final target = Directory(join(root, 'android', 'query_engine'));
  if (target.existsSync()) {
    target.deleteSync(recursive: true);
  }

  $('cp -rf ${relative(lib)}/ ${relative(target.path)}');
}

void copyiOSStaticLibrary() {
  stdout.writeln('Copy static librart to iOS');
  final lib = join(source, 'ios', 'QueryEngine.xcframework');
  final target =
      Directory(join(root, 'ios', 'Frameworks', 'QueryEngine.xcframework'));
  if (target.existsSync()) {
    target.deleteSync(recursive: true);
  }

  final parent = target.parent;
  if (!parent.existsSync()) {
    parent.createSync(recursive: true);
  }

  $('cp -rf ${relative(lib)}/ ${relative(target.path)}');
}

Future<void> main() async {
  if (!zip.existsSync() || lockVersion != version) {
    await download();
  }

  unzip();
  copyAndroidStaticLibrary();
  copyiOSStaticLibrary();

  if (!lockFile.existsSync()) {
    lockFile.createSync(recursive: true);
  }

  lockFile.writeAsString(version);
}
