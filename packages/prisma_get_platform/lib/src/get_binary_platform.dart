//   'darwin',
//   'darwin-arm64',
//   'debian-openssl-1.0.x',
//   'debian-openssl-1.1.x',
//   'debian-openssl-3.0.x',
//   'rhel-openssl-1.0.x',
//   'rhel-openssl-1.1.x',
//   'rhel-openssl-3.0.x',
//   'linux-arm64-openssl-1.1.x',
//   'linux-arm64-openssl-1.0.x',
//   'linux-arm64-openssl-3.0.x',
//   'linux-arm-openssl-1.1.x',
//   'linux-arm-openssl-1.0.x',
//   'linux-arm-openssl-3.0.x',
//   'linux-musl',
//   'linux-musl-openssl-3.0.x',
//   'linux-nixos',
//   'windows',
//   'freebsd11',
//   'freebsd12',
//   'freebsd13',
//   'openbsd',
//   'netbsd',
//   'arm',
// https://github.com/prisma/prisma/blob/main/packages/get-platform/src/platforms.ts

import 'dart:io';

import 'get_openssl_version.dart';
import 'linux_os_distro.dart';

/// Get prisma binary engine platform.
String getBinaryPlatform() {
  final String dartSdkVersion = Platform.version.toLowerCase();

  if (Platform.isWindows) {
    return 'windows';
  } else if (Platform.isMacOS) {
    return dartSdkVersion.contains('arm') ? 'darwin-arm64' : 'darwin';
  } else if (!Platform.isLinux) {
    throw UnsupportedError('Unsupported operating system');
  }

  final LinuxOperatingSystemDistro distro = LinuxOperatingSystemDistro.current;

  // NixOS
  if (distro == LinuxOperatingSystemDistro.nixos) {
    return 'linux-nixos';
  }

  final String opensslVersion = getOpenSSLVersion();

  // ARM architecture
  if (dartSdkVersion.contains('arm')) {
    return 'linux-arm${dartSdkVersion.contains('arm64') ? '64' : ''}-openssl-$opensslVersion';
  }

  // Debian
  if (distro == LinuxOperatingSystemDistro.debian) {
    return 'debian-openssl-$opensslVersion';
  }

  // RHEL(Red Hat Enterprise Linux)
  if (distro == LinuxOperatingSystemDistro.rhel) {
    return 'rhel-openssl-$opensslVersion';
  }

  // Musl
  if (distro == LinuxOperatingSystemDistro.musl) {
    final String musl = 'linux-musl';
    if (opensslVersion == '3.0.x') {
      return '$musl-openssl-$opensslVersion';
    }
  }

  // Raspbian
  if (distro == LinuxOperatingSystemDistro.arm) {
    return 'arm';
  }

  throw UnsupportedError('Unsupported operating system');
}
