const int maxRelationReferenceFixes = 10;

List<String> rankReferenceCandidates(
  List<String> candidates,
  String? target, {
  int? limit,
}) {
  var scored = <({String name, int score})>[];
  for (var name in candidates) {
    var score = _scoreCandidate(name, target);
    scored.add((name: name, score: score));
  }
  scored.sort((a, b) {
    var byScore = a.score.compareTo(b.score);
    if (byScore != 0) return byScore;
    return a.name.compareTo(b.name);
  });
  var ordered = [for (var entry in scored) entry.name];
  if (limit == null) return ordered;
  return ordered.take(limit).toList();
}

int _scoreCandidate(String candidate, String? target) {
  if (target == null || target.isEmpty) {
    return candidate.length;
  }
  if (candidate == target) return 0;
  if (candidate.startsWith(target)) return 1;
  if (candidate.contains(target)) return 2;
  return 10 + _levenshtein(candidate, target);
}

int _levenshtein(String a, String b) {
  if (a == b) return 0;
  if (a.isEmpty) return b.length;
  if (b.isEmpty) return a.length;

  var prev = List<int>.generate(b.length + 1, (i) => i);
  var curr = List<int>.filled(b.length + 1, 0);

  for (var i = 1; i <= a.length; i++) {
    curr[0] = i;
    var ca = a.codeUnitAt(i - 1);
    for (var j = 1; j <= b.length; j++) {
      var cb = b.codeUnitAt(j - 1);
      var cost = ca == cb ? 0 : 1;
      var deletion = prev[j] + 1;
      var insertion = curr[j - 1] + 1;
      var substitution = prev[j - 1] + cost;
      var best = deletion < insertion ? deletion : insertion;
      if (substitution < best) best = substitution;
      curr[j] = best;
    }
    var swap = prev;
    prev = curr;
    curr = swap;
  }

  return prev[b.length];
}
