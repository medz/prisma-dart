# Analyzer plugin layout

This directory holds analyzer-plugin logic for the ORM package.

Structure
- `rules/`: analysis rules (diagnostics).
- `fixes/`: quick fixes for rule diagnostics.
- `assists/`: assists not tied to diagnostics.
- `utils/`: shared helpers and constants.

Naming
- Rule file: `*_rule.dart` (class `*Rule`).
- Fix file: `*_fix.dart` (class `*Fix`).
- Assist file: `*_assist.dart` (class `*Assist`).

Identifiers
- Rule name: `orm_<snake_case>`.
- Fix id: `orm.fix.<snake_case>`.
- Assist id: `orm.assist.<snake_case>`.

Registration
- Register rules and fixes in `lib/main.dart` via `PluginRegistry`.

Tests
- Place tests under `test/analyzer/`.
- Use `analyzer_testing` + `test_reflective_loader` for rule tests.
