// UserCacheDir returns the default root directory to use for user-specific
// cached data. Users should create their own application-specific subdirectory
// within this one and use that.
//
// On Unix systems, it returns $XDG_CACHE_HOME as specified by
// https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html if
// non-empty, else $HOME/.cache.
// On Darwin, it returns $HOME/Library/Caches.
// On Windows, it returns %LocalAppData%.
// On Plan 9, it returns $home/lib/cache.
//
// If the location cannot be determined (for example, $HOME is not defined),
// then it will return an error.
import 'dart:io';

String userCacheDirectory() {
  String dir;

  switch (Platform.operatingSystem) {
    case "windows":
      dir = _getEnv("LocalAppData");
      if (dir.isEmpty) {
        throw Exception("%LocalAppData% is not defined");
      }
      break;
    case "darwin":
    case "ios":
      dir = _getEnv("HOME");
      if (dir.isEmpty) {
        throw Exception(r"$HOME is not defined");
      }
      dir += "/Library/Caches";
      break;
    case "plan9":
      dir = _getEnv("home");
      if (dir.isEmpty) {
        throw Exception(r"$home is not defined");
      }
      dir += "/lib/cache";
      break;
    default: // Unix
      dir = _getEnv("XDG_CACHE_HOME");
      if (dir.isEmpty) {
        dir = _getEnv("HOME");
        if (dir.isEmpty) {
          throw Exception(r"neither $XDG_CACHE_HOME nor $HOME are defined");
        }
        dir += "/.cache";
        break;
      }
  }

  return dir;
}

String _getEnv(String key) {
  return Platform.environment[key] ?? "";
}
