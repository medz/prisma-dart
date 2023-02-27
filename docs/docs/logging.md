# Logging

Use the `PrismaClient` `stdout` and `event` parameters to configure logging.

## Stdout logging

To log to stdout, set the `stdout` parameter to `Iteravle<Event>`:

```dart
import 'package:prisma/logger.dart';

final prisma = PrismaClient(
  stdout: [Event.query, Event.info, Event.warn, Event.error],
);
```

If you want to log all events, you can use the `Event.values` constant.

```dart
import 'package:prisma/logger.dart';

final prisma = PrismaClient(
  stdout: Event.values,
);
```

## Event-based logging


To log events, set the `stdout` parameter to `Iteravle<Event>`:

```dart
import 'package:prisma/logger.dart';

final prisma = PrismaClient(
  event: [Event.query, Event.info, Event.warn, Event.error],
);
```

If you want to log all events, you can use the `Event.values` constant.

```dart
import 'package:prisma/logger.dart';

final prisma = PrismaClient(
  event: Event.values,
);
```

### Listening to events

To listen to events, use the `PrismaClient` `$on` method:

```dart
import 'package:prisma/logger.dart';

prisma.$on(Event.query, (payload) {
  print(payload);
});
```
