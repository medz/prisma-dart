import 'package:flutter/material.dart';
import 'package:prisma_flutter/prisma_flutter.dart';

// ignore: implementation_imports
// import 'package:prisma_flutter/src/query_engine_bindings.dart';

const schema = '''
// This is your Prisma schema file,
// learn more about it in the docs: https://pris.ly/d/prisma-schema

generator dart_client {
  provider = "dart run orm"
  output   = "dart"
}

datasource db {
  provider = "sqlite"
  url      = "file://prisma_flutter.example.db"
}

model User {
  id    Int     @id @default(autoincrement())
  email String  @unique
  name  String?
}
''';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // final callback =
    //     NativeCallable<Void Function(Pointer<Char>, Pointer<Char>)>.listener(
    //         log);

    // final options = Struct.create<ConstructorOptions>()
    //   ..log_callback = callback.nativeFunction;
    // final qePtr = malloc<Pointer<QueryEngine>>();
    // final errPtr = malloc<Pointer<Char>>();

    // final status = demo.prisma_create(options, qePtr, errPtr);
    // print(status);

    final engine = PrismaFlutterEngine(
      schema: schema,
      datasources: {},
      logCallback: (String message) {
        print(message);
      },
    );

    print(engine);

    return MaterialApp(
      title: "Prisma Flutter",
      home: Scaffold(
        appBar: AppBar(title: const Text('Prisma Flutter')),
        // body: Text(bindings.PRISMA_MISSING_POINTER.toString()),
      ),
    );
  }
}

void main() => runApp(const App());
