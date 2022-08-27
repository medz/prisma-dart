import 'dart:io';

String getEngineVersion(String enginePath) {
  var out = Process.runSync(enginePath, ["--version"]).stdout as String;
  return out.replaceFirst("query-engine", "").trim();
}
