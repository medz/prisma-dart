/// Prisma engine supported platform.
enum BinaryEnginePlatform {
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
  windows('windows'),
  ;

  final String value;
  const BinaryEnginePlatform(this.value);
}
