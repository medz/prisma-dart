## Prisma ORM + Shelf example

## Setup

Edit the `.prismarc` file to match your database credentials.

## Running the example

```bash
dart pub get
dart run orm db push
dart run orm generate
dart run build_runner build
dart run bin/server.dart
```

## Http requests

### Get many users

```bash
curl http://localhost:8080
```

### Get one user

```bash
curl http://localhost:8080/{id}
```

### Create user

```bash
curl -X POST http://localhost:8080 -d '{"name": "John Doe"}'
```