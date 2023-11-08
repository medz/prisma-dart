class Date extends DateTime {
  Date(super.year, super.month, super.day);

  factory Date.parse(String date) {
    final parsed = DateTime.parse(date);
    return Date(parsed.year, parsed.month, parsed.day);
  }

  @override
  String toString() {
    final iso = toIso8601String();
    final ends = iso.indexOf('T');

    return iso.substring(0, ends > 0 ? ends : iso.length);
  }
}

class Time extends DateTime {
  Time(super.hour, super.minute, super.second, super.millisecond,
      super.microsecond);

  factory Time.parse(String time) {
    final parsed = DateTime.parse('1970-01-01T${time}Z');
    return Time(parsed.hour, parsed.minute, parsed.second, parsed.millisecond,
        parsed.microsecond);
  }

  @override
  String toString() {
    final iso = toIso8601String();
    final starts = iso.indexOf('T') + 1;
    final ends = iso.indexOf('Z');

    return iso.substring(starts, ends > 0 ? ends : iso.length);
  }
}
