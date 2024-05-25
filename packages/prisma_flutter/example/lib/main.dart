import 'package:flutter/material.dart';
import 'package:prisma_flutter/prisma_flutter.dart';

const schema = '''
generator client {
  provider = "dart run orm"
  output   = "dart"
}

datasource db {
  provider = "sqlite"
  url      = "file://demo.db"
}

model User {
  id    Int  @id @default(auto()) @map("_id")
  email String  @unique
  name  String?
}
''';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final engine = LibraryEngine(schema: schema, datasources: {});

    print(engine);

    return MaterialApp(
      title: 'Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Demo')),
      ),
    );
  }
}
