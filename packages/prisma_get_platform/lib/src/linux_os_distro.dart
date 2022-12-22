import 'dart:io';

const _osReleaseFile = '/etc/os-release';
const _alpineReleaseFile = '/etc/alpine-release';

/// Operating system distro.
enum LinuxOperatingSystemDistro {
  rhel,
  debian,
  nixos,
  arm,
  musl;

  /// Lookup the current operating system distro.
  static LinuxOperatingSystemDistro get current {
    assert(Platform.isLinux,
        'Unsupported operating system distro, only Linux is supported');

    // If alpine release file exists, return musl.
    if (File(_alpineReleaseFile).existsSync()) {
      return LinuxOperatingSystemDistro.musl;
    }

    // If os-release file exists, parse it and return distro.
    final File osReleaseFile = File(_osReleaseFile);
    if (osReleaseFile.existsSync()) {
      return _parseOsReleaseDistro(osReleaseFile.readAsStringSync());
    }

    // Throw unsupported error.
    throw UnsupportedError('Unsupported operating system distro');
  }

  /// Parse os-release file and return distro.
  static LinuxOperatingSystemDistro _parseOsReleaseDistro(String osRelease) {
    final RegExp idRegex =
        RegExp(r'^ID="?([^"\n]*)"?$', multiLine: true, caseSensitive: false);

    final Iterable<RegExpMatch> idMatchs = idRegex.allMatches(osRelease);
    for (final RegExpMatch match in idMatchs) {
      switch (match.group(1)?.toLowerCase()) {
        case 'raspbian':
          return LinuxOperatingSystemDistro.arm;
        case 'nixos':
          return LinuxOperatingSystemDistro.nixos;
        case 'fedora':
          return LinuxOperatingSystemDistro.rhel;
        case 'debian':
          return LinuxOperatingSystemDistro.debian;
      }
    }

    final RegExp idLikeRegex = RegExp(r'^ID_LIKE="?([^"\n]*)"?$',
        multiLine: true, caseSensitive: false);
    final Iterable<RegExpMatch> idLikeMatchs =
        idLikeRegex.allMatches(osRelease);
    const List<String> rehlDistro = ['centos', 'fedora', 'rhel'];
    const List<String> debianDistro = ['debian', 'ubuntu'];
    for (final RegExpMatch match in idLikeMatchs) {
      final String? idLike = match.group(1)?.toLowerCase();
      for (final String rhelDistro in rehlDistro) {
        if (idLike?.contains(rhelDistro) == true) {
          return LinuxOperatingSystemDistro.rhel;
        }
      }
      for (final String debianDistro in debianDistro) {
        if (idLike?.contains(debianDistro) == true) {
          return LinuxOperatingSystemDistro.debian;
        }
      }
    }

    throw UnsupportedError('Unsupported operating system distro');
  }
}
