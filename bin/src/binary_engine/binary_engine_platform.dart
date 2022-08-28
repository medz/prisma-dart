import 'dart:io';

/// Prisma engine supported platform.
enum BinaryEnginePlatform {
  darwin('darwin'),
  darwinArm64('darwin-arm64'),
  windows('windows'),
  debianOpenssl10('debian-openssl-1.0.x'),
  debianOpenssl11('debian-openssl-1.1.x'),
  debianOpenssl30('debian-openssl-3.0.x'),
  rhelOpenssl10('rhel-openssl-1.0.x'),
  rhelOpenssl11('rhel-openssl-1.1.x'),
  rhelOpenssl30('rhel-openssl-3.0.x'),
  linuxArmOpenssl10('linux-arm-openssl-1.0.x'),
  linuxArmOpenssl11('linux-arm-openssl-1.1.x'),
  linuxArmOpenssl30('linux-arm-openssl-3.0.x'),
  linuxArm64Openssl10('linux-arm64-openssl-1.0.x'),
  linuxArm64Openssl11('linux-arm64-openssl-1.1.x'),
  linuxArm64Openssl30('linux-arm64-openssl-3.0.x'),
  linuxMusl('linux-musl'),
  linuxNixos('linux-nixos'),
  openbsd('openbsd'),
  freebsd('freebsd'),
  ;

  /// Engine platform value.
  final String value;

  /// Create a new [BinaryEnginePlatform] instance.
  const BinaryEnginePlatform(this.value);

  /// Get current platform.
  static BinaryEnginePlatform get current => _current;
}

/// Get current supported platform.
/// If the current platform is not supported, return [BinaryEnginePlatform.linuxMusl].
BinaryEnginePlatform get _current {
  // Windows
  if (Platform.isWindows) return BinaryEnginePlatform.windows;

  // macOS
  if (Platform.isMacOS) {
    // Darwin ARM64
    if (Platform.version.toLowerCase().contains('arm64')) {
      return BinaryEnginePlatform.darwinArm64;
    }

    return BinaryEnginePlatform.darwin;
  }

  // Get current OpenSSL version.
  final String opensslVersion = _getOpenSslVersion();

  // Linux arm64
  if (Platform.version.toLowerCase().contains('arm64')) {
    switch (opensslVersion) {
      case '3.0.x':
        return BinaryEnginePlatform.linuxArm64Openssl30;
      case '1.1.x':
        return BinaryEnginePlatform.linuxArm64Openssl11;
      case '1.0.x':
        return BinaryEnginePlatform.linuxArm64Openssl10;
    }
    // Linux arm
  } else if (Platform.isLinux &&
      Platform.version.toLowerCase().contains('arm')) {
    switch (opensslVersion) {
      case '3.0.x':
        return BinaryEnginePlatform.linuxArmOpenssl30;
      case '1.1.x':
        return BinaryEnginePlatform.linuxArmOpenssl11;
      case '1.0.x':
        return BinaryEnginePlatform.linuxArmOpenssl10;
    }
  }

  // Get current system distro.
  final _SystemDistro? distro = _getSystemDistro();
  switch (distro) {
    case _SystemDistro.debian:
      switch (opensslVersion) {
        case '3.0.x':
          return BinaryEnginePlatform.debianOpenssl30;
        case '1.1.x':
          return BinaryEnginePlatform.debianOpenssl11;
        case '1.0.x':
          return BinaryEnginePlatform.debianOpenssl10;
      }
      break;
    case _SystemDistro.rhel:
      switch (opensslVersion) {
        case '3.0.x':
          return BinaryEnginePlatform.rhelOpenssl30;
        case '1.1.x':
          return BinaryEnginePlatform.rhelOpenssl11;
        case '1.0.x':
          return BinaryEnginePlatform.rhelOpenssl10;
      }
      break;

    case _SystemDistro.arm:
      switch (opensslVersion) {
        case '3.0.x':
          return BinaryEnginePlatform.linuxArmOpenssl30;
        case '1.1.x':
          return BinaryEnginePlatform.linuxArmOpenssl11;
        case '1.0.x':
          return BinaryEnginePlatform.linuxArmOpenssl10;
      }
      break;
    case _SystemDistro.nixos:
      return BinaryEnginePlatform.linuxNixos;
    case _SystemDistro.musl:
      return BinaryEnginePlatform.linuxMusl;
    default:
      return BinaryEnginePlatform.debianOpenssl11;
  }

  return BinaryEnginePlatform.debianOpenssl11;
}

/// Get current OpenSSL version.
String _getOpenSslVersion() {
  // Run OpenSSL version command.
  final ProcessResult openSllVersionresult =
      Process.runSync('openssl', ['version', '-v']);
  final Iterable<Match> matches = RegExp(r'^OpenSSL\s(\d+\.\d+)\.\d+')
      .allMatches(openSllVersionresult.stdout.trim());
  for (final Match match in matches) {
    if (match.groupCount == 1) {
      return '${match.group(1)}.x';
    }
  }

  // List directory `/lib64`, find the latest version.
  final ProcessResult lsLib64result = Process.runSync('ls', ['-l', '/lib64']);
  final String? matchdRootLibSllVersion =
      _matchLibSllVersion(lsLib64result.stdout.trim());
  if (matchdRootLibSllVersion != null) return matchdRootLibSllVersion;

  // List directory `/usr/lib64`, find the latest version.
  final ProcessResult lsUsrLib64result =
      Process.runSync('ls', ['-l', '/usr/lib64']);
  final String? matchdUsrLibSllVersion =
      _matchLibSllVersion(lsUsrLib64result.stdout.trim());
  if (matchdUsrLibSllVersion != null) return matchdUsrLibSllVersion;

  return '1.1.x';
}

/// Match LibSLL version.
String? _matchLibSllVersion(String stdout) {
  final Pattern pattern = RegExp(r'libssl\.so\.(\d+\.\d+)\.\d+');
  for (final String line in stdout.split('\n')) {
    final Iterable<Match> matches = pattern.allMatches(line);
    for (final Match match in matches) {
      if (match.groupCount == 1) {
        return '${match.group(1)}.x';
      }
    }
  }

  return null;
}

enum _SystemDistro {
  debian,
  rhel,
  nixos,
  musl,
  arm,
}

/// Get current system distro.
_SystemDistro? _getSystemDistro() {
  const String osReleaseFile = '/etc/os-release';
  const String alpineReleaseFile = '/etc/alpine-release';

  // Check alpine release file exists.
  if (File(alpineReleaseFile).existsSync()) {
    return _SystemDistro.musl;
  }

  // Check os-release file exists.
  if (File(osReleaseFile).existsSync()) {
    // Read os-release file.
    final String osRelease = File(osReleaseFile).readAsStringSync();

    // Match distro name.
    final Pattern idPattern = RegExp(r'^ID="?([^"\n]*)"?$', multiLine: true);
    final Iterable<Match> idMatches = idPattern.allMatches(osRelease);
    for (final Match match in idMatches) {
      if (match.groupCount == 1) {
        switch (match.group(1)?.toLowerCase()) {
          case 'raspbian':
            return _SystemDistro.arm;
          case 'nixos':
            return _SystemDistro.nixos;
        }
      }
    }

    // Match ID LINE in os-release file.
    final Pattern idLinePattern =
        RegExp(r'^ID_LINE="?([^"\n]*)"?$', multiLine: true);
    final Iterable<Match> idLineMatches = idLinePattern.allMatches(osRelease);
    for (final Match match in idLineMatches) {
      if (match.groupCount == 1) {
        final List<String> rhel = ['centos', 'fedora', 'rhel', 'fedora'];
        for (final String rhelDistro in rhel) {
          if (match.group(1)?.toLowerCase().contains(rhelDistro) == true) {
            return _SystemDistro.rhel;
          }
        }

        final List<String> debian = ['debian', 'ubuntu'];
        for (final String debianDistro in debian) {
          if (match.group(1)?.toLowerCase().contains(debianDistro) == true) {
            return _SystemDistro.debian;
          }
        }
      }
    }
  }

  return null;
}
