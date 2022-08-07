
import 'dart:io';

class Command {
  final String path;
  final List<String> args;
  final Stdout stdout;
  final Stdout stderr;
  final Map<String, String> env;

  Command(this.path, this.args, this.stdout, this.stderr, this.env);
  Future<Process>? started;
  Future<Process> start() {
    if (started != null) return started!;
    started = Process.start(path, args, environment: env)
      ..then((value) {
        stdout.addStream(value.stdout);
        stderr.addStream(value.stderr);
      });

    return started!;
  }

  Future<void> kill() async {
    if (started == null) return;
    final p = await started!;
    p.kill();
  }
}
