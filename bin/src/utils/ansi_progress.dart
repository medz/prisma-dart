import 'dart:async';
import 'dart:io';

class AnsiProgress {
  static const List<String> _animationCharacters = ['|', '/', '-', r'\'];

  AnsiProgress(String message) {
    _message = message.padRight(40);
    stdout.write(_message);

    _timer = Timer.periodic(Duration(milliseconds: 100), _tick);
  }

  late final String _message;
  late final Timer _timer;

  /// Cancel the progress bar.
  void cancel({
    String? overrideMessage,
    bool showTime = false,
  }) {
    _timer.cancel();
    if (overrideMessage != null) {
      stdout.write(List.generate(_message.length, (_) => '\b').join());
      stdout.write(overrideMessage.padRight(40));
      stdout.write(' ');
    }
    if (showTime) {
      stdout.write('\b');
      stdout.write((_timer.tick / 10).toStringAsFixed(1));
      stdout.write('s');
    }

    stdout.writeln();
  }

  /// Tick the progress bar.
  void _tick(Timer timer) {
    final String animationCharacter =
        _animationCharacters[timer.tick % _animationCharacters.length];
    stdout.write('\b');
    stdout.write(animationCharacter);
  }
}
