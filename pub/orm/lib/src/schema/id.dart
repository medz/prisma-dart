import 'package:orm/core.dart';

abstract interface class _FieldID {
  /// The name of the underlying primary key constraint in the database.
  ///
  /// > [!IMPORTANT] Not supported for MySQL or MongoDB.
  String? get map;
}

abstract interface class _MySQLFieldID {
  /// Allows you to specify a maximum length for the subpart
  /// of the value to be indexed.
  ///
  /// MySQL only. In preview in versions 3.5.0 and later, and
  /// in general availability in versions 4.0.0 and later.
  int? get length;
}

abstract interface class _SQLServerFieldID {
  /// Allows you to specify in what order the entries of
  /// the ID are stored in the database.
  ///
  /// The available options are [.asc] and [.desc].
  SortOrder? get sort;

  /// Defines whether the ID is clustered or non-clustered.
  ///
  /// Defaults to `true`
  bool get clustered;
}

abstract interface class _ModelID {
  /// The name that client will expose for the argument covering all fields.
  String? get name;

  /// A list of field names.
  Set<String>? get fields;
}

final class ID implements _FieldID, _MySQLFieldID, _SQLServerFieldID, _ModelID {
  @override
  final String? name;

  @override
  final String? map;

  @override
  final bool clustered;

  @override
  final Set<String>? fields;

  @override
  final int? length;

  @override
  final SortOrder? sort;

  const ID({
    this.clustered = true,
    this.fields,
    this.length,
    this.map,
    this.name,
    this.sort,
  });
}

const id = ID();
