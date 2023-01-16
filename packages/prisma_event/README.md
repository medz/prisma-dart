# Priama Event

This package implements the Prisma Event specification.

[![pub package](https://img.shields.io/pub/v/prisma_event.svg)](https://pub.dev/packages/prisma_event)

## Usage

A simple usage example:

```dart
import 'package:prisma_event/prisma_event.dart';

main() {
  final emitter = Emitter(
    stdout: Event.values,
  );

  emitter.emit(Event.info, 'Hello, World!');
}
```