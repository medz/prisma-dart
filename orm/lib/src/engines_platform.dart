/// Prisma engines supported platform.
enum EnginesPlatform {
  darwin('darwin'),
  darwinArm64('darwin-arm64'),
  debianOpenssl10('debian-openssl-1.0.x'),
  debianOpenssl11('debian-openssl-1.1.x'),
  debianOpenssl30('debian-openssl-3.0.x'),
  rhelOpenssl10('rhel-openssl-1.0.x'),
  rhelOpenssl11('rhel-openssl-1.1.x'),
  rhelOpenssl30('rhel-openssl-3.0.x'),
  linuxArm64Openssl10('linux-arm64-openssl-1.0.x'),
  linuxArm64Openssl11('linux-arm64-openssl-1.1.x'),
  linuxArm64Openssl30('linux-arm64-openssl-3.0.x'),
  lunuxMusl('linux-musl'),
  linuxNixos('linux-nixos'),
  windows('windows'),
  freebsd11('freebsd11'),
  freebsd12('freebsd12'),
  freebsd13('freebsd13'),
  openbsd('openbsd'),
  netbsd('netbsd'),
  arm('arm'),
  ;

  final String value;
  const EnginesPlatform(this.value);
}
