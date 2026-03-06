# ORM V6 API Surface

This document locks the intended public API surface before implementation
completeness. The rule for this phase is simple:

- surface first
- missing behavior may throw a stable placeholder error
- runtime, repository, and plan boundaries stay explicit

Placeholder methods must throw `RUNTIME.API_NOT_IMPLEMENTED`.

## Runtime Root

Single entrypoint:

```dart
final db = client.db;
```

Runtime access:

```dart
client.connect();
client.disconnect();
client.connection();
client.telemetry();
client.operationTelemetry();
client.recentOperationTelemetry();
client.withConnection(...);
client.withTransaction(...);
```

Namespaces:

```dart
db.orm.model('User');
db.sql.from('User');
db.sql.insertInto('User');
db.sql.update('User');
db.sql.deleteFrom('User');
```

## ORM Read Surface

Root:

```dart
final users = client.db.orm.model('User');
final query = users.query();
```

Read authoring:

| Method | Status |
| --- | --- |
| `query()` | implemented |
| `where(...)` | implemented |
| `whereWith(...)` | implemented |
| `orderBy(...)` | implemented |
| `orderByField(...)` | implemented |
| `distinct(...)` | implemented |
| `distinctField(...)` | implemented |
| `select(...)` | implemented |
| `selectField(...)` | implemented |
| `selectWith(...)` | implemented |
| `include(...)` | implemented |
| `includeWith(...)` | implemented |
| `includeRelation(...)` | implemented |
| `skip(...)` | implemented |
| `take(...)` | implemented |
| `unbounded()` | implemented |
| `cursor(...)` | implemented |
| `page(...)` | implemented |

Read terminals:

| Method | Status |
| --- | --- |
| `toPlan()` | implemented |
| `inspectPlan()` | implemented |
| `all()` | implemented |
| `pageResult()` | implemented |
| `stream()` | implemented |
| `firstOrNull()` | implemented |
| `oneOrNull()` | implemented |
| `count()` | implemented |
| `exists()` | implemented |
| `aggregate(...)` | implemented |
| `groupedBy(...).aggregate(...)` | implemented |
| `explain()` | implemented |

Rules:

1. `toPlan()` and `inspectPlan()` are pure authoring inspection.
2. `explain()` is runtime-facing and requires an active runtime connection.
   It returns the common runtime summary and may include target-lowered request
   details when the active engine exposes them. Because it does not execute the
   plan, `planSummary.executionMode` is reported as `deferred`.
3. `cursor(...)` and `page(...)` require `orderBy(...)` first.
4. Boundary fields must match the declared `orderBy(...)` fields.
5. When a model declares `idFields`, `cursor(...)` and `page(...)` require
   `orderBy(...)` to end with those fields.
6. `pageResult()` is the structured pagination terminal and returns
   `items + pageInfo`.
7. `inspectPlan()` and `explain()` expose `terminalExecution` metadata.
   This makes stream delivery explicit:
   - `stream()` stays `nativeStream` only when the repository can yield rows
     directly from the runtime response.
   - `include(...)` or `distinct(...)` force `stream()` to
     `bufferedYield`, with reasons and include strategy surfaced in
     `terminalExecution.stream`.
8. Grouped aggregation is a dedicated surface:
   - `groupedBy(...)` only accepts a where-only base query.
   - `having(...)` and `havingWith(...)` accept structured grouped predicates.
   - `havingExpr(...)` is the primary builder-style entrypoint before
     `aggregate(...)`.
9. `include(...)` is unsupported on `aggregate(...)` and
   `groupedBy(...).aggregate(...)`, including direct plan execution.

## ORM Mutation Surface

Direct mutations:

| Method | Status |
| --- | --- |
| `create(...)` | implemented |
| `createMany(...)` | implemented |
| `createNested(...)` | implemented |
| `update(...)` | implemented |
| `updateNested(...)` | implemented |
| `delete(...)` | implemented |
| `deleteCount(...)` | implemented |
| `upsert(...)` | implemented |
| `updateCount(...)` | implemented |

Chained mutations:

```dart
users.where({...}).update(data: {...});
users.where({...}).delete();
users.where({...}).upsert(create: {...}, update: {...});
users.where({...}).updateCount(data: {...});
```

Rules:
1. `updateCount(...)` and `deleteCount(...)` are count terminals.
2. They require `where(...)` first.
3. They do not accept row-shaping state such as `select(...)` or `include(...)`.

## SQL Surface

Read:

```dart
client.db.sql.from('User').where({...}).orderBy(...).take(10).toPlan();
client.db.sql.from('User').all();
client.db.sql.from('User').firstOrNull();
client.db.sql.from('User').stream();
```

Mutation:

```dart
client.db.sql.insertInto('User').values({...}).execute();
client.db.sql.update('User').set({...}).where({...}).execute();
client.db.sql.deleteFrom('User').where({...}).execute();
```

## Phase Rules

1. New public methods must be added here first.
2. If semantics are not ready, expose the method and throw the stable
   placeholder error.
3. Repository orchestrates multi-step behavior.
4. Runtime observes plans, verifies contracts, runs plugins, and records
   telemetry.
5. Lanes build plans; they do not hide multi-step workflows.
