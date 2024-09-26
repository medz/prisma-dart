import 'package:test/test.dart';

class ContainsMap extends Matcher {
  final Map parts;

  const ContainsMap(this.parts);

  @override
  Description describe(Description description) =>
      description.addDescriptionOf(parts);

  @override
  bool matches(item, Map matchState) {
    if (item is! Map) return false;

    for (final MapEntry(key: key, value: value) in parts.entries) {
      if (!item.containsKey(key)) {
        addStateInfo(matchState, {'matcher': this});
        return false;
      }

      final matcher = switch (value) {
        Map parts => ContainsMap(parts),
        _ => wrapMatcher(value),
      };

      if (!matcher.matches(item[key], matchState)) {
        addStateInfo(matchState, {'matcher': matcher});
        return false;
      }
    }

    return true;
  }
}
