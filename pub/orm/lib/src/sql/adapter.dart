import '../contract/contract.dart';
import '../engine/engine.dart';
import '../runtime/errors.dart';
import '../runtime/plan.dart';
import '../runtime/types.dart';
import '../target/adapter.dart';
import 'codec.dart';
import 'types.dart';

final class SqlAdapter implements TargetAdapter<SqlStatement, SqlResult> {
  final OrmContract contract;
  final String identifierQuote;
  final SqlFieldCodecResolver? codecResolver;

  SqlAdapter({
    this.identifierQuote = '"',
    required this.contract,
    this.codecResolver,
  });

  @override
  SqlStatement lower(OrmPlan plan) {
    final model = contract.models[plan.model];
    if (model == null) {
      throw ModelNotFoundException(plan.model, contract.models.keys);
    }

    final params = <Object?>[];
    final whereClause = _buildWhereClause(
      model: plan.model,
      where: plan.where,
      params: params,
    );
    final orderByClause = _buildOrderByClause(plan.orderBy);

    return switch (plan.action) {
      OrmAction.findMany => SqlStatement(
        action: plan.action,
        text:
            'SELECT ${_buildSelectColumns(plan.select)} FROM ${_id(model.table)}'
            '$whereClause$orderByClause${_buildLimitOffsetClause(plan, params)}',
        parameters: params,
      ),
      OrmAction.findUnique => SqlStatement(
        action: plan.action,
        text:
            'SELECT ${_buildSelectColumns(plan.select)} FROM ${_id(model.table)}'
            '$whereClause$orderByClause LIMIT 1',
        parameters: params,
      ),
      OrmAction.create => _lowerCreate(
        plan: plan,
        table: model.table,
        model: plan.model,
      ),
      OrmAction.update => _lowerUpdate(
        plan: plan,
        table: model.table,
        model: plan.model,
      ),
      OrmAction.delete => _lowerDelete(
        plan: plan,
        table: model.table,
        model: plan.model,
      ),
    };
  }

  @override
  EngineResponse decode(SqlResult response, OrmPlan plan) {
    final resolver = codecResolver;
    if (resolver == null) {
      return switch (plan.action) {
        OrmAction.findMany => EngineResponse(
          data: response.rows,
          affectedRows: response.affectedRows,
        ),
        OrmAction.findUnique => EngineResponse(
          data: _firstOrNull(response.rows),
          affectedRows: response.affectedRows,
        ),
        OrmAction.create ||
        OrmAction.update ||
        OrmAction.delete => EngineResponse(
          data: _firstOrNull(response.rows),
          affectedRows: response.affectedRows,
        ),
      };
    }

    final decodedRows = _decodeRows(model: plan.model, rows: response.rows);
    return switch (plan.action) {
      OrmAction.findMany => EngineResponse(
        data: decodedRows,
        affectedRows: response.affectedRows,
      ),
      OrmAction.findUnique => EngineResponse(
        data: _firstOrNull(decodedRows),
        affectedRows: response.affectedRows,
      ),
      OrmAction.create ||
      OrmAction.update ||
      OrmAction.delete => EngineResponse(
        data: _firstOrNull(decodedRows),
        affectedRows: response.affectedRows,
      ),
    };
  }

  SqlStatement _lowerCreate({
    required OrmPlan plan,
    required String table,
    required String model,
  }) {
    final columns = plan.data.keys.toList(growable: false);
    final values = columns
        .map(
          (column) => _encodeValue(
            model: model,
            field: column,
            value: plan.data[column],
          ),
        )
        .toList(growable: false);
    final placeholders = List<String>.filled(columns.length, '?').join(', ');

    return SqlStatement(
      action: plan.action,
      text:
          'INSERT INTO ${_id(table)} (${columns.map(_id).join(', ')}) '
          'VALUES ($placeholders)${_buildMutationReturningClause(plan.select)}',
      parameters: values,
    );
  }

  SqlStatement _lowerUpdate({
    required OrmPlan plan,
    required String table,
    required String model,
  }) {
    final setColumns = plan.data.keys.toList(growable: false);
    final setValues = setColumns
        .map(
          (column) => _encodeValue(
            model: model,
            field: column,
            value: plan.data[column],
          ),
        )
        .toList(growable: false);

    final params = <Object?>[...setValues];
    final wherePart = _buildWhereClause(
      model: model,
      where: plan.where,
      params: params,
    );

    return SqlStatement(
      action: plan.action,
      text:
          'UPDATE ${_id(table)} SET '
          '${setColumns.map((column) => '${_id(column)} = ?').join(', ')}'
          '$wherePart${_buildMutationReturningClause(plan.select)}',
      parameters: params,
    );
  }

  SqlStatement _lowerDelete({
    required OrmPlan plan,
    required String table,
    required String model,
  }) {
    final params = <Object?>[];
    final wherePart = _buildWhereClause(
      model: model,
      where: plan.where,
      params: params,
    );

    return SqlStatement(
      action: plan.action,
      text:
          'DELETE FROM ${_id(table)}'
          '$wherePart${_buildMutationReturningClause(plan.select)}',
      parameters: params,
    );
  }

  String _buildSelectColumns(List<String> select) {
    if (select.isEmpty) {
      return '*';
    }
    return select.map(_id).join(', ');
  }

  String _buildMutationReturningClause(List<String> select) {
    if (!contract.capabilities.mutationReturning) {
      return '';
    }

    return ' RETURNING ${_buildSelectColumns(select)}';
  }

  String _buildWhereClause({
    required String model,
    required JsonMap where,
    required List<Object?> params,
  }) {
    if (where.isEmpty) {
      return '';
    }

    final predicates = <String>[];
    for (final entry in where.entries) {
      predicates.add('${_id(entry.key)} = ?');
      params.add(
        _encodeValue(model: model, field: entry.key, value: entry.value),
      );
    }

    return ' WHERE ${predicates.join(' AND ')}';
  }

  String _buildOrderByClause(List<OrmOrderBy> orderBy) {
    if (orderBy.isEmpty) {
      return '';
    }

    final clauses = orderBy.map((entry) {
      final direction = entry.order.name.toUpperCase();
      return '${_id(entry.field)} $direction';
    });

    return ' ORDER BY ${clauses.join(', ')}';
  }

  String _buildLimitOffsetClause(OrmPlan plan, List<Object?> params) {
    final clauses = <String>[];

    if (plan.take case final take?) {
      clauses.add(' LIMIT ?');
      params.add(take);
    }

    if (plan.skip case final skip?) {
      if (plan.take == null) {
        clauses.add(' LIMIT -1');
      }
      clauses.add(' OFFSET ?');
      params.add(skip);
    }

    return clauses.join();
  }

  String _id(String value) => '$identifierQuote$value$identifierQuote';

  List<JsonMap> _decodeRows({
    required String model,
    required List<JsonMap> rows,
  }) {
    if (rows.isEmpty) {
      return rows;
    }

    final decoded = <JsonMap>[];
    for (final row in rows) {
      decoded.add(_decodeRow(model: model, row: row));
    }
    return decoded;
  }

  JsonMap _decodeRow({required String model, required JsonMap row}) {
    final decoded = <String, Object?>{};
    for (final entry in row.entries) {
      decoded[entry.key] = _decodeValue(
        model: model,
        field: entry.key,
        value: entry.value,
      );
    }
    return decoded;
  }

  Object? _encodeValue({
    required String model,
    required String field,
    required Object? value,
  }) {
    final codec = codecResolver?.resolve(model: model, field: field);
    if (codec == null) {
      return value;
    }
    return codec.encode(value);
  }

  Object? _decodeValue({
    required String model,
    required String field,
    required Object? value,
  }) {
    final codec = codecResolver?.resolve(model: model, field: field);
    if (codec == null) {
      return value;
    }
    return codec.decode(value);
  }
}

T? _firstOrNull<T>(List<T> values) {
  if (values.isEmpty) {
    return null;
  }
  return values.first;
}
