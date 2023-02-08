class Test {
  const Test();
}

Test get test => const Test();

void main() {
  print(test == test);
  print(test.hashCode);
}
