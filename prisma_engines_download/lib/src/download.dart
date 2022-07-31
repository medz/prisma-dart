import 'dart:async';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' show join;
import 'package:prisma_engines_platform/prisma_engines_platform.dart';

import 'cache.dart';
import 'chmod.dart';
import 'get_download_url.dart';
import 'prisma_binary_type.dart';

/// Get cached binary path.
String? getCachedBinaryPath({
  required String version,
  required PrismaEnginesPlatform platform,
  required PrismaBinaryType binary,
}) {
  // Get cache directory.
  final Directory cacheDirectory = getCacheDirectory(
    version: version,
    platform: platform,
  );

  // Get binary path.
  final String binaryPath = join(
    cacheDirectory.path,
    binary.value,
  );

  return File(binaryPath).existsSync() ? binaryPath : null;
}

Future<String> downloadBinary({
  required String version,
  required PrismaEnginesPlatform platform,
  required PrismaBinaryType binary,
  Future<void> Function(PrismaBinaryType, Future<void>)? onDownloadProgress,
  String? customBinarySavePath,
}) async {
  final String binarySavePath = _resolveBinarySavePath(
    binary: binary,
    version: version,
    platform: platform,
    customBinarySavePath: customBinarySavePath,
  );

  // If binary exists, return it.
  if (File(binarySavePath).existsSync()) {
    await chmod(binarySavePath);

    return binarySavePath;
  }

  // Create a Future completion to download binary.
  final Completer<void> downloadCompleter = Completer<void>();

  // Get download url.
  final Future<void>? progress =
      onDownloadProgress?.call(binary, downloadCompleter.future);
  final Uri downloadUrl = getDownloadUrl(
    version: version,
    platform: platform,
    binary: binary,
  );

  // Download binary.
  final http.Request request = http.Request('GET', downloadUrl);
  final http.Client client = http.Client();
  final http.StreamedResponse response = await client.send(request);

  // If status code is not 200
  if (response.statusCode != 200) {
    throw Exception(
      'Failed to download ${binary.value} from ${downloadUrl.toString()}.',
    );
  }

  // Write to file.
  final IOSink sink = File('$binarySavePath.gz').openWrite();
  await response.stream.pipe(sink);
  if (progress != null) {
    downloadCompleter.complete();
    await progress;
  }

  final output = OutputFileStream(binarySavePath);
  final input = InputFileStream('$binarySavePath.gz');

  GZipDecoder().decodeStream(input, output);

  // Delete gzipped file.
  File('$binarySavePath.gz').delete();

  await chmod(binarySavePath);

  return binarySavePath;
}

/// Resolve binary save path.
String _resolveBinarySavePath({
  required PrismaBinaryType binary,
  required String version,
  required PrismaEnginesPlatform platform,
  String? customBinarySavePath,
}) {
  if (customBinarySavePath != null && customBinarySavePath.isNotEmpty) {
    return _resolvePlatformBinaryExtension(customBinarySavePath);
  }

  return _resolvePlatformBinaryExtension(
    join(
      getCacheDirectory(
        version: version,
        platform: platform,
      ).path,
      binary.value,
    ),
  );
}

/// Resolve platform binary extension.
String _resolvePlatformBinaryExtension(String path) {
  if (Platform.isWindows && !path.endsWith('.exe')) {
    return '$path.exe';
  }

  return path;
}
