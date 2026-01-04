abstract class I {
  void echo() {}
}

mixin A on I {
  @override
  void echo() {
    super.echo();
    print('A');
  }
}

mixin B on I {
  @override
  void echo() {
    super.echo();
    print('B');
  }
}

mixin C on I {
  @override
  void echo() {
    super.echo();
    print('C');
  }
}

class D extends I with A, B, C {
  @override
  void echo() {
    super.echo();
    print('D');
  }
}

void main() {
  final hi = D();
  hi.echo();
}
