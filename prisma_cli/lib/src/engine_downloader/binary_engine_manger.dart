import 'dart:io';

import 'package:path/path.dart';
import 'package:prisma_cli/src/engine_downloader/binary_engine_downloader.dart';
import 'package:prisma_cli/src/engine_downloader/binary_engine_platform.dart';
import 'package:prisma_cli/src/engine_downloader/binary_engine_type.dart';
import 'package:prisma_cli/src/utils/cahce_directory.dart';
import 'package:prisma_cli/src/utils/chmod.dart';
import 'package:prisma_cli/src/utils/engine_version.dart';

/// BinaryEngineManger is used to download the engine into the cache and then move it to the project file if needed
/// use moveToProject to decide to move it or not (only query_engine may be needed to move into local project folder)
class BinaryEngineManger {
  BinaryEngineManger(
      {required this.engineType,
      required this.platform,
      required this.version,
      this.moveToProject = false});

  /// move the downloaded file into the prisma project folder or keep it only at cache (for now only needed with query engine at generate command)
  final bool moveToProject;

  /// Binary engine type.
  final BinaryEngineType engineType;

  /// Binary engine running platform.
  final BinaryEnginePlatform platform;

  /// Binary engine version.
  final String version;

  /// User cache directory based on user os
  final String _cacheDirectory = userCacheDirectory();

  late final String _projectBinaryDir = "prisma/engines";

  /// project file to save the engine
  late final String _projectBinaryFile =
      join(_projectBinaryDir, engineType.value);
  // cache file to save the engine
  late final String _cacheBinaryPath =
      join('prisma/master', version, platform.value, engineType.value);

  late final String _completeCacheBinaryPath =
      join(_cacheDirectory, _cacheBinaryPath);

  /// ensure that the engine exist and return it is path,
  /// it will check if it exist in the project path and has the same version first,
  /// if not it will check the cache path,
  /// if not it will download a new version into cache, copy it to project folder and enure it us execution,
  /// always return a path of the engine,
  Future<String> ensure(void Function(Future<void> done) onDownload) async {
    // if exist at the project path with the same version return the same path
    if (moveToProject &&
        File(_projectBinaryFile).existsSync() &&
        _isSameVersion(_projectBinaryFile)) {
      return _projectBinaryFile;
    }
    // if he have a cached version just use/move it to the new dir
    // we do not need to check version here as the _completeCacheBinaryPath has the version in it is path
    if (File(_completeCacheBinaryPath).existsSync()) {
      return completeFinalPath();
    }

    // create a downloader to download into the cache
    final BinaryEngineDownloader downloader = BinaryEngineDownloader(
        binaryPath: _cacheBinaryPath,
        engineType: engineType,
        platform: BinaryEnginePlatform.current,
        version: version,
        downloadDir: _cacheDirectory);
    // download
    await downloader.download(onDownload);
    // handle moving and
    return completeFinalPath();
  }

  Future<String> completeFinalPath() async {
    if (moveToProject) {
      Directory(_projectBinaryDir).createSync(recursive: true);
      File(_completeCacheBinaryPath).copySync(_projectBinaryFile);
      await chmod(_projectBinaryFile);
      return _projectBinaryFile;
    }
    await chmod(_completeCacheBinaryPath);
    return _completeCacheBinaryPath;
  }

  bool _isSameVersion(String enginePath) {
    return getEngineVersion(enginePath) == version;
  }
}
