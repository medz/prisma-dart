library prisma.client; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:orm/dmmf.dart' as _i5;
import 'package:orm/engines/binary.dart' as _i4;
import 'package:orm/orm.dart' as _i1;

import 'model.dart' as _i2;
import 'prisma.dart' as _i3;

class SoggettoDelegate {
  const SoggettoDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Soggetto?> findUnique({
    required _i3.SoggettoWhereUniqueInput where,
    _i3.SoggettoSelect? select,
    _i3.SoggettoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Soggetto?>(
      action: 'findUniqueSoggetto',
      result: result,
      factory: (e) => e != null ? _i2.Soggetto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Soggetto> findUniqueOrThrow({
    required _i3.SoggettoWhereUniqueInput where,
    _i3.SoggettoSelect? select,
    _i3.SoggettoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Soggetto>(
      action: 'findUniqueSoggettoOrThrow',
      result: result,
      factory: (e) => _i2.Soggetto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Soggetto?> findFirst({
    _i3.SoggettoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.SoggettoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.SoggettoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.SoggettoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.SoggettoScalar, Iterable<_i3.SoggettoScalar>>? distinct,
    _i3.SoggettoSelect? select,
    _i3.SoggettoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Soggetto?>(
      action: 'findFirstSoggetto',
      result: result,
      factory: (e) => e != null ? _i2.Soggetto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Soggetto> findFirstOrThrow({
    _i3.SoggettoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.SoggettoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.SoggettoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.SoggettoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.SoggettoScalar, Iterable<_i3.SoggettoScalar>>? distinct,
    _i3.SoggettoSelect? select,
    _i3.SoggettoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Soggetto>(
      action: 'findFirstSoggettoOrThrow',
      result: result,
      factory: (e) => _i2.Soggetto.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Soggetto>> findMany({
    _i3.SoggettoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.SoggettoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.SoggettoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.SoggettoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.SoggettoScalar, Iterable<_i3.SoggettoScalar>>? distinct,
    _i3.SoggettoSelect? select,
    _i3.SoggettoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Soggetto>>(
      action: 'findManySoggetto',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Soggetto.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Soggetto> create({
    required _i1
        .PrismaUnion<_i3.SoggettoCreateInput, _i3.SoggettoUncheckedCreateInput>
        data,
    _i3.SoggettoSelect? select,
    _i3.SoggettoInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Soggetto>(
      action: 'createOneSoggetto',
      result: result,
      factory: (e) => _i2.Soggetto.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.SoggettoCreateManyInput,
            Iterable<_i3.SoggettoCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManySoggetto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Soggetto?> update({
    required _i1
        .PrismaUnion<_i3.SoggettoUpdateInput, _i3.SoggettoUncheckedUpdateInput>
        data,
    required _i3.SoggettoWhereUniqueInput where,
    _i3.SoggettoSelect? select,
    _i3.SoggettoInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Soggetto?>(
      action: 'updateOneSoggetto',
      result: result,
      factory: (e) => e != null ? _i2.Soggetto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.SoggettoUpdateManyMutationInput,
            _i3.SoggettoUncheckedUpdateManyInput>
        data,
    _i3.SoggettoWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManySoggetto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Soggetto> upsert({
    required _i3.SoggettoWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.SoggettoCreateInput, _i3.SoggettoUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.SoggettoUpdateInput, _i3.SoggettoUncheckedUpdateInput>
        update,
    _i3.SoggettoSelect? select,
    _i3.SoggettoInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Soggetto>(
      action: 'upsertOneSoggetto',
      result: result,
      factory: (e) => _i2.Soggetto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Soggetto?> delete({
    required _i3.SoggettoWhereUniqueInput where,
    _i3.SoggettoSelect? select,
    _i3.SoggettoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Soggetto?>(
      action: 'deleteOneSoggetto',
      result: result,
      factory: (e) => e != null ? _i2.Soggetto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.SoggettoWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManySoggetto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.SoggettoGroupByOutputType>> groupBy({
    _i3.SoggettoWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.SoggettoOrderByWithAggregationInput>,
            _i3.SoggettoOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.SoggettoScalar>, _i3.SoggettoScalar>
        by,
    _i3.SoggettoScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.SoggettoGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.SoggettoGroupByOutputType>>(
      action: 'groupBySoggetto',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.SoggettoGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateSoggetto> aggregate({
    _i3.SoggettoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.SoggettoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.SoggettoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.SoggettoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateSoggettoSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Soggetto',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateSoggetto>(
      action: 'aggregateSoggetto',
      result: result,
      factory: (e) => _i3.AggregateSoggetto.fromJson(e),
    );
  }
}

class PrivacyDelegate {
  const PrivacyDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Privacy?> findUnique({
    required _i3.PrivacyWhereUniqueInput where,
    _i3.PrivacySelect? select,
    _i3.PrivacyInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Privacy?>(
      action: 'findUniquePrivacy',
      result: result,
      factory: (e) => e != null ? _i2.Privacy.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Privacy> findUniqueOrThrow({
    required _i3.PrivacyWhereUniqueInput where,
    _i3.PrivacySelect? select,
    _i3.PrivacyInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Privacy>(
      action: 'findUniquePrivacyOrThrow',
      result: result,
      factory: (e) => _i2.Privacy.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Privacy?> findFirst({
    _i3.PrivacyWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.PrivacyOrderByWithRelationAndSearchRelevanceInput>,
            _i3.PrivacyOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.PrivacyWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.PrivacyScalar, Iterable<_i3.PrivacyScalar>>? distinct,
    _i3.PrivacySelect? select,
    _i3.PrivacyInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Privacy?>(
      action: 'findFirstPrivacy',
      result: result,
      factory: (e) => e != null ? _i2.Privacy.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Privacy> findFirstOrThrow({
    _i3.PrivacyWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.PrivacyOrderByWithRelationAndSearchRelevanceInput>,
            _i3.PrivacyOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.PrivacyWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.PrivacyScalar, Iterable<_i3.PrivacyScalar>>? distinct,
    _i3.PrivacySelect? select,
    _i3.PrivacyInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Privacy>(
      action: 'findFirstPrivacyOrThrow',
      result: result,
      factory: (e) => _i2.Privacy.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Privacy>> findMany({
    _i3.PrivacyWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.PrivacyOrderByWithRelationAndSearchRelevanceInput>,
            _i3.PrivacyOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.PrivacyWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.PrivacyScalar, Iterable<_i3.PrivacyScalar>>? distinct,
    _i3.PrivacySelect? select,
    _i3.PrivacyInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Privacy>>(
      action: 'findManyPrivacy',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Privacy.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Privacy> create({
    _i1.PrismaUnion<_i3.PrivacyCreateInput, _i3.PrivacyUncheckedCreateInput>?
        data,
    _i3.PrivacySelect? select,
    _i3.PrivacyInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Privacy>(
      action: 'createOnePrivacy',
      result: result,
      factory: (e) => _i2.Privacy.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.PrivacyCreateManyInput,
            Iterable<_i3.PrivacyCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyPrivacy',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Privacy?> update({
    required _i1
        .PrismaUnion<_i3.PrivacyUpdateInput, _i3.PrivacyUncheckedUpdateInput>
        data,
    required _i3.PrivacyWhereUniqueInput where,
    _i3.PrivacySelect? select,
    _i3.PrivacyInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Privacy?>(
      action: 'updateOnePrivacy',
      result: result,
      factory: (e) => e != null ? _i2.Privacy.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.PrivacyUpdateManyMutationInput,
            _i3.PrivacyUncheckedUpdateManyInput>
        data,
    _i3.PrivacyWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyPrivacy',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Privacy> upsert({
    required _i3.PrivacyWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.PrivacyCreateInput, _i3.PrivacyUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.PrivacyUpdateInput, _i3.PrivacyUncheckedUpdateInput>
        update,
    _i3.PrivacySelect? select,
    _i3.PrivacyInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Privacy>(
      action: 'upsertOnePrivacy',
      result: result,
      factory: (e) => _i2.Privacy.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Privacy?> delete({
    required _i3.PrivacyWhereUniqueInput where,
    _i3.PrivacySelect? select,
    _i3.PrivacyInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Privacy?>(
      action: 'deleteOnePrivacy',
      result: result,
      factory: (e) => e != null ? _i2.Privacy.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.PrivacyWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyPrivacy',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.PrivacyGroupByOutputType>> groupBy({
    _i3.PrivacyWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.PrivacyOrderByWithAggregationInput>,
            _i3.PrivacyOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.PrivacyScalar>, _i3.PrivacyScalar> by,
    _i3.PrivacyScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.PrivacyGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.PrivacyGroupByOutputType>>(
      action: 'groupByPrivacy',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.PrivacyGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregatePrivacy> aggregate({
    _i3.PrivacyWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.PrivacyOrderByWithRelationAndSearchRelevanceInput>,
            _i3.PrivacyOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.PrivacyWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregatePrivacySelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Privacy',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregatePrivacy>(
      action: 'aggregatePrivacy',
      result: result,
      factory: (e) => _i3.AggregatePrivacy.fromJson(e),
    );
  }
}

class SoggettoBusinessInfoDelegate {
  const SoggettoBusinessInfoDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.SoggettoBusinessInfo?> findUnique({
    required _i3.SoggettoBusinessInfoWhereUniqueInput where,
    _i3.SoggettoBusinessInfoSelect? select,
    _i3.SoggettoBusinessInfoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.SoggettoBusinessInfo?>(
      action: 'findUniqueSoggettoBusinessInfo',
      result: result,
      factory: (e) => e != null ? _i2.SoggettoBusinessInfo.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.SoggettoBusinessInfo> findUniqueOrThrow({
    required _i3.SoggettoBusinessInfoWhereUniqueInput where,
    _i3.SoggettoBusinessInfoSelect? select,
    _i3.SoggettoBusinessInfoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.SoggettoBusinessInfo>(
      action: 'findUniqueSoggettoBusinessInfoOrThrow',
      result: result,
      factory: (e) => _i2.SoggettoBusinessInfo.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.SoggettoBusinessInfo?> findFirst({
    _i3.SoggettoBusinessInfoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .SoggettoBusinessInfoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.SoggettoBusinessInfoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.SoggettoBusinessInfoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.SoggettoBusinessInfoScalar,
            Iterable<_i3.SoggettoBusinessInfoScalar>>?
        distinct,
    _i3.SoggettoBusinessInfoSelect? select,
    _i3.SoggettoBusinessInfoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.SoggettoBusinessInfo?>(
      action: 'findFirstSoggettoBusinessInfo',
      result: result,
      factory: (e) => e != null ? _i2.SoggettoBusinessInfo.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.SoggettoBusinessInfo> findFirstOrThrow({
    _i3.SoggettoBusinessInfoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .SoggettoBusinessInfoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.SoggettoBusinessInfoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.SoggettoBusinessInfoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.SoggettoBusinessInfoScalar,
            Iterable<_i3.SoggettoBusinessInfoScalar>>?
        distinct,
    _i3.SoggettoBusinessInfoSelect? select,
    _i3.SoggettoBusinessInfoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.SoggettoBusinessInfo>(
      action: 'findFirstSoggettoBusinessInfoOrThrow',
      result: result,
      factory: (e) => _i2.SoggettoBusinessInfo.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.SoggettoBusinessInfo>> findMany({
    _i3.SoggettoBusinessInfoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .SoggettoBusinessInfoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.SoggettoBusinessInfoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.SoggettoBusinessInfoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.SoggettoBusinessInfoScalar,
            Iterable<_i3.SoggettoBusinessInfoScalar>>?
        distinct,
    _i3.SoggettoBusinessInfoSelect? select,
    _i3.SoggettoBusinessInfoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.SoggettoBusinessInfo>>(
      action: 'findManySoggettoBusinessInfo',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.SoggettoBusinessInfo.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.SoggettoBusinessInfo> create({
    required _i1.PrismaUnion<_i3.SoggettoBusinessInfoCreateInput,
            _i3.SoggettoBusinessInfoUncheckedCreateInput>
        data,
    _i3.SoggettoBusinessInfoSelect? select,
    _i3.SoggettoBusinessInfoInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.SoggettoBusinessInfo>(
      action: 'createOneSoggettoBusinessInfo',
      result: result,
      factory: (e) => _i2.SoggettoBusinessInfo.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.SoggettoBusinessInfoCreateManyInput,
            Iterable<_i3.SoggettoBusinessInfoCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManySoggettoBusinessInfo',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.SoggettoBusinessInfo?> update({
    required _i1.PrismaUnion<_i3.SoggettoBusinessInfoUpdateInput,
            _i3.SoggettoBusinessInfoUncheckedUpdateInput>
        data,
    required _i3.SoggettoBusinessInfoWhereUniqueInput where,
    _i3.SoggettoBusinessInfoSelect? select,
    _i3.SoggettoBusinessInfoInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.SoggettoBusinessInfo?>(
      action: 'updateOneSoggettoBusinessInfo',
      result: result,
      factory: (e) => e != null ? _i2.SoggettoBusinessInfo.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.SoggettoBusinessInfoUpdateManyMutationInput,
            _i3.SoggettoBusinessInfoUncheckedUpdateManyInput>
        data,
    _i3.SoggettoBusinessInfoWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManySoggettoBusinessInfo',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.SoggettoBusinessInfo> upsert({
    required _i3.SoggettoBusinessInfoWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.SoggettoBusinessInfoCreateInput,
            _i3.SoggettoBusinessInfoUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.SoggettoBusinessInfoUpdateInput,
            _i3.SoggettoBusinessInfoUncheckedUpdateInput>
        update,
    _i3.SoggettoBusinessInfoSelect? select,
    _i3.SoggettoBusinessInfoInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.SoggettoBusinessInfo>(
      action: 'upsertOneSoggettoBusinessInfo',
      result: result,
      factory: (e) => _i2.SoggettoBusinessInfo.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.SoggettoBusinessInfo?> delete({
    required _i3.SoggettoBusinessInfoWhereUniqueInput where,
    _i3.SoggettoBusinessInfoSelect? select,
    _i3.SoggettoBusinessInfoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.SoggettoBusinessInfo?>(
      action: 'deleteOneSoggettoBusinessInfo',
      result: result,
      factory: (e) => e != null ? _i2.SoggettoBusinessInfo.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.SoggettoBusinessInfoWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManySoggettoBusinessInfo',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.SoggettoBusinessInfoGroupByOutputType>>
      groupBy({
    _i3.SoggettoBusinessInfoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.SoggettoBusinessInfoOrderByWithAggregationInput>,
            _i3.SoggettoBusinessInfoOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.SoggettoBusinessInfoScalar>,
            _i3.SoggettoBusinessInfoScalar>
        by,
    _i3.SoggettoBusinessInfoScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.SoggettoBusinessInfoGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i3.SoggettoBusinessInfoGroupByOutputType>>(
      action: 'groupBySoggettoBusinessInfo',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.SoggettoBusinessInfoGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateSoggettoBusinessInfo> aggregate({
    _i3.SoggettoBusinessInfoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .SoggettoBusinessInfoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.SoggettoBusinessInfoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.SoggettoBusinessInfoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateSoggettoBusinessInfoSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'SoggettoBusinessInfo',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateSoggettoBusinessInfo>(
      action: 'aggregateSoggettoBusinessInfo',
      result: result,
      factory: (e) => _i3.AggregateSoggettoBusinessInfo.fromJson(e),
    );
  }
}

class LegaleRappresentanteDelegate {
  const LegaleRappresentanteDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.LegaleRappresentante?> findUnique({
    required _i3.LegaleRappresentanteWhereUniqueInput where,
    _i3.LegaleRappresentanteSelect? select,
    _i3.LegaleRappresentanteInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.LegaleRappresentante?>(
      action: 'findUniqueLegaleRappresentante',
      result: result,
      factory: (e) => e != null ? _i2.LegaleRappresentante.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.LegaleRappresentante> findUniqueOrThrow({
    required _i3.LegaleRappresentanteWhereUniqueInput where,
    _i3.LegaleRappresentanteSelect? select,
    _i3.LegaleRappresentanteInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.LegaleRappresentante>(
      action: 'findUniqueLegaleRappresentanteOrThrow',
      result: result,
      factory: (e) => _i2.LegaleRappresentante.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.LegaleRappresentante?> findFirst({
    _i3.LegaleRappresentanteWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .LegaleRappresentanteOrderByWithRelationAndSearchRelevanceInput>,
            _i3.LegaleRappresentanteOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.LegaleRappresentanteWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.LegaleRappresentanteScalar,
            Iterable<_i3.LegaleRappresentanteScalar>>?
        distinct,
    _i3.LegaleRappresentanteSelect? select,
    _i3.LegaleRappresentanteInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.LegaleRappresentante?>(
      action: 'findFirstLegaleRappresentante',
      result: result,
      factory: (e) => e != null ? _i2.LegaleRappresentante.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.LegaleRappresentante> findFirstOrThrow({
    _i3.LegaleRappresentanteWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .LegaleRappresentanteOrderByWithRelationAndSearchRelevanceInput>,
            _i3.LegaleRappresentanteOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.LegaleRappresentanteWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.LegaleRappresentanteScalar,
            Iterable<_i3.LegaleRappresentanteScalar>>?
        distinct,
    _i3.LegaleRappresentanteSelect? select,
    _i3.LegaleRappresentanteInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.LegaleRappresentante>(
      action: 'findFirstLegaleRappresentanteOrThrow',
      result: result,
      factory: (e) => _i2.LegaleRappresentante.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.LegaleRappresentante>> findMany({
    _i3.LegaleRappresentanteWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .LegaleRappresentanteOrderByWithRelationAndSearchRelevanceInput>,
            _i3.LegaleRappresentanteOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.LegaleRappresentanteWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.LegaleRappresentanteScalar,
            Iterable<_i3.LegaleRappresentanteScalar>>?
        distinct,
    _i3.LegaleRappresentanteSelect? select,
    _i3.LegaleRappresentanteInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.LegaleRappresentante>>(
      action: 'findManyLegaleRappresentante',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.LegaleRappresentante.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.LegaleRappresentante> create({
    required _i1.PrismaUnion<_i3.LegaleRappresentanteCreateInput,
            _i3.LegaleRappresentanteUncheckedCreateInput>
        data,
    _i3.LegaleRappresentanteSelect? select,
    _i3.LegaleRappresentanteInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.LegaleRappresentante>(
      action: 'createOneLegaleRappresentante',
      result: result,
      factory: (e) => _i2.LegaleRappresentante.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.LegaleRappresentanteCreateManyInput,
            Iterable<_i3.LegaleRappresentanteCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyLegaleRappresentante',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.LegaleRappresentante?> update({
    required _i1.PrismaUnion<_i3.LegaleRappresentanteUpdateInput,
            _i3.LegaleRappresentanteUncheckedUpdateInput>
        data,
    required _i3.LegaleRappresentanteWhereUniqueInput where,
    _i3.LegaleRappresentanteSelect? select,
    _i3.LegaleRappresentanteInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.LegaleRappresentante?>(
      action: 'updateOneLegaleRappresentante',
      result: result,
      factory: (e) => e != null ? _i2.LegaleRappresentante.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.LegaleRappresentanteUpdateManyMutationInput,
            _i3.LegaleRappresentanteUncheckedUpdateManyInput>
        data,
    _i3.LegaleRappresentanteWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyLegaleRappresentante',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.LegaleRappresentante> upsert({
    required _i3.LegaleRappresentanteWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.LegaleRappresentanteCreateInput,
            _i3.LegaleRappresentanteUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.LegaleRappresentanteUpdateInput,
            _i3.LegaleRappresentanteUncheckedUpdateInput>
        update,
    _i3.LegaleRappresentanteSelect? select,
    _i3.LegaleRappresentanteInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.LegaleRappresentante>(
      action: 'upsertOneLegaleRappresentante',
      result: result,
      factory: (e) => _i2.LegaleRappresentante.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.LegaleRappresentante?> delete({
    required _i3.LegaleRappresentanteWhereUniqueInput where,
    _i3.LegaleRappresentanteSelect? select,
    _i3.LegaleRappresentanteInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.LegaleRappresentante?>(
      action: 'deleteOneLegaleRappresentante',
      result: result,
      factory: (e) => e != null ? _i2.LegaleRappresentante.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.LegaleRappresentanteWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyLegaleRappresentante',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.LegaleRappresentanteGroupByOutputType>>
      groupBy({
    _i3.LegaleRappresentanteWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.LegaleRappresentanteOrderByWithAggregationInput>,
            _i3.LegaleRappresentanteOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.LegaleRappresentanteScalar>,
            _i3.LegaleRappresentanteScalar>
        by,
    _i3.LegaleRappresentanteScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.LegaleRappresentanteGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i3.LegaleRappresentanteGroupByOutputType>>(
      action: 'groupByLegaleRappresentante',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.LegaleRappresentanteGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateLegaleRappresentante> aggregate({
    _i3.LegaleRappresentanteWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .LegaleRappresentanteOrderByWithRelationAndSearchRelevanceInput>,
            _i3.LegaleRappresentanteOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.LegaleRappresentanteWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateLegaleRappresentanteSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'LegaleRappresentante',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateLegaleRappresentante>(
      action: 'aggregateLegaleRappresentante',
      result: result,
      factory: (e) => _i3.AggregateLegaleRappresentante.fromJson(e),
    );
  }
}

class ReferenteDelegate {
  const ReferenteDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Referente?> findUnique({
    required _i3.ReferenteWhereUniqueInput where,
    _i3.ReferenteSelect? select,
    _i3.ReferenteInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Referente?>(
      action: 'findUniqueReferente',
      result: result,
      factory: (e) => e != null ? _i2.Referente.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Referente> findUniqueOrThrow({
    required _i3.ReferenteWhereUniqueInput where,
    _i3.ReferenteSelect? select,
    _i3.ReferenteInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Referente>(
      action: 'findUniqueReferenteOrThrow',
      result: result,
      factory: (e) => _i2.Referente.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Referente?> findFirst({
    _i3.ReferenteWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ReferenteOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ReferenteOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ReferenteWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ReferenteScalar, Iterable<_i3.ReferenteScalar>>?
        distinct,
    _i3.ReferenteSelect? select,
    _i3.ReferenteInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Referente?>(
      action: 'findFirstReferente',
      result: result,
      factory: (e) => e != null ? _i2.Referente.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Referente> findFirstOrThrow({
    _i3.ReferenteWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ReferenteOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ReferenteOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ReferenteWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ReferenteScalar, Iterable<_i3.ReferenteScalar>>?
        distinct,
    _i3.ReferenteSelect? select,
    _i3.ReferenteInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Referente>(
      action: 'findFirstReferenteOrThrow',
      result: result,
      factory: (e) => _i2.Referente.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Referente>> findMany({
    _i3.ReferenteWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ReferenteOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ReferenteOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ReferenteWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ReferenteScalar, Iterable<_i3.ReferenteScalar>>?
        distinct,
    _i3.ReferenteSelect? select,
    _i3.ReferenteInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Referente>>(
      action: 'findManyReferente',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Referente.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Referente> create({
    required _i1.PrismaUnion<_i3.ReferenteCreateInput,
            _i3.ReferenteUncheckedCreateInput>
        data,
    _i3.ReferenteSelect? select,
    _i3.ReferenteInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Referente>(
      action: 'createOneReferente',
      result: result,
      factory: (e) => _i2.Referente.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ReferenteCreateManyInput,
            Iterable<_i3.ReferenteCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyReferente',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Referente?> update({
    required _i1.PrismaUnion<_i3.ReferenteUpdateInput,
            _i3.ReferenteUncheckedUpdateInput>
        data,
    required _i3.ReferenteWhereUniqueInput where,
    _i3.ReferenteSelect? select,
    _i3.ReferenteInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Referente?>(
      action: 'updateOneReferente',
      result: result,
      factory: (e) => e != null ? _i2.Referente.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ReferenteUpdateManyMutationInput,
            _i3.ReferenteUncheckedUpdateManyInput>
        data,
    _i3.ReferenteWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyReferente',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Referente> upsert({
    required _i3.ReferenteWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ReferenteCreateInput,
            _i3.ReferenteUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ReferenteUpdateInput,
            _i3.ReferenteUncheckedUpdateInput>
        update,
    _i3.ReferenteSelect? select,
    _i3.ReferenteInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Referente>(
      action: 'upsertOneReferente',
      result: result,
      factory: (e) => _i2.Referente.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Referente?> delete({
    required _i3.ReferenteWhereUniqueInput where,
    _i3.ReferenteSelect? select,
    _i3.ReferenteInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Referente?>(
      action: 'deleteOneReferente',
      result: result,
      factory: (e) => e != null ? _i2.Referente.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ReferenteWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyReferente',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ReferenteGroupByOutputType>> groupBy({
    _i3.ReferenteWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ReferenteOrderByWithAggregationInput>,
            _i3.ReferenteOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ReferenteScalar>, _i3.ReferenteScalar>
        by,
    _i3.ReferenteScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ReferenteGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ReferenteGroupByOutputType>>(
      action: 'groupByReferente',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ReferenteGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateReferente> aggregate({
    _i3.ReferenteWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ReferenteOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ReferenteOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ReferenteWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateReferenteSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Referente',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateReferente>(
      action: 'aggregateReferente',
      result: result,
      factory: (e) => _i3.AggregateReferente.fromJson(e),
    );
  }
}

class IndirizzoEmailDelegate {
  const IndirizzoEmailDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.IndirizzoEmail?> findUnique({
    required _i3.IndirizzoEmailWhereUniqueInput where,
    _i3.IndirizzoEmailSelect? select,
    _i3.IndirizzoEmailInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.IndirizzoEmail?>(
      action: 'findUniqueIndirizzoEmail',
      result: result,
      factory: (e) => e != null ? _i2.IndirizzoEmail.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.IndirizzoEmail> findUniqueOrThrow({
    required _i3.IndirizzoEmailWhereUniqueInput where,
    _i3.IndirizzoEmailSelect? select,
    _i3.IndirizzoEmailInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.IndirizzoEmail>(
      action: 'findUniqueIndirizzoEmailOrThrow',
      result: result,
      factory: (e) => _i2.IndirizzoEmail.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.IndirizzoEmail?> findFirst({
    _i3.IndirizzoEmailWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.IndirizzoEmailOrderByWithRelationAndSearchRelevanceInput>,
            _i3.IndirizzoEmailOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.IndirizzoEmailWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.IndirizzoEmailScalar,
            Iterable<_i3.IndirizzoEmailScalar>>?
        distinct,
    _i3.IndirizzoEmailSelect? select,
    _i3.IndirizzoEmailInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.IndirizzoEmail?>(
      action: 'findFirstIndirizzoEmail',
      result: result,
      factory: (e) => e != null ? _i2.IndirizzoEmail.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.IndirizzoEmail> findFirstOrThrow({
    _i3.IndirizzoEmailWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.IndirizzoEmailOrderByWithRelationAndSearchRelevanceInput>,
            _i3.IndirizzoEmailOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.IndirizzoEmailWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.IndirizzoEmailScalar,
            Iterable<_i3.IndirizzoEmailScalar>>?
        distinct,
    _i3.IndirizzoEmailSelect? select,
    _i3.IndirizzoEmailInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.IndirizzoEmail>(
      action: 'findFirstIndirizzoEmailOrThrow',
      result: result,
      factory: (e) => _i2.IndirizzoEmail.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.IndirizzoEmail>> findMany({
    _i3.IndirizzoEmailWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.IndirizzoEmailOrderByWithRelationAndSearchRelevanceInput>,
            _i3.IndirizzoEmailOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.IndirizzoEmailWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.IndirizzoEmailScalar,
            Iterable<_i3.IndirizzoEmailScalar>>?
        distinct,
    _i3.IndirizzoEmailSelect? select,
    _i3.IndirizzoEmailInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.IndirizzoEmail>>(
      action: 'findManyIndirizzoEmail',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.IndirizzoEmail.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.IndirizzoEmail> create({
    required _i1.PrismaUnion<_i3.IndirizzoEmailCreateInput,
            _i3.IndirizzoEmailUncheckedCreateInput>
        data,
    _i3.IndirizzoEmailSelect? select,
    _i3.IndirizzoEmailInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.IndirizzoEmail>(
      action: 'createOneIndirizzoEmail',
      result: result,
      factory: (e) => _i2.IndirizzoEmail.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.IndirizzoEmailCreateManyInput,
            Iterable<_i3.IndirizzoEmailCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyIndirizzoEmail',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.IndirizzoEmail?> update({
    required _i1.PrismaUnion<_i3.IndirizzoEmailUpdateInput,
            _i3.IndirizzoEmailUncheckedUpdateInput>
        data,
    required _i3.IndirizzoEmailWhereUniqueInput where,
    _i3.IndirizzoEmailSelect? select,
    _i3.IndirizzoEmailInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.IndirizzoEmail?>(
      action: 'updateOneIndirizzoEmail',
      result: result,
      factory: (e) => e != null ? _i2.IndirizzoEmail.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.IndirizzoEmailUpdateManyMutationInput,
            _i3.IndirizzoEmailUncheckedUpdateManyInput>
        data,
    _i3.IndirizzoEmailWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyIndirizzoEmail',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.IndirizzoEmail> upsert({
    required _i3.IndirizzoEmailWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.IndirizzoEmailCreateInput,
            _i3.IndirizzoEmailUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.IndirizzoEmailUpdateInput,
            _i3.IndirizzoEmailUncheckedUpdateInput>
        update,
    _i3.IndirizzoEmailSelect? select,
    _i3.IndirizzoEmailInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.IndirizzoEmail>(
      action: 'upsertOneIndirizzoEmail',
      result: result,
      factory: (e) => _i2.IndirizzoEmail.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.IndirizzoEmail?> delete({
    required _i3.IndirizzoEmailWhereUniqueInput where,
    _i3.IndirizzoEmailSelect? select,
    _i3.IndirizzoEmailInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.IndirizzoEmail?>(
      action: 'deleteOneIndirizzoEmail',
      result: result,
      factory: (e) => e != null ? _i2.IndirizzoEmail.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.IndirizzoEmailWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyIndirizzoEmail',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.IndirizzoEmailGroupByOutputType>> groupBy({
    _i3.IndirizzoEmailWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.IndirizzoEmailOrderByWithAggregationInput>,
            _i3.IndirizzoEmailOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.IndirizzoEmailScalar>,
            _i3.IndirizzoEmailScalar>
        by,
    _i3.IndirizzoEmailScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.IndirizzoEmailGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.IndirizzoEmailGroupByOutputType>>(
      action: 'groupByIndirizzoEmail',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.IndirizzoEmailGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateIndirizzoEmail> aggregate({
    _i3.IndirizzoEmailWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.IndirizzoEmailOrderByWithRelationAndSearchRelevanceInput>,
            _i3.IndirizzoEmailOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.IndirizzoEmailWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateIndirizzoEmailSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'IndirizzoEmail',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateIndirizzoEmail>(
      action: 'aggregateIndirizzoEmail',
      result: result,
      factory: (e) => _i3.AggregateIndirizzoEmail.fromJson(e),
    );
  }
}

class NumeroTelefonoDelegate {
  const NumeroTelefonoDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.NumeroTelefono?> findUnique({
    required _i3.NumeroTelefonoWhereUniqueInput where,
    _i3.NumeroTelefonoSelect? select,
    _i3.NumeroTelefonoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.NumeroTelefono?>(
      action: 'findUniqueNumeroTelefono',
      result: result,
      factory: (e) => e != null ? _i2.NumeroTelefono.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.NumeroTelefono> findUniqueOrThrow({
    required _i3.NumeroTelefonoWhereUniqueInput where,
    _i3.NumeroTelefonoSelect? select,
    _i3.NumeroTelefonoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.NumeroTelefono>(
      action: 'findUniqueNumeroTelefonoOrThrow',
      result: result,
      factory: (e) => _i2.NumeroTelefono.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.NumeroTelefono?> findFirst({
    _i3.NumeroTelefonoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.NumeroTelefonoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.NumeroTelefonoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.NumeroTelefonoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.NumeroTelefonoScalar,
            Iterable<_i3.NumeroTelefonoScalar>>?
        distinct,
    _i3.NumeroTelefonoSelect? select,
    _i3.NumeroTelefonoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.NumeroTelefono?>(
      action: 'findFirstNumeroTelefono',
      result: result,
      factory: (e) => e != null ? _i2.NumeroTelefono.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.NumeroTelefono> findFirstOrThrow({
    _i3.NumeroTelefonoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.NumeroTelefonoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.NumeroTelefonoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.NumeroTelefonoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.NumeroTelefonoScalar,
            Iterable<_i3.NumeroTelefonoScalar>>?
        distinct,
    _i3.NumeroTelefonoSelect? select,
    _i3.NumeroTelefonoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.NumeroTelefono>(
      action: 'findFirstNumeroTelefonoOrThrow',
      result: result,
      factory: (e) => _i2.NumeroTelefono.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.NumeroTelefono>> findMany({
    _i3.NumeroTelefonoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.NumeroTelefonoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.NumeroTelefonoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.NumeroTelefonoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.NumeroTelefonoScalar,
            Iterable<_i3.NumeroTelefonoScalar>>?
        distinct,
    _i3.NumeroTelefonoSelect? select,
    _i3.NumeroTelefonoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.NumeroTelefono>>(
      action: 'findManyNumeroTelefono',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.NumeroTelefono.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.NumeroTelefono> create({
    required _i1.PrismaUnion<_i3.NumeroTelefonoCreateInput,
            _i3.NumeroTelefonoUncheckedCreateInput>
        data,
    _i3.NumeroTelefonoSelect? select,
    _i3.NumeroTelefonoInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.NumeroTelefono>(
      action: 'createOneNumeroTelefono',
      result: result,
      factory: (e) => _i2.NumeroTelefono.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.NumeroTelefonoCreateManyInput,
            Iterable<_i3.NumeroTelefonoCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyNumeroTelefono',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.NumeroTelefono?> update({
    required _i1.PrismaUnion<_i3.NumeroTelefonoUpdateInput,
            _i3.NumeroTelefonoUncheckedUpdateInput>
        data,
    required _i3.NumeroTelefonoWhereUniqueInput where,
    _i3.NumeroTelefonoSelect? select,
    _i3.NumeroTelefonoInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.NumeroTelefono?>(
      action: 'updateOneNumeroTelefono',
      result: result,
      factory: (e) => e != null ? _i2.NumeroTelefono.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.NumeroTelefonoUpdateManyMutationInput,
            _i3.NumeroTelefonoUncheckedUpdateManyInput>
        data,
    _i3.NumeroTelefonoWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyNumeroTelefono',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.NumeroTelefono> upsert({
    required _i3.NumeroTelefonoWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.NumeroTelefonoCreateInput,
            _i3.NumeroTelefonoUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.NumeroTelefonoUpdateInput,
            _i3.NumeroTelefonoUncheckedUpdateInput>
        update,
    _i3.NumeroTelefonoSelect? select,
    _i3.NumeroTelefonoInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.NumeroTelefono>(
      action: 'upsertOneNumeroTelefono',
      result: result,
      factory: (e) => _i2.NumeroTelefono.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.NumeroTelefono?> delete({
    required _i3.NumeroTelefonoWhereUniqueInput where,
    _i3.NumeroTelefonoSelect? select,
    _i3.NumeroTelefonoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.NumeroTelefono?>(
      action: 'deleteOneNumeroTelefono',
      result: result,
      factory: (e) => e != null ? _i2.NumeroTelefono.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.NumeroTelefonoWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyNumeroTelefono',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.NumeroTelefonoGroupByOutputType>> groupBy({
    _i3.NumeroTelefonoWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.NumeroTelefonoOrderByWithAggregationInput>,
            _i3.NumeroTelefonoOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.NumeroTelefonoScalar>,
            _i3.NumeroTelefonoScalar>
        by,
    _i3.NumeroTelefonoScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.NumeroTelefonoGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.NumeroTelefonoGroupByOutputType>>(
      action: 'groupByNumeroTelefono',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.NumeroTelefonoGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateNumeroTelefono> aggregate({
    _i3.NumeroTelefonoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.NumeroTelefonoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.NumeroTelefonoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.NumeroTelefonoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateNumeroTelefonoSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'NumeroTelefono',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateNumeroTelefono>(
      action: 'aggregateNumeroTelefono',
      result: result,
      factory: (e) => _i3.AggregateNumeroTelefono.fromJson(e),
    );
  }
}

class DomicilioDelegate {
  const DomicilioDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Domicilio?> findUnique({
    required _i3.DomicilioWhereUniqueInput where,
    _i3.DomicilioSelect? select,
    _i3.DomicilioInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Domicilio?>(
      action: 'findUniqueDomicilio',
      result: result,
      factory: (e) => e != null ? _i2.Domicilio.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Domicilio> findUniqueOrThrow({
    required _i3.DomicilioWhereUniqueInput where,
    _i3.DomicilioSelect? select,
    _i3.DomicilioInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Domicilio>(
      action: 'findUniqueDomicilioOrThrow',
      result: result,
      factory: (e) => _i2.Domicilio.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Domicilio?> findFirst({
    _i3.DomicilioWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.DomicilioOrderByWithRelationAndSearchRelevanceInput>,
            _i3.DomicilioOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.DomicilioWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.DomicilioScalar, Iterable<_i3.DomicilioScalar>>?
        distinct,
    _i3.DomicilioSelect? select,
    _i3.DomicilioInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Domicilio?>(
      action: 'findFirstDomicilio',
      result: result,
      factory: (e) => e != null ? _i2.Domicilio.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Domicilio> findFirstOrThrow({
    _i3.DomicilioWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.DomicilioOrderByWithRelationAndSearchRelevanceInput>,
            _i3.DomicilioOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.DomicilioWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.DomicilioScalar, Iterable<_i3.DomicilioScalar>>?
        distinct,
    _i3.DomicilioSelect? select,
    _i3.DomicilioInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Domicilio>(
      action: 'findFirstDomicilioOrThrow',
      result: result,
      factory: (e) => _i2.Domicilio.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Domicilio>> findMany({
    _i3.DomicilioWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.DomicilioOrderByWithRelationAndSearchRelevanceInput>,
            _i3.DomicilioOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.DomicilioWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.DomicilioScalar, Iterable<_i3.DomicilioScalar>>?
        distinct,
    _i3.DomicilioSelect? select,
    _i3.DomicilioInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Domicilio>>(
      action: 'findManyDomicilio',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Domicilio.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Domicilio> create({
    required _i1.PrismaUnion<_i3.DomicilioCreateInput,
            _i3.DomicilioUncheckedCreateInput>
        data,
    _i3.DomicilioSelect? select,
    _i3.DomicilioInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Domicilio>(
      action: 'createOneDomicilio',
      result: result,
      factory: (e) => _i2.Domicilio.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.DomicilioCreateManyInput,
            Iterable<_i3.DomicilioCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyDomicilio',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Domicilio?> update({
    required _i1.PrismaUnion<_i3.DomicilioUpdateInput,
            _i3.DomicilioUncheckedUpdateInput>
        data,
    required _i3.DomicilioWhereUniqueInput where,
    _i3.DomicilioSelect? select,
    _i3.DomicilioInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Domicilio?>(
      action: 'updateOneDomicilio',
      result: result,
      factory: (e) => e != null ? _i2.Domicilio.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.DomicilioUpdateManyMutationInput,
            _i3.DomicilioUncheckedUpdateManyInput>
        data,
    _i3.DomicilioWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyDomicilio',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Domicilio> upsert({
    required _i3.DomicilioWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.DomicilioCreateInput,
            _i3.DomicilioUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.DomicilioUpdateInput,
            _i3.DomicilioUncheckedUpdateInput>
        update,
    _i3.DomicilioSelect? select,
    _i3.DomicilioInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Domicilio>(
      action: 'upsertOneDomicilio',
      result: result,
      factory: (e) => _i2.Domicilio.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Domicilio?> delete({
    required _i3.DomicilioWhereUniqueInput where,
    _i3.DomicilioSelect? select,
    _i3.DomicilioInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Domicilio?>(
      action: 'deleteOneDomicilio',
      result: result,
      factory: (e) => e != null ? _i2.Domicilio.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.DomicilioWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyDomicilio',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.DomicilioGroupByOutputType>> groupBy({
    _i3.DomicilioWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.DomicilioOrderByWithAggregationInput>,
            _i3.DomicilioOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.DomicilioScalar>, _i3.DomicilioScalar>
        by,
    _i3.DomicilioScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.DomicilioGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.DomicilioGroupByOutputType>>(
      action: 'groupByDomicilio',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.DomicilioGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateDomicilio> aggregate({
    _i3.DomicilioWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.DomicilioOrderByWithRelationAndSearchRelevanceInput>,
            _i3.DomicilioOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.DomicilioWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateDomicilioSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Domicilio',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateDomicilio>(
      action: 'aggregateDomicilio',
      result: result,
      factory: (e) => _i3.AggregateDomicilio.fromJson(e),
    );
  }
}

class ServizioEwoDelegate {
  const ServizioEwoDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.ServizioEwo?> findUnique({
    required _i3.ServizioEwoWhereUniqueInput where,
    _i3.ServizioEwoSelect? select,
    _i3.ServizioEwoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ServizioEwo?>(
      action: 'findUniqueServizioEwo',
      result: result,
      factory: (e) => e != null ? _i2.ServizioEwo.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ServizioEwo> findUniqueOrThrow({
    required _i3.ServizioEwoWhereUniqueInput where,
    _i3.ServizioEwoSelect? select,
    _i3.ServizioEwoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ServizioEwo>(
      action: 'findUniqueServizioEwoOrThrow',
      result: result,
      factory: (e) => _i2.ServizioEwo.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ServizioEwo?> findFirst({
    _i3.ServizioEwoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ServizioEwoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ServizioEwoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ServizioEwoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ServizioEwoScalar, Iterable<_i3.ServizioEwoScalar>>?
        distinct,
    _i3.ServizioEwoSelect? select,
    _i3.ServizioEwoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ServizioEwo?>(
      action: 'findFirstServizioEwo',
      result: result,
      factory: (e) => e != null ? _i2.ServizioEwo.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ServizioEwo> findFirstOrThrow({
    _i3.ServizioEwoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ServizioEwoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ServizioEwoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ServizioEwoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ServizioEwoScalar, Iterable<_i3.ServizioEwoScalar>>?
        distinct,
    _i3.ServizioEwoSelect? select,
    _i3.ServizioEwoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ServizioEwo>(
      action: 'findFirstServizioEwoOrThrow',
      result: result,
      factory: (e) => _i2.ServizioEwo.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.ServizioEwo>> findMany({
    _i3.ServizioEwoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ServizioEwoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ServizioEwoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ServizioEwoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ServizioEwoScalar, Iterable<_i3.ServizioEwoScalar>>?
        distinct,
    _i3.ServizioEwoSelect? select,
    _i3.ServizioEwoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.ServizioEwo>>(
      action: 'findManyServizioEwo',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.ServizioEwo.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ServizioEwo> create({
    required _i1.PrismaUnion<_i3.ServizioEwoCreateInput,
            _i3.ServizioEwoUncheckedCreateInput>
        data,
    _i3.ServizioEwoSelect? select,
    _i3.ServizioEwoInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ServizioEwo>(
      action: 'createOneServizioEwo',
      result: result,
      factory: (e) => _i2.ServizioEwo.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ServizioEwoCreateManyInput,
            Iterable<_i3.ServizioEwoCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyServizioEwo',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ServizioEwo?> update({
    required _i1.PrismaUnion<_i3.ServizioEwoUpdateInput,
            _i3.ServizioEwoUncheckedUpdateInput>
        data,
    required _i3.ServizioEwoWhereUniqueInput where,
    _i3.ServizioEwoSelect? select,
    _i3.ServizioEwoInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ServizioEwo?>(
      action: 'updateOneServizioEwo',
      result: result,
      factory: (e) => e != null ? _i2.ServizioEwo.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ServizioEwoUpdateManyMutationInput,
            _i3.ServizioEwoUncheckedUpdateManyInput>
        data,
    _i3.ServizioEwoWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyServizioEwo',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ServizioEwo> upsert({
    required _i3.ServizioEwoWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ServizioEwoCreateInput,
            _i3.ServizioEwoUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ServizioEwoUpdateInput,
            _i3.ServizioEwoUncheckedUpdateInput>
        update,
    _i3.ServizioEwoSelect? select,
    _i3.ServizioEwoInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ServizioEwo>(
      action: 'upsertOneServizioEwo',
      result: result,
      factory: (e) => _i2.ServizioEwo.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ServizioEwo?> delete({
    required _i3.ServizioEwoWhereUniqueInput where,
    _i3.ServizioEwoSelect? select,
    _i3.ServizioEwoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ServizioEwo?>(
      action: 'deleteOneServizioEwo',
      result: result,
      factory: (e) => e != null ? _i2.ServizioEwo.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ServizioEwoWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyServizioEwo',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ServizioEwoGroupByOutputType>> groupBy({
    _i3.ServizioEwoWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ServizioEwoOrderByWithAggregationInput>,
            _i3.ServizioEwoOrderByWithAggregationInput>?
        orderBy,
    required _i1
        .PrismaUnion<Iterable<_i3.ServizioEwoScalar>, _i3.ServizioEwoScalar>
        by,
    _i3.ServizioEwoScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ServizioEwoGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ServizioEwoGroupByOutputType>>(
      action: 'groupByServizioEwo',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ServizioEwoGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateServizioEwo> aggregate({
    _i3.ServizioEwoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ServizioEwoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ServizioEwoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ServizioEwoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateServizioEwoSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ServizioEwo',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateServizioEwo>(
      action: 'aggregateServizioEwo',
      result: result,
      factory: (e) => _i3.AggregateServizioEwo.fromJson(e),
    );
  }
}

class FornituraDelegate {
  const FornituraDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Fornitura?> findUnique({
    required _i3.FornituraWhereUniqueInput where,
    _i3.FornituraSelect? select,
    _i3.FornituraInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitura?>(
      action: 'findUniqueFornitura',
      result: result,
      factory: (e) => e != null ? _i2.Fornitura.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Fornitura> findUniqueOrThrow({
    required _i3.FornituraWhereUniqueInput where,
    _i3.FornituraSelect? select,
    _i3.FornituraInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitura>(
      action: 'findUniqueFornituraOrThrow',
      result: result,
      factory: (e) => _i2.Fornitura.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Fornitura?> findFirst({
    _i3.FornituraWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.FornituraOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornituraOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornituraWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.FornituraScalar, Iterable<_i3.FornituraScalar>>?
        distinct,
    _i3.FornituraSelect? select,
    _i3.FornituraInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitura?>(
      action: 'findFirstFornitura',
      result: result,
      factory: (e) => e != null ? _i2.Fornitura.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Fornitura> findFirstOrThrow({
    _i3.FornituraWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.FornituraOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornituraOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornituraWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.FornituraScalar, Iterable<_i3.FornituraScalar>>?
        distinct,
    _i3.FornituraSelect? select,
    _i3.FornituraInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitura>(
      action: 'findFirstFornituraOrThrow',
      result: result,
      factory: (e) => _i2.Fornitura.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Fornitura>> findMany({
    _i3.FornituraWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.FornituraOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornituraOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornituraWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.FornituraScalar, Iterable<_i3.FornituraScalar>>?
        distinct,
    _i3.FornituraSelect? select,
    _i3.FornituraInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Fornitura>>(
      action: 'findManyFornitura',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Fornitura.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Fornitura> create({
    required _i1.PrismaUnion<_i3.FornituraCreateInput,
            _i3.FornituraUncheckedCreateInput>
        data,
    _i3.FornituraSelect? select,
    _i3.FornituraInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitura>(
      action: 'createOneFornitura',
      result: result,
      factory: (e) => _i2.Fornitura.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.FornituraCreateManyInput,
            Iterable<_i3.FornituraCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyFornitura',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Fornitura?> update({
    required _i1.PrismaUnion<_i3.FornituraUpdateInput,
            _i3.FornituraUncheckedUpdateInput>
        data,
    required _i3.FornituraWhereUniqueInput where,
    _i3.FornituraSelect? select,
    _i3.FornituraInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitura?>(
      action: 'updateOneFornitura',
      result: result,
      factory: (e) => e != null ? _i2.Fornitura.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.FornituraUpdateManyMutationInput,
            _i3.FornituraUncheckedUpdateManyInput>
        data,
    _i3.FornituraWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyFornitura',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Fornitura> upsert({
    required _i3.FornituraWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.FornituraCreateInput,
            _i3.FornituraUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.FornituraUpdateInput,
            _i3.FornituraUncheckedUpdateInput>
        update,
    _i3.FornituraSelect? select,
    _i3.FornituraInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitura>(
      action: 'upsertOneFornitura',
      result: result,
      factory: (e) => _i2.Fornitura.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Fornitura?> delete({
    required _i3.FornituraWhereUniqueInput where,
    _i3.FornituraSelect? select,
    _i3.FornituraInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitura?>(
      action: 'deleteOneFornitura',
      result: result,
      factory: (e) => e != null ? _i2.Fornitura.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.FornituraWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyFornitura',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.FornituraGroupByOutputType>> groupBy({
    _i3.FornituraWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.FornituraOrderByWithAggregationInput>,
            _i3.FornituraOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.FornituraScalar>, _i3.FornituraScalar>
        by,
    _i3.FornituraScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.FornituraGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.FornituraGroupByOutputType>>(
      action: 'groupByFornitura',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.FornituraGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateFornitura> aggregate({
    _i3.FornituraWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.FornituraOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornituraOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornituraWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateFornituraSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitura',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateFornitura>(
      action: 'aggregateFornitura',
      result: result,
      factory: (e) => _i3.AggregateFornitura.fromJson(e),
    );
  }
}

class FornituraLuceDelegate {
  const FornituraLuceDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.FornituraLuce?> findUnique({
    required _i3.FornituraLuceWhereUniqueInput where,
    _i3.FornituraLuceSelect? select,
    _i3.FornituraLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraLuce?>(
      action: 'findUniqueFornituraLuce',
      result: result,
      factory: (e) => e != null ? _i2.FornituraLuce.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.FornituraLuce> findUniqueOrThrow({
    required _i3.FornituraLuceWhereUniqueInput where,
    _i3.FornituraLuceSelect? select,
    _i3.FornituraLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraLuce>(
      action: 'findUniqueFornituraLuceOrThrow',
      result: result,
      factory: (e) => _i2.FornituraLuce.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.FornituraLuce?> findFirst({
    _i3.FornituraLuceWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.FornituraLuceOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornituraLuceOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornituraLuceWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.FornituraLuceScalar, Iterable<_i3.FornituraLuceScalar>>?
        distinct,
    _i3.FornituraLuceSelect? select,
    _i3.FornituraLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraLuce?>(
      action: 'findFirstFornituraLuce',
      result: result,
      factory: (e) => e != null ? _i2.FornituraLuce.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.FornituraLuce> findFirstOrThrow({
    _i3.FornituraLuceWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.FornituraLuceOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornituraLuceOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornituraLuceWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.FornituraLuceScalar, Iterable<_i3.FornituraLuceScalar>>?
        distinct,
    _i3.FornituraLuceSelect? select,
    _i3.FornituraLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraLuce>(
      action: 'findFirstFornituraLuceOrThrow',
      result: result,
      factory: (e) => _i2.FornituraLuce.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.FornituraLuce>> findMany({
    _i3.FornituraLuceWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.FornituraLuceOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornituraLuceOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornituraLuceWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.FornituraLuceScalar, Iterable<_i3.FornituraLuceScalar>>?
        distinct,
    _i3.FornituraLuceSelect? select,
    _i3.FornituraLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.FornituraLuce>>(
      action: 'findManyFornituraLuce',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.FornituraLuce.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.FornituraLuce> create({
    required _i1.PrismaUnion<_i3.FornituraLuceCreateInput,
            _i3.FornituraLuceUncheckedCreateInput>
        data,
    _i3.FornituraLuceSelect? select,
    _i3.FornituraLuceInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraLuce>(
      action: 'createOneFornituraLuce',
      result: result,
      factory: (e) => _i2.FornituraLuce.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.FornituraLuceCreateManyInput,
            Iterable<_i3.FornituraLuceCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyFornituraLuce',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.FornituraLuce?> update({
    required _i1.PrismaUnion<_i3.FornituraLuceUpdateInput,
            _i3.FornituraLuceUncheckedUpdateInput>
        data,
    required _i3.FornituraLuceWhereUniqueInput where,
    _i3.FornituraLuceSelect? select,
    _i3.FornituraLuceInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraLuce?>(
      action: 'updateOneFornituraLuce',
      result: result,
      factory: (e) => e != null ? _i2.FornituraLuce.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.FornituraLuceUpdateManyMutationInput,
            _i3.FornituraLuceUncheckedUpdateManyInput>
        data,
    _i3.FornituraLuceWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyFornituraLuce',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.FornituraLuce> upsert({
    required _i3.FornituraLuceWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.FornituraLuceCreateInput,
            _i3.FornituraLuceUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.FornituraLuceUpdateInput,
            _i3.FornituraLuceUncheckedUpdateInput>
        update,
    _i3.FornituraLuceSelect? select,
    _i3.FornituraLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraLuce>(
      action: 'upsertOneFornituraLuce',
      result: result,
      factory: (e) => _i2.FornituraLuce.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.FornituraLuce?> delete({
    required _i3.FornituraLuceWhereUniqueInput where,
    _i3.FornituraLuceSelect? select,
    _i3.FornituraLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraLuce?>(
      action: 'deleteOneFornituraLuce',
      result: result,
      factory: (e) => e != null ? _i2.FornituraLuce.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.FornituraLuceWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyFornituraLuce',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.FornituraLuceGroupByOutputType>> groupBy({
    _i3.FornituraLuceWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.FornituraLuceOrderByWithAggregationInput>,
            _i3.FornituraLuceOrderByWithAggregationInput>?
        orderBy,
    required _i1
        .PrismaUnion<Iterable<_i3.FornituraLuceScalar>, _i3.FornituraLuceScalar>
        by,
    _i3.FornituraLuceScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.FornituraLuceGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.FornituraLuceGroupByOutputType>>(
      action: 'groupByFornituraLuce',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.FornituraLuceGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateFornituraLuce> aggregate({
    _i3.FornituraLuceWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.FornituraLuceOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornituraLuceOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornituraLuceWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateFornituraLuceSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraLuce',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateFornituraLuce>(
      action: 'aggregateFornituraLuce',
      result: result,
      factory: (e) => _i3.AggregateFornituraLuce.fromJson(e),
    );
  }
}

class ConsumoAnnuoLuceDelegate {
  const ConsumoAnnuoLuceDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.ConsumoAnnuoLuce?> findUnique({
    required _i3.ConsumoAnnuoLuceWhereUniqueInput where,
    _i3.ConsumoAnnuoLuceSelect? select,
    _i3.ConsumoAnnuoLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoLuce?>(
      action: 'findUniqueConsumoAnnuoLuce',
      result: result,
      factory: (e) => e != null ? _i2.ConsumoAnnuoLuce.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoLuce> findUniqueOrThrow({
    required _i3.ConsumoAnnuoLuceWhereUniqueInput where,
    _i3.ConsumoAnnuoLuceSelect? select,
    _i3.ConsumoAnnuoLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoLuce>(
      action: 'findUniqueConsumoAnnuoLuceOrThrow',
      result: result,
      factory: (e) => _i2.ConsumoAnnuoLuce.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoLuce?> findFirst({
    _i3.ConsumoAnnuoLuceWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ConsumoAnnuoLuceOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ConsumoAnnuoLuceOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ConsumoAnnuoLuceWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ConsumoAnnuoLuceScalar,
            Iterable<_i3.ConsumoAnnuoLuceScalar>>?
        distinct,
    _i3.ConsumoAnnuoLuceSelect? select,
    _i3.ConsumoAnnuoLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoLuce?>(
      action: 'findFirstConsumoAnnuoLuce',
      result: result,
      factory: (e) => e != null ? _i2.ConsumoAnnuoLuce.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoLuce> findFirstOrThrow({
    _i3.ConsumoAnnuoLuceWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ConsumoAnnuoLuceOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ConsumoAnnuoLuceOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ConsumoAnnuoLuceWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ConsumoAnnuoLuceScalar,
            Iterable<_i3.ConsumoAnnuoLuceScalar>>?
        distinct,
    _i3.ConsumoAnnuoLuceSelect? select,
    _i3.ConsumoAnnuoLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoLuce>(
      action: 'findFirstConsumoAnnuoLuceOrThrow',
      result: result,
      factory: (e) => _i2.ConsumoAnnuoLuce.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.ConsumoAnnuoLuce>> findMany({
    _i3.ConsumoAnnuoLuceWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ConsumoAnnuoLuceOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ConsumoAnnuoLuceOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ConsumoAnnuoLuceWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ConsumoAnnuoLuceScalar,
            Iterable<_i3.ConsumoAnnuoLuceScalar>>?
        distinct,
    _i3.ConsumoAnnuoLuceSelect? select,
    _i3.ConsumoAnnuoLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.ConsumoAnnuoLuce>>(
      action: 'findManyConsumoAnnuoLuce',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.ConsumoAnnuoLuce.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoLuce> create({
    required _i1.PrismaUnion<_i3.ConsumoAnnuoLuceCreateInput,
            _i3.ConsumoAnnuoLuceUncheckedCreateInput>
        data,
    _i3.ConsumoAnnuoLuceSelect? select,
    _i3.ConsumoAnnuoLuceInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoLuce>(
      action: 'createOneConsumoAnnuoLuce',
      result: result,
      factory: (e) => _i2.ConsumoAnnuoLuce.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ConsumoAnnuoLuceCreateManyInput,
            Iterable<_i3.ConsumoAnnuoLuceCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyConsumoAnnuoLuce',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoLuce?> update({
    required _i1.PrismaUnion<_i3.ConsumoAnnuoLuceUpdateInput,
            _i3.ConsumoAnnuoLuceUncheckedUpdateInput>
        data,
    required _i3.ConsumoAnnuoLuceWhereUniqueInput where,
    _i3.ConsumoAnnuoLuceSelect? select,
    _i3.ConsumoAnnuoLuceInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoLuce?>(
      action: 'updateOneConsumoAnnuoLuce',
      result: result,
      factory: (e) => e != null ? _i2.ConsumoAnnuoLuce.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ConsumoAnnuoLuceUpdateManyMutationInput,
            _i3.ConsumoAnnuoLuceUncheckedUpdateManyInput>
        data,
    _i3.ConsumoAnnuoLuceWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyConsumoAnnuoLuce',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoLuce> upsert({
    required _i3.ConsumoAnnuoLuceWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ConsumoAnnuoLuceCreateInput,
            _i3.ConsumoAnnuoLuceUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ConsumoAnnuoLuceUpdateInput,
            _i3.ConsumoAnnuoLuceUncheckedUpdateInput>
        update,
    _i3.ConsumoAnnuoLuceSelect? select,
    _i3.ConsumoAnnuoLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoLuce>(
      action: 'upsertOneConsumoAnnuoLuce',
      result: result,
      factory: (e) => _i2.ConsumoAnnuoLuce.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoLuce?> delete({
    required _i3.ConsumoAnnuoLuceWhereUniqueInput where,
    _i3.ConsumoAnnuoLuceSelect? select,
    _i3.ConsumoAnnuoLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoLuce?>(
      action: 'deleteOneConsumoAnnuoLuce',
      result: result,
      factory: (e) => e != null ? _i2.ConsumoAnnuoLuce.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ConsumoAnnuoLuceWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyConsumoAnnuoLuce',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ConsumoAnnuoLuceGroupByOutputType>> groupBy({
    _i3.ConsumoAnnuoLuceWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ConsumoAnnuoLuceOrderByWithAggregationInput>,
            _i3.ConsumoAnnuoLuceOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ConsumoAnnuoLuceScalar>,
            _i3.ConsumoAnnuoLuceScalar>
        by,
    _i3.ConsumoAnnuoLuceScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ConsumoAnnuoLuceGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ConsumoAnnuoLuceGroupByOutputType>>(
      action: 'groupByConsumoAnnuoLuce',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ConsumoAnnuoLuceGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateConsumoAnnuoLuce> aggregate({
    _i3.ConsumoAnnuoLuceWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ConsumoAnnuoLuceOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ConsumoAnnuoLuceOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ConsumoAnnuoLuceWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateConsumoAnnuoLuceSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoLuce',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateConsumoAnnuoLuce>(
      action: 'aggregateConsumoAnnuoLuce',
      result: result,
      factory: (e) => _i3.AggregateConsumoAnnuoLuce.fromJson(e),
    );
  }
}

class FornituraGasDelegate {
  const FornituraGasDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.FornituraGas?> findUnique({
    required _i3.FornituraGasWhereUniqueInput where,
    _i3.FornituraGasSelect? select,
    _i3.FornituraGasInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraGas?>(
      action: 'findUniqueFornituraGas',
      result: result,
      factory: (e) => e != null ? _i2.FornituraGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.FornituraGas> findUniqueOrThrow({
    required _i3.FornituraGasWhereUniqueInput where,
    _i3.FornituraGasSelect? select,
    _i3.FornituraGasInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraGas>(
      action: 'findUniqueFornituraGasOrThrow',
      result: result,
      factory: (e) => _i2.FornituraGas.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.FornituraGas?> findFirst({
    _i3.FornituraGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.FornituraGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornituraGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornituraGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.FornituraGasScalar, Iterable<_i3.FornituraGasScalar>>?
        distinct,
    _i3.FornituraGasSelect? select,
    _i3.FornituraGasInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraGas?>(
      action: 'findFirstFornituraGas',
      result: result,
      factory: (e) => e != null ? _i2.FornituraGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.FornituraGas> findFirstOrThrow({
    _i3.FornituraGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.FornituraGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornituraGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornituraGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.FornituraGasScalar, Iterable<_i3.FornituraGasScalar>>?
        distinct,
    _i3.FornituraGasSelect? select,
    _i3.FornituraGasInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraGas>(
      action: 'findFirstFornituraGasOrThrow',
      result: result,
      factory: (e) => _i2.FornituraGas.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.FornituraGas>> findMany({
    _i3.FornituraGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.FornituraGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornituraGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornituraGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.FornituraGasScalar, Iterable<_i3.FornituraGasScalar>>?
        distinct,
    _i3.FornituraGasSelect? select,
    _i3.FornituraGasInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.FornituraGas>>(
      action: 'findManyFornituraGas',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.FornituraGas.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.FornituraGas> create({
    required _i1.PrismaUnion<_i3.FornituraGasCreateInput,
            _i3.FornituraGasUncheckedCreateInput>
        data,
    _i3.FornituraGasSelect? select,
    _i3.FornituraGasInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraGas>(
      action: 'createOneFornituraGas',
      result: result,
      factory: (e) => _i2.FornituraGas.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.FornituraGasCreateManyInput,
            Iterable<_i3.FornituraGasCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyFornituraGas',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.FornituraGas?> update({
    required _i1.PrismaUnion<_i3.FornituraGasUpdateInput,
            _i3.FornituraGasUncheckedUpdateInput>
        data,
    required _i3.FornituraGasWhereUniqueInput where,
    _i3.FornituraGasSelect? select,
    _i3.FornituraGasInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraGas?>(
      action: 'updateOneFornituraGas',
      result: result,
      factory: (e) => e != null ? _i2.FornituraGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.FornituraGasUpdateManyMutationInput,
            _i3.FornituraGasUncheckedUpdateManyInput>
        data,
    _i3.FornituraGasWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyFornituraGas',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.FornituraGas> upsert({
    required _i3.FornituraGasWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.FornituraGasCreateInput,
            _i3.FornituraGasUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.FornituraGasUpdateInput,
            _i3.FornituraGasUncheckedUpdateInput>
        update,
    _i3.FornituraGasSelect? select,
    _i3.FornituraGasInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraGas>(
      action: 'upsertOneFornituraGas',
      result: result,
      factory: (e) => _i2.FornituraGas.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.FornituraGas?> delete({
    required _i3.FornituraGasWhereUniqueInput where,
    _i3.FornituraGasSelect? select,
    _i3.FornituraGasInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.FornituraGas?>(
      action: 'deleteOneFornituraGas',
      result: result,
      factory: (e) => e != null ? _i2.FornituraGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.FornituraGasWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyFornituraGas',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.FornituraGasGroupByOutputType>> groupBy({
    _i3.FornituraGasWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.FornituraGasOrderByWithAggregationInput>,
            _i3.FornituraGasOrderByWithAggregationInput>?
        orderBy,
    required _i1
        .PrismaUnion<Iterable<_i3.FornituraGasScalar>, _i3.FornituraGasScalar>
        by,
    _i3.FornituraGasScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.FornituraGasGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.FornituraGasGroupByOutputType>>(
      action: 'groupByFornituraGas',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.FornituraGasGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateFornituraGas> aggregate({
    _i3.FornituraGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.FornituraGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornituraGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornituraGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateFornituraGasSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'FornituraGas',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateFornituraGas>(
      action: 'aggregateFornituraGas',
      result: result,
      factory: (e) => _i3.AggregateFornituraGas.fromJson(e),
    );
  }
}

class ConsumoAnnuoGasDelegate {
  const ConsumoAnnuoGasDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.ConsumoAnnuoGas?> findUnique({
    required _i3.ConsumoAnnuoGasWhereUniqueInput where,
    _i3.ConsumoAnnuoGasSelect? select,
    _i3.ConsumoAnnuoGasInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoGas?>(
      action: 'findUniqueConsumoAnnuoGas',
      result: result,
      factory: (e) => e != null ? _i2.ConsumoAnnuoGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoGas> findUniqueOrThrow({
    required _i3.ConsumoAnnuoGasWhereUniqueInput where,
    _i3.ConsumoAnnuoGasSelect? select,
    _i3.ConsumoAnnuoGasInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoGas>(
      action: 'findUniqueConsumoAnnuoGasOrThrow',
      result: result,
      factory: (e) => _i2.ConsumoAnnuoGas.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoGas?> findFirst({
    _i3.ConsumoAnnuoGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ConsumoAnnuoGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ConsumoAnnuoGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ConsumoAnnuoGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ConsumoAnnuoGasScalar,
            Iterable<_i3.ConsumoAnnuoGasScalar>>?
        distinct,
    _i3.ConsumoAnnuoGasSelect? select,
    _i3.ConsumoAnnuoGasInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoGas?>(
      action: 'findFirstConsumoAnnuoGas',
      result: result,
      factory: (e) => e != null ? _i2.ConsumoAnnuoGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoGas> findFirstOrThrow({
    _i3.ConsumoAnnuoGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ConsumoAnnuoGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ConsumoAnnuoGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ConsumoAnnuoGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ConsumoAnnuoGasScalar,
            Iterable<_i3.ConsumoAnnuoGasScalar>>?
        distinct,
    _i3.ConsumoAnnuoGasSelect? select,
    _i3.ConsumoAnnuoGasInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoGas>(
      action: 'findFirstConsumoAnnuoGasOrThrow',
      result: result,
      factory: (e) => _i2.ConsumoAnnuoGas.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.ConsumoAnnuoGas>> findMany({
    _i3.ConsumoAnnuoGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ConsumoAnnuoGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ConsumoAnnuoGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ConsumoAnnuoGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ConsumoAnnuoGasScalar,
            Iterable<_i3.ConsumoAnnuoGasScalar>>?
        distinct,
    _i3.ConsumoAnnuoGasSelect? select,
    _i3.ConsumoAnnuoGasInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.ConsumoAnnuoGas>>(
      action: 'findManyConsumoAnnuoGas',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.ConsumoAnnuoGas.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoGas> create({
    required _i1.PrismaUnion<_i3.ConsumoAnnuoGasCreateInput,
            _i3.ConsumoAnnuoGasUncheckedCreateInput>
        data,
    _i3.ConsumoAnnuoGasSelect? select,
    _i3.ConsumoAnnuoGasInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoGas>(
      action: 'createOneConsumoAnnuoGas',
      result: result,
      factory: (e) => _i2.ConsumoAnnuoGas.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ConsumoAnnuoGasCreateManyInput,
            Iterable<_i3.ConsumoAnnuoGasCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyConsumoAnnuoGas',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoGas?> update({
    required _i1.PrismaUnion<_i3.ConsumoAnnuoGasUpdateInput,
            _i3.ConsumoAnnuoGasUncheckedUpdateInput>
        data,
    required _i3.ConsumoAnnuoGasWhereUniqueInput where,
    _i3.ConsumoAnnuoGasSelect? select,
    _i3.ConsumoAnnuoGasInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoGas?>(
      action: 'updateOneConsumoAnnuoGas',
      result: result,
      factory: (e) => e != null ? _i2.ConsumoAnnuoGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ConsumoAnnuoGasUpdateManyMutationInput,
            _i3.ConsumoAnnuoGasUncheckedUpdateManyInput>
        data,
    _i3.ConsumoAnnuoGasWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyConsumoAnnuoGas',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoGas> upsert({
    required _i3.ConsumoAnnuoGasWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ConsumoAnnuoGasCreateInput,
            _i3.ConsumoAnnuoGasUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ConsumoAnnuoGasUpdateInput,
            _i3.ConsumoAnnuoGasUncheckedUpdateInput>
        update,
    _i3.ConsumoAnnuoGasSelect? select,
    _i3.ConsumoAnnuoGasInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoGas>(
      action: 'upsertOneConsumoAnnuoGas',
      result: result,
      factory: (e) => _i2.ConsumoAnnuoGas.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ConsumoAnnuoGas?> delete({
    required _i3.ConsumoAnnuoGasWhereUniqueInput where,
    _i3.ConsumoAnnuoGasSelect? select,
    _i3.ConsumoAnnuoGasInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ConsumoAnnuoGas?>(
      action: 'deleteOneConsumoAnnuoGas',
      result: result,
      factory: (e) => e != null ? _i2.ConsumoAnnuoGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ConsumoAnnuoGasWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyConsumoAnnuoGas',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ConsumoAnnuoGasGroupByOutputType>> groupBy({
    _i3.ConsumoAnnuoGasWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ConsumoAnnuoGasOrderByWithAggregationInput>,
            _i3.ConsumoAnnuoGasOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ConsumoAnnuoGasScalar>,
            _i3.ConsumoAnnuoGasScalar>
        by,
    _i3.ConsumoAnnuoGasScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ConsumoAnnuoGasGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ConsumoAnnuoGasGroupByOutputType>>(
      action: 'groupByConsumoAnnuoGas',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ConsumoAnnuoGasGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateConsumoAnnuoGas> aggregate({
    _i3.ConsumoAnnuoGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ConsumoAnnuoGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ConsumoAnnuoGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ConsumoAnnuoGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateConsumoAnnuoGasSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ConsumoAnnuoGas',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateConsumoAnnuoGas>(
      action: 'aggregateConsumoAnnuoGas',
      result: result,
      factory: (e) => _i3.AggregateConsumoAnnuoGas.fromJson(e),
    );
  }
}

class ContrattoDelegate {
  const ContrattoDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Contratto?> findUnique({
    required _i3.ContrattoWhereUniqueInput where,
    _i3.ContrattoSelect? select,
    _i3.ContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Contratto?>(
      action: 'findUniqueContratto',
      result: result,
      factory: (e) => e != null ? _i2.Contratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Contratto> findUniqueOrThrow({
    required _i3.ContrattoWhereUniqueInput where,
    _i3.ContrattoSelect? select,
    _i3.ContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Contratto>(
      action: 'findUniqueContrattoOrThrow',
      result: result,
      factory: (e) => _i2.Contratto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Contratto?> findFirst({
    _i3.ContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoScalar, Iterable<_i3.ContrattoScalar>>?
        distinct,
    _i3.ContrattoSelect? select,
    _i3.ContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Contratto?>(
      action: 'findFirstContratto',
      result: result,
      factory: (e) => e != null ? _i2.Contratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Contratto> findFirstOrThrow({
    _i3.ContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoScalar, Iterable<_i3.ContrattoScalar>>?
        distinct,
    _i3.ContrattoSelect? select,
    _i3.ContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Contratto>(
      action: 'findFirstContrattoOrThrow',
      result: result,
      factory: (e) => _i2.Contratto.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Contratto>> findMany({
    _i3.ContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoScalar, Iterable<_i3.ContrattoScalar>>?
        distinct,
    _i3.ContrattoSelect? select,
    _i3.ContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Contratto>>(
      action: 'findManyContratto',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Contratto.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Contratto> create({
    required _i1.PrismaUnion<_i3.ContrattoCreateInput,
            _i3.ContrattoUncheckedCreateInput>
        data,
    _i3.ContrattoSelect? select,
    _i3.ContrattoInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Contratto>(
      action: 'createOneContratto',
      result: result,
      factory: (e) => _i2.Contratto.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ContrattoCreateManyInput,
            Iterable<_i3.ContrattoCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyContratto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Contratto?> update({
    required _i1.PrismaUnion<_i3.ContrattoUpdateInput,
            _i3.ContrattoUncheckedUpdateInput>
        data,
    required _i3.ContrattoWhereUniqueInput where,
    _i3.ContrattoSelect? select,
    _i3.ContrattoInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Contratto?>(
      action: 'updateOneContratto',
      result: result,
      factory: (e) => e != null ? _i2.Contratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ContrattoUpdateManyMutationInput,
            _i3.ContrattoUncheckedUpdateManyInput>
        data,
    _i3.ContrattoWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyContratto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Contratto> upsert({
    required _i3.ContrattoWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ContrattoCreateInput,
            _i3.ContrattoUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ContrattoUpdateInput,
            _i3.ContrattoUncheckedUpdateInput>
        update,
    _i3.ContrattoSelect? select,
    _i3.ContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Contratto>(
      action: 'upsertOneContratto',
      result: result,
      factory: (e) => _i2.Contratto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Contratto?> delete({
    required _i3.ContrattoWhereUniqueInput where,
    _i3.ContrattoSelect? select,
    _i3.ContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Contratto?>(
      action: 'deleteOneContratto',
      result: result,
      factory: (e) => e != null ? _i2.Contratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ContrattoWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyContratto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ContrattoGroupByOutputType>> groupBy({
    _i3.ContrattoWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ContrattoOrderByWithAggregationInput>,
            _i3.ContrattoOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ContrattoScalar>, _i3.ContrattoScalar>
        by,
    _i3.ContrattoScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ContrattoGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ContrattoGroupByOutputType>>(
      action: 'groupByContratto',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ContrattoGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateContratto> aggregate({
    _i3.ContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateContrattoSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Contratto',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateContratto>(
      action: 'aggregateContratto',
      result: result,
      factory: (e) => _i3.AggregateContratto.fromJson(e),
    );
  }
}

class ModuloContrattoDelegate {
  const ModuloContrattoDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.ModuloContratto?> findUnique({
    required _i3.ModuloContrattoWhereUniqueInput where,
    _i3.ModuloContrattoSelect? select,
    _i3.ModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ModuloContratto?>(
      action: 'findUniqueModuloContratto',
      result: result,
      factory: (e) => e != null ? _i2.ModuloContratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ModuloContratto> findUniqueOrThrow({
    required _i3.ModuloContrattoWhereUniqueInput where,
    _i3.ModuloContrattoSelect? select,
    _i3.ModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ModuloContratto>(
      action: 'findUniqueModuloContrattoOrThrow',
      result: result,
      factory: (e) => _i2.ModuloContratto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ModuloContratto?> findFirst({
    _i3.ModuloContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ModuloContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ModuloContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ModuloContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ModuloContrattoScalar,
            Iterable<_i3.ModuloContrattoScalar>>?
        distinct,
    _i3.ModuloContrattoSelect? select,
    _i3.ModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ModuloContratto?>(
      action: 'findFirstModuloContratto',
      result: result,
      factory: (e) => e != null ? _i2.ModuloContratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ModuloContratto> findFirstOrThrow({
    _i3.ModuloContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ModuloContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ModuloContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ModuloContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ModuloContrattoScalar,
            Iterable<_i3.ModuloContrattoScalar>>?
        distinct,
    _i3.ModuloContrattoSelect? select,
    _i3.ModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ModuloContratto>(
      action: 'findFirstModuloContrattoOrThrow',
      result: result,
      factory: (e) => _i2.ModuloContratto.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.ModuloContratto>> findMany({
    _i3.ModuloContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ModuloContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ModuloContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ModuloContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ModuloContrattoScalar,
            Iterable<_i3.ModuloContrattoScalar>>?
        distinct,
    _i3.ModuloContrattoSelect? select,
    _i3.ModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.ModuloContratto>>(
      action: 'findManyModuloContratto',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.ModuloContratto.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ModuloContratto> create({
    required _i1.PrismaUnion<_i3.ModuloContrattoCreateInput,
            _i3.ModuloContrattoUncheckedCreateInput>
        data,
    _i3.ModuloContrattoSelect? select,
    _i3.ModuloContrattoInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ModuloContratto>(
      action: 'createOneModuloContratto',
      result: result,
      factory: (e) => _i2.ModuloContratto.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ModuloContrattoCreateManyInput,
            Iterable<_i3.ModuloContrattoCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyModuloContratto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ModuloContratto?> update({
    required _i1.PrismaUnion<_i3.ModuloContrattoUpdateInput,
            _i3.ModuloContrattoUncheckedUpdateInput>
        data,
    required _i3.ModuloContrattoWhereUniqueInput where,
    _i3.ModuloContrattoSelect? select,
    _i3.ModuloContrattoInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ModuloContratto?>(
      action: 'updateOneModuloContratto',
      result: result,
      factory: (e) => e != null ? _i2.ModuloContratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ModuloContrattoUpdateManyMutationInput,
            _i3.ModuloContrattoUncheckedUpdateManyInput>
        data,
    _i3.ModuloContrattoWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyModuloContratto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ModuloContratto> upsert({
    required _i3.ModuloContrattoWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ModuloContrattoCreateInput,
            _i3.ModuloContrattoUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ModuloContrattoUpdateInput,
            _i3.ModuloContrattoUncheckedUpdateInput>
        update,
    _i3.ModuloContrattoSelect? select,
    _i3.ModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ModuloContratto>(
      action: 'upsertOneModuloContratto',
      result: result,
      factory: (e) => _i2.ModuloContratto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ModuloContratto?> delete({
    required _i3.ModuloContrattoWhereUniqueInput where,
    _i3.ModuloContrattoSelect? select,
    _i3.ModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ModuloContratto?>(
      action: 'deleteOneModuloContratto',
      result: result,
      factory: (e) => e != null ? _i2.ModuloContratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ModuloContrattoWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyModuloContratto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ModuloContrattoGroupByOutputType>> groupBy({
    _i3.ModuloContrattoWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ModuloContrattoOrderByWithAggregationInput>,
            _i3.ModuloContrattoOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ModuloContrattoScalar>,
            _i3.ModuloContrattoScalar>
        by,
    _i3.ModuloContrattoScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ModuloContrattoGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ModuloContrattoGroupByOutputType>>(
      action: 'groupByModuloContratto',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ModuloContrattoGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateModuloContratto> aggregate({
    _i3.ModuloContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ModuloContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ModuloContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ModuloContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateModuloContrattoSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ModuloContratto',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateModuloContratto>(
      action: 'aggregateModuloContratto',
      result: result,
      factory: (e) => _i3.AggregateModuloContratto.fromJson(e),
    );
  }
}

class TipoModuloContrattoDelegate {
  const TipoModuloContrattoDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.TipoModuloContratto?> findUnique({
    required _i3.TipoModuloContrattoWhereUniqueInput where,
    _i3.TipoModuloContrattoSelect? select,
    _i3.TipoModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoModuloContratto?>(
      action: 'findUniqueTipoModuloContratto',
      result: result,
      factory: (e) => e != null ? _i2.TipoModuloContratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.TipoModuloContratto> findUniqueOrThrow({
    required _i3.TipoModuloContrattoWhereUniqueInput where,
    _i3.TipoModuloContrattoSelect? select,
    _i3.TipoModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoModuloContratto>(
      action: 'findUniqueTipoModuloContrattoOrThrow',
      result: result,
      factory: (e) => _i2.TipoModuloContratto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.TipoModuloContratto?> findFirst({
    _i3.TipoModuloContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .TipoModuloContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.TipoModuloContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.TipoModuloContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.TipoModuloContrattoScalar,
            Iterable<_i3.TipoModuloContrattoScalar>>?
        distinct,
    _i3.TipoModuloContrattoSelect? select,
    _i3.TipoModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoModuloContratto?>(
      action: 'findFirstTipoModuloContratto',
      result: result,
      factory: (e) => e != null ? _i2.TipoModuloContratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.TipoModuloContratto> findFirstOrThrow({
    _i3.TipoModuloContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .TipoModuloContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.TipoModuloContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.TipoModuloContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.TipoModuloContrattoScalar,
            Iterable<_i3.TipoModuloContrattoScalar>>?
        distinct,
    _i3.TipoModuloContrattoSelect? select,
    _i3.TipoModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoModuloContratto>(
      action: 'findFirstTipoModuloContrattoOrThrow',
      result: result,
      factory: (e) => _i2.TipoModuloContratto.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.TipoModuloContratto>> findMany({
    _i3.TipoModuloContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .TipoModuloContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.TipoModuloContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.TipoModuloContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.TipoModuloContrattoScalar,
            Iterable<_i3.TipoModuloContrattoScalar>>?
        distinct,
    _i3.TipoModuloContrattoSelect? select,
    _i3.TipoModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.TipoModuloContratto>>(
      action: 'findManyTipoModuloContratto',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.TipoModuloContratto.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.TipoModuloContratto> create({
    required _i1.PrismaUnion<_i3.TipoModuloContrattoCreateInput,
            _i3.TipoModuloContrattoUncheckedCreateInput>
        data,
    _i3.TipoModuloContrattoSelect? select,
    _i3.TipoModuloContrattoInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoModuloContratto>(
      action: 'createOneTipoModuloContratto',
      result: result,
      factory: (e) => _i2.TipoModuloContratto.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.TipoModuloContrattoCreateManyInput,
            Iterable<_i3.TipoModuloContrattoCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyTipoModuloContratto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.TipoModuloContratto?> update({
    required _i1.PrismaUnion<_i3.TipoModuloContrattoUpdateInput,
            _i3.TipoModuloContrattoUncheckedUpdateInput>
        data,
    required _i3.TipoModuloContrattoWhereUniqueInput where,
    _i3.TipoModuloContrattoSelect? select,
    _i3.TipoModuloContrattoInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoModuloContratto?>(
      action: 'updateOneTipoModuloContratto',
      result: result,
      factory: (e) => e != null ? _i2.TipoModuloContratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.TipoModuloContrattoUpdateManyMutationInput,
            _i3.TipoModuloContrattoUncheckedUpdateManyInput>
        data,
    _i3.TipoModuloContrattoWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyTipoModuloContratto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.TipoModuloContratto> upsert({
    required _i3.TipoModuloContrattoWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.TipoModuloContrattoCreateInput,
            _i3.TipoModuloContrattoUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.TipoModuloContrattoUpdateInput,
            _i3.TipoModuloContrattoUncheckedUpdateInput>
        update,
    _i3.TipoModuloContrattoSelect? select,
    _i3.TipoModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoModuloContratto>(
      action: 'upsertOneTipoModuloContratto',
      result: result,
      factory: (e) => _i2.TipoModuloContratto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.TipoModuloContratto?> delete({
    required _i3.TipoModuloContrattoWhereUniqueInput where,
    _i3.TipoModuloContrattoSelect? select,
    _i3.TipoModuloContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoModuloContratto?>(
      action: 'deleteOneTipoModuloContratto',
      result: result,
      factory: (e) => e != null ? _i2.TipoModuloContratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.TipoModuloContrattoWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyTipoModuloContratto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.TipoModuloContrattoGroupByOutputType>> groupBy({
    _i3.TipoModuloContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.TipoModuloContrattoOrderByWithAggregationInput>,
            _i3.TipoModuloContrattoOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.TipoModuloContrattoScalar>,
            _i3.TipoModuloContrattoScalar>
        by,
    _i3.TipoModuloContrattoScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.TipoModuloContrattoGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.TipoModuloContrattoGroupByOutputType>>(
      action: 'groupByTipoModuloContratto',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.TipoModuloContrattoGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateTipoModuloContratto> aggregate({
    _i3.TipoModuloContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .TipoModuloContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.TipoModuloContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.TipoModuloContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateTipoModuloContrattoSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoModuloContratto',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateTipoModuloContratto>(
      action: 'aggregateTipoModuloContratto',
      result: result,
      factory: (e) => _i3.AggregateTipoModuloContratto.fromJson(e),
    );
  }
}

class StatoContrattoDelegate {
  const StatoContrattoDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.StatoContratto?> findUnique({
    required _i3.StatoContrattoWhereUniqueInput where,
    _i3.StatoContrattoSelect? select,
    _i3.StatoContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoContratto?>(
      action: 'findUniqueStatoContratto',
      result: result,
      factory: (e) => e != null ? _i2.StatoContratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.StatoContratto> findUniqueOrThrow({
    required _i3.StatoContrattoWhereUniqueInput where,
    _i3.StatoContrattoSelect? select,
    _i3.StatoContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoContratto>(
      action: 'findUniqueStatoContrattoOrThrow',
      result: result,
      factory: (e) => _i2.StatoContratto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoContratto?> findFirst({
    _i3.StatoContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.StatoContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.StatoContrattoScalar,
            Iterable<_i3.StatoContrattoScalar>>?
        distinct,
    _i3.StatoContrattoSelect? select,
    _i3.StatoContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoContratto?>(
      action: 'findFirstStatoContratto',
      result: result,
      factory: (e) => e != null ? _i2.StatoContratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.StatoContratto> findFirstOrThrow({
    _i3.StatoContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.StatoContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.StatoContrattoScalar,
            Iterable<_i3.StatoContrattoScalar>>?
        distinct,
    _i3.StatoContrattoSelect? select,
    _i3.StatoContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoContratto>(
      action: 'findFirstStatoContrattoOrThrow',
      result: result,
      factory: (e) => _i2.StatoContratto.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.StatoContratto>> findMany({
    _i3.StatoContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.StatoContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.StatoContrattoScalar,
            Iterable<_i3.StatoContrattoScalar>>?
        distinct,
    _i3.StatoContrattoSelect? select,
    _i3.StatoContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.StatoContratto>>(
      action: 'findManyStatoContratto',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.StatoContratto.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.StatoContratto> create({
    required _i1.PrismaUnion<_i3.StatoContrattoCreateInput,
            _i3.StatoContrattoUncheckedCreateInput>
        data,
    _i3.StatoContrattoSelect? select,
    _i3.StatoContrattoInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoContratto>(
      action: 'createOneStatoContratto',
      result: result,
      factory: (e) => _i2.StatoContratto.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.StatoContrattoCreateManyInput,
            Iterable<_i3.StatoContrattoCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyStatoContratto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoContratto?> update({
    required _i1.PrismaUnion<_i3.StatoContrattoUpdateInput,
            _i3.StatoContrattoUncheckedUpdateInput>
        data,
    required _i3.StatoContrattoWhereUniqueInput where,
    _i3.StatoContrattoSelect? select,
    _i3.StatoContrattoInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoContratto?>(
      action: 'updateOneStatoContratto',
      result: result,
      factory: (e) => e != null ? _i2.StatoContratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.StatoContrattoUpdateManyMutationInput,
            _i3.StatoContrattoUncheckedUpdateManyInput>
        data,
    _i3.StatoContrattoWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyStatoContratto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoContratto> upsert({
    required _i3.StatoContrattoWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.StatoContrattoCreateInput,
            _i3.StatoContrattoUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.StatoContrattoUpdateInput,
            _i3.StatoContrattoUncheckedUpdateInput>
        update,
    _i3.StatoContrattoSelect? select,
    _i3.StatoContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoContratto>(
      action: 'upsertOneStatoContratto',
      result: result,
      factory: (e) => _i2.StatoContratto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoContratto?> delete({
    required _i3.StatoContrattoWhereUniqueInput where,
    _i3.StatoContrattoSelect? select,
    _i3.StatoContrattoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoContratto?>(
      action: 'deleteOneStatoContratto',
      result: result,
      factory: (e) => e != null ? _i2.StatoContratto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.StatoContrattoWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyStatoContratto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.StatoContrattoGroupByOutputType>> groupBy({
    _i3.StatoContrattoWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.StatoContrattoOrderByWithAggregationInput>,
            _i3.StatoContrattoOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.StatoContrattoScalar>,
            _i3.StatoContrattoScalar>
        by,
    _i3.StatoContrattoScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.StatoContrattoGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.StatoContrattoGroupByOutputType>>(
      action: 'groupByStatoContratto',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.StatoContrattoGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateStatoContratto> aggregate({
    _i3.StatoContrattoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.StatoContrattoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoContrattoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoContrattoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateStatoContrattoSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoContratto',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateStatoContratto>(
      action: 'aggregateStatoContratto',
      result: result,
      factory: (e) => _i3.AggregateStatoContratto.fromJson(e),
    );
  }
}

class OffertaDelegate {
  const OffertaDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Offerta?> findUnique({
    required _i3.OffertaWhereUniqueInput where,
    _i3.OffertaSelect? select,
    _i3.OffertaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Offerta?>(
      action: 'findUniqueOfferta',
      result: result,
      factory: (e) => e != null ? _i2.Offerta.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Offerta> findUniqueOrThrow({
    required _i3.OffertaWhereUniqueInput where,
    _i3.OffertaSelect? select,
    _i3.OffertaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Offerta>(
      action: 'findUniqueOffertaOrThrow',
      result: result,
      factory: (e) => _i2.Offerta.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Offerta?> findFirst({
    _i3.OffertaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.OffertaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.OffertaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.OffertaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OffertaScalar, Iterable<_i3.OffertaScalar>>? distinct,
    _i3.OffertaSelect? select,
    _i3.OffertaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Offerta?>(
      action: 'findFirstOfferta',
      result: result,
      factory: (e) => e != null ? _i2.Offerta.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Offerta> findFirstOrThrow({
    _i3.OffertaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.OffertaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.OffertaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.OffertaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OffertaScalar, Iterable<_i3.OffertaScalar>>? distinct,
    _i3.OffertaSelect? select,
    _i3.OffertaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Offerta>(
      action: 'findFirstOffertaOrThrow',
      result: result,
      factory: (e) => _i2.Offerta.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Offerta>> findMany({
    _i3.OffertaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.OffertaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.OffertaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.OffertaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OffertaScalar, Iterable<_i3.OffertaScalar>>? distinct,
    _i3.OffertaSelect? select,
    _i3.OffertaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Offerta>>(
      action: 'findManyOfferta',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Offerta.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Offerta> create({
    required _i1
        .PrismaUnion<_i3.OffertaCreateInput, _i3.OffertaUncheckedCreateInput>
        data,
    _i3.OffertaSelect? select,
    _i3.OffertaInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Offerta>(
      action: 'createOneOfferta',
      result: result,
      factory: (e) => _i2.Offerta.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.OffertaCreateManyInput,
            Iterable<_i3.OffertaCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyOfferta',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Offerta?> update({
    required _i1
        .PrismaUnion<_i3.OffertaUpdateInput, _i3.OffertaUncheckedUpdateInput>
        data,
    required _i3.OffertaWhereUniqueInput where,
    _i3.OffertaSelect? select,
    _i3.OffertaInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Offerta?>(
      action: 'updateOneOfferta',
      result: result,
      factory: (e) => e != null ? _i2.Offerta.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.OffertaUpdateManyMutationInput,
            _i3.OffertaUncheckedUpdateManyInput>
        data,
    _i3.OffertaWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyOfferta',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Offerta> upsert({
    required _i3.OffertaWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.OffertaCreateInput, _i3.OffertaUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.OffertaUpdateInput, _i3.OffertaUncheckedUpdateInput>
        update,
    _i3.OffertaSelect? select,
    _i3.OffertaInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Offerta>(
      action: 'upsertOneOfferta',
      result: result,
      factory: (e) => _i2.Offerta.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Offerta?> delete({
    required _i3.OffertaWhereUniqueInput where,
    _i3.OffertaSelect? select,
    _i3.OffertaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Offerta?>(
      action: 'deleteOneOfferta',
      result: result,
      factory: (e) => e != null ? _i2.Offerta.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.OffertaWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyOfferta',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.OffertaGroupByOutputType>> groupBy({
    _i3.OffertaWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.OffertaOrderByWithAggregationInput>,
            _i3.OffertaOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.OffertaScalar>, _i3.OffertaScalar> by,
    _i3.OffertaScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.OffertaGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.OffertaGroupByOutputType>>(
      action: 'groupByOfferta',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.OffertaGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateOfferta> aggregate({
    _i3.OffertaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.OffertaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.OffertaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.OffertaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateOffertaSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Offerta',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateOfferta>(
      action: 'aggregateOfferta',
      result: result,
      factory: (e) => _i3.AggregateOfferta.fromJson(e),
    );
  }
}

class PraticaDelegate {
  const PraticaDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Pratica?> findUnique({
    required _i3.PraticaWhereUniqueInput where,
    _i3.PraticaSelect? select,
    _i3.PraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Pratica?>(
      action: 'findUniquePratica',
      result: result,
      factory: (e) => e != null ? _i2.Pratica.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Pratica> findUniqueOrThrow({
    required _i3.PraticaWhereUniqueInput where,
    _i3.PraticaSelect? select,
    _i3.PraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Pratica>(
      action: 'findUniquePraticaOrThrow',
      result: result,
      factory: (e) => _i2.Pratica.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Pratica?> findFirst({
    _i3.PraticaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.PraticaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.PraticaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.PraticaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.PraticaScalar, Iterable<_i3.PraticaScalar>>? distinct,
    _i3.PraticaSelect? select,
    _i3.PraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Pratica?>(
      action: 'findFirstPratica',
      result: result,
      factory: (e) => e != null ? _i2.Pratica.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Pratica> findFirstOrThrow({
    _i3.PraticaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.PraticaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.PraticaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.PraticaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.PraticaScalar, Iterable<_i3.PraticaScalar>>? distinct,
    _i3.PraticaSelect? select,
    _i3.PraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Pratica>(
      action: 'findFirstPraticaOrThrow',
      result: result,
      factory: (e) => _i2.Pratica.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Pratica>> findMany({
    _i3.PraticaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.PraticaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.PraticaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.PraticaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.PraticaScalar, Iterable<_i3.PraticaScalar>>? distinct,
    _i3.PraticaSelect? select,
    _i3.PraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Pratica>>(
      action: 'findManyPratica',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Pratica.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Pratica> create({
    required _i1
        .PrismaUnion<_i3.PraticaCreateInput, _i3.PraticaUncheckedCreateInput>
        data,
    _i3.PraticaSelect? select,
    _i3.PraticaInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Pratica>(
      action: 'createOnePratica',
      result: result,
      factory: (e) => _i2.Pratica.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.PraticaCreateManyInput,
            Iterable<_i3.PraticaCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyPratica',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Pratica?> update({
    required _i1
        .PrismaUnion<_i3.PraticaUpdateInput, _i3.PraticaUncheckedUpdateInput>
        data,
    required _i3.PraticaWhereUniqueInput where,
    _i3.PraticaSelect? select,
    _i3.PraticaInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Pratica?>(
      action: 'updateOnePratica',
      result: result,
      factory: (e) => e != null ? _i2.Pratica.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.PraticaUpdateManyMutationInput,
            _i3.PraticaUncheckedUpdateManyInput>
        data,
    _i3.PraticaWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyPratica',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Pratica> upsert({
    required _i3.PraticaWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.PraticaCreateInput, _i3.PraticaUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.PraticaUpdateInput, _i3.PraticaUncheckedUpdateInput>
        update,
    _i3.PraticaSelect? select,
    _i3.PraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Pratica>(
      action: 'upsertOnePratica',
      result: result,
      factory: (e) => _i2.Pratica.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Pratica?> delete({
    required _i3.PraticaWhereUniqueInput where,
    _i3.PraticaSelect? select,
    _i3.PraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Pratica?>(
      action: 'deleteOnePratica',
      result: result,
      factory: (e) => e != null ? _i2.Pratica.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.PraticaWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyPratica',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.PraticaGroupByOutputType>> groupBy({
    _i3.PraticaWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.PraticaOrderByWithAggregationInput>,
            _i3.PraticaOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.PraticaScalar>, _i3.PraticaScalar> by,
    _i3.PraticaScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.PraticaGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.PraticaGroupByOutputType>>(
      action: 'groupByPratica',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.PraticaGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregatePratica> aggregate({
    _i3.PraticaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.PraticaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.PraticaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.PraticaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregatePraticaSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Pratica',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregatePratica>(
      action: 'aggregatePratica',
      result: result,
      factory: (e) => _i3.AggregatePratica.fromJson(e),
    );
  }
}

class TipoPraticaDelegate {
  const TipoPraticaDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.TipoPratica?> findUnique({
    required _i3.TipoPraticaWhereUniqueInput where,
    _i3.TipoPraticaSelect? select,
    _i3.TipoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoPratica?>(
      action: 'findUniqueTipoPratica',
      result: result,
      factory: (e) => e != null ? _i2.TipoPratica.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.TipoPratica> findUniqueOrThrow({
    required _i3.TipoPraticaWhereUniqueInput where,
    _i3.TipoPraticaSelect? select,
    _i3.TipoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoPratica>(
      action: 'findUniqueTipoPraticaOrThrow',
      result: result,
      factory: (e) => _i2.TipoPratica.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.TipoPratica?> findFirst({
    _i3.TipoPraticaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.TipoPraticaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.TipoPraticaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.TipoPraticaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.TipoPraticaScalar, Iterable<_i3.TipoPraticaScalar>>?
        distinct,
    _i3.TipoPraticaSelect? select,
    _i3.TipoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoPratica?>(
      action: 'findFirstTipoPratica',
      result: result,
      factory: (e) => e != null ? _i2.TipoPratica.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.TipoPratica> findFirstOrThrow({
    _i3.TipoPraticaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.TipoPraticaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.TipoPraticaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.TipoPraticaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.TipoPraticaScalar, Iterable<_i3.TipoPraticaScalar>>?
        distinct,
    _i3.TipoPraticaSelect? select,
    _i3.TipoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoPratica>(
      action: 'findFirstTipoPraticaOrThrow',
      result: result,
      factory: (e) => _i2.TipoPratica.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.TipoPratica>> findMany({
    _i3.TipoPraticaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.TipoPraticaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.TipoPraticaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.TipoPraticaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.TipoPraticaScalar, Iterable<_i3.TipoPraticaScalar>>?
        distinct,
    _i3.TipoPraticaSelect? select,
    _i3.TipoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.TipoPratica>>(
      action: 'findManyTipoPratica',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.TipoPratica.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.TipoPratica> create({
    required _i1.PrismaUnion<_i3.TipoPraticaCreateInput,
            _i3.TipoPraticaUncheckedCreateInput>
        data,
    _i3.TipoPraticaSelect? select,
    _i3.TipoPraticaInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoPratica>(
      action: 'createOneTipoPratica',
      result: result,
      factory: (e) => _i2.TipoPratica.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.TipoPraticaCreateManyInput,
            Iterable<_i3.TipoPraticaCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyTipoPratica',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.TipoPratica?> update({
    required _i1.PrismaUnion<_i3.TipoPraticaUpdateInput,
            _i3.TipoPraticaUncheckedUpdateInput>
        data,
    required _i3.TipoPraticaWhereUniqueInput where,
    _i3.TipoPraticaSelect? select,
    _i3.TipoPraticaInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoPratica?>(
      action: 'updateOneTipoPratica',
      result: result,
      factory: (e) => e != null ? _i2.TipoPratica.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.TipoPraticaUpdateManyMutationInput,
            _i3.TipoPraticaUncheckedUpdateManyInput>
        data,
    _i3.TipoPraticaWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyTipoPratica',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.TipoPratica> upsert({
    required _i3.TipoPraticaWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.TipoPraticaCreateInput,
            _i3.TipoPraticaUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.TipoPraticaUpdateInput,
            _i3.TipoPraticaUncheckedUpdateInput>
        update,
    _i3.TipoPraticaSelect? select,
    _i3.TipoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoPratica>(
      action: 'upsertOneTipoPratica',
      result: result,
      factory: (e) => _i2.TipoPratica.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.TipoPratica?> delete({
    required _i3.TipoPraticaWhereUniqueInput where,
    _i3.TipoPraticaSelect? select,
    _i3.TipoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoPratica?>(
      action: 'deleteOneTipoPratica',
      result: result,
      factory: (e) => e != null ? _i2.TipoPratica.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.TipoPraticaWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyTipoPratica',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.TipoPraticaGroupByOutputType>> groupBy({
    _i3.TipoPraticaWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.TipoPraticaOrderByWithAggregationInput>,
            _i3.TipoPraticaOrderByWithAggregationInput>?
        orderBy,
    required _i1
        .PrismaUnion<Iterable<_i3.TipoPraticaScalar>, _i3.TipoPraticaScalar>
        by,
    _i3.TipoPraticaScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.TipoPraticaGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.TipoPraticaGroupByOutputType>>(
      action: 'groupByTipoPratica',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.TipoPraticaGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateTipoPratica> aggregate({
    _i3.TipoPraticaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.TipoPraticaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.TipoPraticaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.TipoPraticaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateTipoPraticaSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoPratica',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateTipoPratica>(
      action: 'aggregateTipoPratica',
      result: result,
      factory: (e) => _i3.AggregateTipoPratica.fromJson(e),
    );
  }
}

class StatoPraticaDelegate {
  const StatoPraticaDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.StatoPratica?> findUnique({
    required _i3.StatoPraticaWhereUniqueInput where,
    _i3.StatoPraticaSelect? select,
    _i3.StatoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoPratica?>(
      action: 'findUniqueStatoPratica',
      result: result,
      factory: (e) => e != null ? _i2.StatoPratica.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.StatoPratica> findUniqueOrThrow({
    required _i3.StatoPraticaWhereUniqueInput where,
    _i3.StatoPraticaSelect? select,
    _i3.StatoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoPratica>(
      action: 'findUniqueStatoPraticaOrThrow',
      result: result,
      factory: (e) => _i2.StatoPratica.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoPratica?> findFirst({
    _i3.StatoPraticaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.StatoPraticaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoPraticaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoPraticaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.StatoPraticaScalar, Iterable<_i3.StatoPraticaScalar>>?
        distinct,
    _i3.StatoPraticaSelect? select,
    _i3.StatoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoPratica?>(
      action: 'findFirstStatoPratica',
      result: result,
      factory: (e) => e != null ? _i2.StatoPratica.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.StatoPratica> findFirstOrThrow({
    _i3.StatoPraticaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.StatoPraticaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoPraticaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoPraticaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.StatoPraticaScalar, Iterable<_i3.StatoPraticaScalar>>?
        distinct,
    _i3.StatoPraticaSelect? select,
    _i3.StatoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoPratica>(
      action: 'findFirstStatoPraticaOrThrow',
      result: result,
      factory: (e) => _i2.StatoPratica.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.StatoPratica>> findMany({
    _i3.StatoPraticaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.StatoPraticaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoPraticaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoPraticaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.StatoPraticaScalar, Iterable<_i3.StatoPraticaScalar>>?
        distinct,
    _i3.StatoPraticaSelect? select,
    _i3.StatoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.StatoPratica>>(
      action: 'findManyStatoPratica',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.StatoPratica.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.StatoPratica> create({
    required _i1.PrismaUnion<_i3.StatoPraticaCreateInput,
            _i3.StatoPraticaUncheckedCreateInput>
        data,
    _i3.StatoPraticaSelect? select,
    _i3.StatoPraticaInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoPratica>(
      action: 'createOneStatoPratica',
      result: result,
      factory: (e) => _i2.StatoPratica.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.StatoPraticaCreateManyInput,
            Iterable<_i3.StatoPraticaCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyStatoPratica',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoPratica?> update({
    required _i1.PrismaUnion<_i3.StatoPraticaUpdateInput,
            _i3.StatoPraticaUncheckedUpdateInput>
        data,
    required _i3.StatoPraticaWhereUniqueInput where,
    _i3.StatoPraticaSelect? select,
    _i3.StatoPraticaInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoPratica?>(
      action: 'updateOneStatoPratica',
      result: result,
      factory: (e) => e != null ? _i2.StatoPratica.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.StatoPraticaUpdateManyMutationInput,
            _i3.StatoPraticaUncheckedUpdateManyInput>
        data,
    _i3.StatoPraticaWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyStatoPratica',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoPratica> upsert({
    required _i3.StatoPraticaWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.StatoPraticaCreateInput,
            _i3.StatoPraticaUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.StatoPraticaUpdateInput,
            _i3.StatoPraticaUncheckedUpdateInput>
        update,
    _i3.StatoPraticaSelect? select,
    _i3.StatoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoPratica>(
      action: 'upsertOneStatoPratica',
      result: result,
      factory: (e) => _i2.StatoPratica.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoPratica?> delete({
    required _i3.StatoPraticaWhereUniqueInput where,
    _i3.StatoPraticaSelect? select,
    _i3.StatoPraticaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoPratica?>(
      action: 'deleteOneStatoPratica',
      result: result,
      factory: (e) => e != null ? _i2.StatoPratica.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.StatoPraticaWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyStatoPratica',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.StatoPraticaGroupByOutputType>> groupBy({
    _i3.StatoPraticaWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.StatoPraticaOrderByWithAggregationInput>,
            _i3.StatoPraticaOrderByWithAggregationInput>?
        orderBy,
    required _i1
        .PrismaUnion<Iterable<_i3.StatoPraticaScalar>, _i3.StatoPraticaScalar>
        by,
    _i3.StatoPraticaScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.StatoPraticaGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.StatoPraticaGroupByOutputType>>(
      action: 'groupByStatoPratica',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.StatoPraticaGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateStatoPratica> aggregate({
    _i3.StatoPraticaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.StatoPraticaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoPraticaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoPraticaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateStatoPraticaSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoPratica',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateStatoPratica>(
      action: 'aggregateStatoPratica',
      result: result,
      factory: (e) => _i3.AggregateStatoPratica.fromJson(e),
    );
  }
}

class ContrattoEnelLuceDelegate {
  const ContrattoEnelLuceDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.ContrattoEnelLuce?> findUnique({
    required _i3.ContrattoEnelLuceWhereUniqueInput where,
    _i3.ContrattoEnelLuceSelect? select,
    _i3.ContrattoEnelLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelLuce?>(
      action: 'findUniqueContrattoEnelLuce',
      result: result,
      factory: (e) => e != null ? _i2.ContrattoEnelLuce.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelLuce> findUniqueOrThrow({
    required _i3.ContrattoEnelLuceWhereUniqueInput where,
    _i3.ContrattoEnelLuceSelect? select,
    _i3.ContrattoEnelLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelLuce>(
      action: 'findUniqueContrattoEnelLuceOrThrow',
      result: result,
      factory: (e) => _i2.ContrattoEnelLuce.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelLuce?> findFirst({
    _i3.ContrattoEnelLuceWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ContrattoEnelLuceOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoEnelLuceOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelLuceWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoEnelLuceScalar,
            Iterable<_i3.ContrattoEnelLuceScalar>>?
        distinct,
    _i3.ContrattoEnelLuceSelect? select,
    _i3.ContrattoEnelLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelLuce?>(
      action: 'findFirstContrattoEnelLuce',
      result: result,
      factory: (e) => e != null ? _i2.ContrattoEnelLuce.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelLuce> findFirstOrThrow({
    _i3.ContrattoEnelLuceWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ContrattoEnelLuceOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoEnelLuceOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelLuceWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoEnelLuceScalar,
            Iterable<_i3.ContrattoEnelLuceScalar>>?
        distinct,
    _i3.ContrattoEnelLuceSelect? select,
    _i3.ContrattoEnelLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelLuce>(
      action: 'findFirstContrattoEnelLuceOrThrow',
      result: result,
      factory: (e) => _i2.ContrattoEnelLuce.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.ContrattoEnelLuce>> findMany({
    _i3.ContrattoEnelLuceWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ContrattoEnelLuceOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoEnelLuceOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelLuceWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoEnelLuceScalar,
            Iterable<_i3.ContrattoEnelLuceScalar>>?
        distinct,
    _i3.ContrattoEnelLuceSelect? select,
    _i3.ContrattoEnelLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.ContrattoEnelLuce>>(
      action: 'findManyContrattoEnelLuce',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.ContrattoEnelLuce.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelLuce> create({
    required _i1.PrismaUnion<_i3.ContrattoEnelLuceCreateInput,
            _i3.ContrattoEnelLuceUncheckedCreateInput>
        data,
    _i3.ContrattoEnelLuceSelect? select,
    _i3.ContrattoEnelLuceInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelLuce>(
      action: 'createOneContrattoEnelLuce',
      result: result,
      factory: (e) => _i2.ContrattoEnelLuce.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ContrattoEnelLuceCreateManyInput,
            Iterable<_i3.ContrattoEnelLuceCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyContrattoEnelLuce',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelLuce?> update({
    required _i1.PrismaUnion<_i3.ContrattoEnelLuceUpdateInput,
            _i3.ContrattoEnelLuceUncheckedUpdateInput>
        data,
    required _i3.ContrattoEnelLuceWhereUniqueInput where,
    _i3.ContrattoEnelLuceSelect? select,
    _i3.ContrattoEnelLuceInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelLuce?>(
      action: 'updateOneContrattoEnelLuce',
      result: result,
      factory: (e) => e != null ? _i2.ContrattoEnelLuce.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ContrattoEnelLuceUpdateManyMutationInput,
            _i3.ContrattoEnelLuceUncheckedUpdateManyInput>
        data,
    _i3.ContrattoEnelLuceWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyContrattoEnelLuce',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelLuce> upsert({
    required _i3.ContrattoEnelLuceWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ContrattoEnelLuceCreateInput,
            _i3.ContrattoEnelLuceUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ContrattoEnelLuceUpdateInput,
            _i3.ContrattoEnelLuceUncheckedUpdateInput>
        update,
    _i3.ContrattoEnelLuceSelect? select,
    _i3.ContrattoEnelLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelLuce>(
      action: 'upsertOneContrattoEnelLuce',
      result: result,
      factory: (e) => _i2.ContrattoEnelLuce.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelLuce?> delete({
    required _i3.ContrattoEnelLuceWhereUniqueInput where,
    _i3.ContrattoEnelLuceSelect? select,
    _i3.ContrattoEnelLuceInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelLuce?>(
      action: 'deleteOneContrattoEnelLuce',
      result: result,
      factory: (e) => e != null ? _i2.ContrattoEnelLuce.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ContrattoEnelLuceWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyContrattoEnelLuce',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ContrattoEnelLuceGroupByOutputType>> groupBy({
    _i3.ContrattoEnelLuceWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ContrattoEnelLuceOrderByWithAggregationInput>,
            _i3.ContrattoEnelLuceOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ContrattoEnelLuceScalar>,
            _i3.ContrattoEnelLuceScalar>
        by,
    _i3.ContrattoEnelLuceScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ContrattoEnelLuceGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ContrattoEnelLuceGroupByOutputType>>(
      action: 'groupByContrattoEnelLuce',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ContrattoEnelLuceGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateContrattoEnelLuce> aggregate({
    _i3.ContrattoEnelLuceWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ContrattoEnelLuceOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoEnelLuceOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelLuceWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateContrattoEnelLuceSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelLuce',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateContrattoEnelLuce>(
      action: 'aggregateContrattoEnelLuce',
      result: result,
      factory: (e) => _i3.AggregateContrattoEnelLuce.fromJson(e),
    );
  }
}

class ContrattoEnelGasDelegate {
  const ContrattoEnelGasDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.ContrattoEnelGas?> findUnique({
    required _i3.ContrattoEnelGasWhereUniqueInput where,
    _i3.ContrattoEnelGasSelect? select,
    _i3.ContrattoEnelGasInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelGas?>(
      action: 'findUniqueContrattoEnelGas',
      result: result,
      factory: (e) => e != null ? _i2.ContrattoEnelGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelGas> findUniqueOrThrow({
    required _i3.ContrattoEnelGasWhereUniqueInput where,
    _i3.ContrattoEnelGasSelect? select,
    _i3.ContrattoEnelGasInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelGas>(
      action: 'findUniqueContrattoEnelGasOrThrow',
      result: result,
      factory: (e) => _i2.ContrattoEnelGas.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelGas?> findFirst({
    _i3.ContrattoEnelGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ContrattoEnelGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoEnelGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoEnelGasScalar,
            Iterable<_i3.ContrattoEnelGasScalar>>?
        distinct,
    _i3.ContrattoEnelGasSelect? select,
    _i3.ContrattoEnelGasInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelGas?>(
      action: 'findFirstContrattoEnelGas',
      result: result,
      factory: (e) => e != null ? _i2.ContrattoEnelGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelGas> findFirstOrThrow({
    _i3.ContrattoEnelGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ContrattoEnelGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoEnelGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoEnelGasScalar,
            Iterable<_i3.ContrattoEnelGasScalar>>?
        distinct,
    _i3.ContrattoEnelGasSelect? select,
    _i3.ContrattoEnelGasInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelGas>(
      action: 'findFirstContrattoEnelGasOrThrow',
      result: result,
      factory: (e) => _i2.ContrattoEnelGas.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.ContrattoEnelGas>> findMany({
    _i3.ContrattoEnelGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ContrattoEnelGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoEnelGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoEnelGasScalar,
            Iterable<_i3.ContrattoEnelGasScalar>>?
        distinct,
    _i3.ContrattoEnelGasSelect? select,
    _i3.ContrattoEnelGasInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.ContrattoEnelGas>>(
      action: 'findManyContrattoEnelGas',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.ContrattoEnelGas.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelGas> create({
    required _i1.PrismaUnion<_i3.ContrattoEnelGasCreateInput,
            _i3.ContrattoEnelGasUncheckedCreateInput>
        data,
    _i3.ContrattoEnelGasSelect? select,
    _i3.ContrattoEnelGasInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelGas>(
      action: 'createOneContrattoEnelGas',
      result: result,
      factory: (e) => _i2.ContrattoEnelGas.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ContrattoEnelGasCreateManyInput,
            Iterable<_i3.ContrattoEnelGasCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyContrattoEnelGas',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelGas?> update({
    required _i1.PrismaUnion<_i3.ContrattoEnelGasUpdateInput,
            _i3.ContrattoEnelGasUncheckedUpdateInput>
        data,
    required _i3.ContrattoEnelGasWhereUniqueInput where,
    _i3.ContrattoEnelGasSelect? select,
    _i3.ContrattoEnelGasInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelGas?>(
      action: 'updateOneContrattoEnelGas',
      result: result,
      factory: (e) => e != null ? _i2.ContrattoEnelGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ContrattoEnelGasUpdateManyMutationInput,
            _i3.ContrattoEnelGasUncheckedUpdateManyInput>
        data,
    _i3.ContrattoEnelGasWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyContrattoEnelGas',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelGas> upsert({
    required _i3.ContrattoEnelGasWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ContrattoEnelGasCreateInput,
            _i3.ContrattoEnelGasUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ContrattoEnelGasUpdateInput,
            _i3.ContrattoEnelGasUncheckedUpdateInput>
        update,
    _i3.ContrattoEnelGasSelect? select,
    _i3.ContrattoEnelGasInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelGas>(
      action: 'upsertOneContrattoEnelGas',
      result: result,
      factory: (e) => _i2.ContrattoEnelGas.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelGas?> delete({
    required _i3.ContrattoEnelGasWhereUniqueInput where,
    _i3.ContrattoEnelGasSelect? select,
    _i3.ContrattoEnelGasInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelGas?>(
      action: 'deleteOneContrattoEnelGas',
      result: result,
      factory: (e) => e != null ? _i2.ContrattoEnelGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ContrattoEnelGasWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyContrattoEnelGas',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ContrattoEnelGasGroupByOutputType>> groupBy({
    _i3.ContrattoEnelGasWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ContrattoEnelGasOrderByWithAggregationInput>,
            _i3.ContrattoEnelGasOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ContrattoEnelGasScalar>,
            _i3.ContrattoEnelGasScalar>
        by,
    _i3.ContrattoEnelGasScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ContrattoEnelGasGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ContrattoEnelGasGroupByOutputType>>(
      action: 'groupByContrattoEnelGas',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ContrattoEnelGasGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateContrattoEnelGas> aggregate({
    _i3.ContrattoEnelGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ContrattoEnelGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoEnelGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateContrattoEnelGasSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelGas',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateContrattoEnelGas>(
      action: 'aggregateContrattoEnelGas',
      result: result,
      factory: (e) => _i3.AggregateContrattoEnelGas.fromJson(e),
    );
  }
}

class ContrattoEnelXAssicurazioneDelegate {
  const ContrattoEnelXAssicurazioneDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.ContrattoEnelXAssicurazione?> findUnique({
    required _i3.ContrattoEnelXAssicurazioneWhereUniqueInput where,
    _i3.ContrattoEnelXAssicurazioneSelect? select,
    _i3.ContrattoEnelXAssicurazioneInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelXAssicurazione?>(
      action: 'findUniqueContrattoEnelXAssicurazione',
      result: result,
      factory: (e) =>
          e != null ? _i2.ContrattoEnelXAssicurazione.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelXAssicurazione> findUniqueOrThrow({
    required _i3.ContrattoEnelXAssicurazioneWhereUniqueInput where,
    _i3.ContrattoEnelXAssicurazioneSelect? select,
    _i3.ContrattoEnelXAssicurazioneInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelXAssicurazione>(
      action: 'findUniqueContrattoEnelXAssicurazioneOrThrow',
      result: result,
      factory: (e) => _i2.ContrattoEnelXAssicurazione.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelXAssicurazione?> findFirst({
    _i3.ContrattoEnelXAssicurazioneWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ContrattoEnelXAssicurazioneOrderByWithRelationAndSearchRelevanceInput>,
            _i3
            .ContrattoEnelXAssicurazioneOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelXAssicurazioneWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoEnelXAssicurazioneScalar,
            Iterable<_i3.ContrattoEnelXAssicurazioneScalar>>?
        distinct,
    _i3.ContrattoEnelXAssicurazioneSelect? select,
    _i3.ContrattoEnelXAssicurazioneInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelXAssicurazione?>(
      action: 'findFirstContrattoEnelXAssicurazione',
      result: result,
      factory: (e) =>
          e != null ? _i2.ContrattoEnelXAssicurazione.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelXAssicurazione> findFirstOrThrow({
    _i3.ContrattoEnelXAssicurazioneWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ContrattoEnelXAssicurazioneOrderByWithRelationAndSearchRelevanceInput>,
            _i3
            .ContrattoEnelXAssicurazioneOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelXAssicurazioneWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoEnelXAssicurazioneScalar,
            Iterable<_i3.ContrattoEnelXAssicurazioneScalar>>?
        distinct,
    _i3.ContrattoEnelXAssicurazioneSelect? select,
    _i3.ContrattoEnelXAssicurazioneInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelXAssicurazione>(
      action: 'findFirstContrattoEnelXAssicurazioneOrThrow',
      result: result,
      factory: (e) => _i2.ContrattoEnelXAssicurazione.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.ContrattoEnelXAssicurazione>> findMany({
    _i3.ContrattoEnelXAssicurazioneWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ContrattoEnelXAssicurazioneOrderByWithRelationAndSearchRelevanceInput>,
            _i3
            .ContrattoEnelXAssicurazioneOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelXAssicurazioneWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoEnelXAssicurazioneScalar,
            Iterable<_i3.ContrattoEnelXAssicurazioneScalar>>?
        distinct,
    _i3.ContrattoEnelXAssicurazioneSelect? select,
    _i3.ContrattoEnelXAssicurazioneInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.ContrattoEnelXAssicurazione>>(
      action: 'findManyContrattoEnelXAssicurazione',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.ContrattoEnelXAssicurazione.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelXAssicurazione> create({
    required _i1.PrismaUnion<_i3.ContrattoEnelXAssicurazioneCreateInput,
            _i3.ContrattoEnelXAssicurazioneUncheckedCreateInput>
        data,
    _i3.ContrattoEnelXAssicurazioneSelect? select,
    _i3.ContrattoEnelXAssicurazioneInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelXAssicurazione>(
      action: 'createOneContrattoEnelXAssicurazione',
      result: result,
      factory: (e) => _i2.ContrattoEnelXAssicurazione.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ContrattoEnelXAssicurazioneCreateManyInput,
            Iterable<_i3.ContrattoEnelXAssicurazioneCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyContrattoEnelXAssicurazione',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelXAssicurazione?> update({
    required _i1.PrismaUnion<_i3.ContrattoEnelXAssicurazioneUpdateInput,
            _i3.ContrattoEnelXAssicurazioneUncheckedUpdateInput>
        data,
    required _i3.ContrattoEnelXAssicurazioneWhereUniqueInput where,
    _i3.ContrattoEnelXAssicurazioneSelect? select,
    _i3.ContrattoEnelXAssicurazioneInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelXAssicurazione?>(
      action: 'updateOneContrattoEnelXAssicurazione',
      result: result,
      factory: (e) =>
          e != null ? _i2.ContrattoEnelXAssicurazione.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<
            _i3.ContrattoEnelXAssicurazioneUpdateManyMutationInput,
            _i3.ContrattoEnelXAssicurazioneUncheckedUpdateManyInput>
        data,
    _i3.ContrattoEnelXAssicurazioneWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyContrattoEnelXAssicurazione',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelXAssicurazione> upsert({
    required _i3.ContrattoEnelXAssicurazioneWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ContrattoEnelXAssicurazioneCreateInput,
            _i3.ContrattoEnelXAssicurazioneUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ContrattoEnelXAssicurazioneUpdateInput,
            _i3.ContrattoEnelXAssicurazioneUncheckedUpdateInput>
        update,
    _i3.ContrattoEnelXAssicurazioneSelect? select,
    _i3.ContrattoEnelXAssicurazioneInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelXAssicurazione>(
      action: 'upsertOneContrattoEnelXAssicurazione',
      result: result,
      factory: (e) => _i2.ContrattoEnelXAssicurazione.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelXAssicurazione?> delete({
    required _i3.ContrattoEnelXAssicurazioneWhereUniqueInput where,
    _i3.ContrattoEnelXAssicurazioneSelect? select,
    _i3.ContrattoEnelXAssicurazioneInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelXAssicurazione?>(
      action: 'deleteOneContrattoEnelXAssicurazione',
      result: result,
      factory: (e) =>
          e != null ? _i2.ContrattoEnelXAssicurazione.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ContrattoEnelXAssicurazioneWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyContrattoEnelXAssicurazione',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ContrattoEnelXAssicurazioneGroupByOutputType>>
      groupBy({
    _i3.ContrattoEnelXAssicurazioneWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.ContrattoEnelXAssicurazioneOrderByWithAggregationInput>,
            _i3.ContrattoEnelXAssicurazioneOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ContrattoEnelXAssicurazioneScalar>,
            _i3.ContrattoEnelXAssicurazioneScalar>
        by,
    _i3.ContrattoEnelXAssicurazioneScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ContrattoEnelXAssicurazioneGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i3.ContrattoEnelXAssicurazioneGroupByOutputType>>(
      action: 'groupByContrattoEnelXAssicurazione',
      result: result,
      factory: (values) => (values as Iterable).map(
          (e) => _i3.ContrattoEnelXAssicurazioneGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateContrattoEnelXAssicurazione> aggregate({
    _i3.ContrattoEnelXAssicurazioneWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ContrattoEnelXAssicurazioneOrderByWithRelationAndSearchRelevanceInput>,
            _i3
            .ContrattoEnelXAssicurazioneOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelXAssicurazioneWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateContrattoEnelXAssicurazioneSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelXAssicurazione',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateContrattoEnelXAssicurazione>(
      action: 'aggregateContrattoEnelXAssicurazione',
      result: result,
      factory: (e) => _i3.AggregateContrattoEnelXAssicurazione.fromJson(e),
    );
  }
}

class ContrattoEnelFibraDelegate {
  const ContrattoEnelFibraDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.ContrattoEnelFibra?> findUnique({
    required _i3.ContrattoEnelFibraWhereUniqueInput where,
    _i3.ContrattoEnelFibraSelect? select,
    _i3.ContrattoEnelFibraInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelFibra?>(
      action: 'findUniqueContrattoEnelFibra',
      result: result,
      factory: (e) => e != null ? _i2.ContrattoEnelFibra.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelFibra> findUniqueOrThrow({
    required _i3.ContrattoEnelFibraWhereUniqueInput where,
    _i3.ContrattoEnelFibraSelect? select,
    _i3.ContrattoEnelFibraInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelFibra>(
      action: 'findUniqueContrattoEnelFibraOrThrow',
      result: result,
      factory: (e) => _i2.ContrattoEnelFibra.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelFibra?> findFirst({
    _i3.ContrattoEnelFibraWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ContrattoEnelFibraOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoEnelFibraOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelFibraWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoEnelFibraScalar,
            Iterable<_i3.ContrattoEnelFibraScalar>>?
        distinct,
    _i3.ContrattoEnelFibraSelect? select,
    _i3.ContrattoEnelFibraInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelFibra?>(
      action: 'findFirstContrattoEnelFibra',
      result: result,
      factory: (e) => e != null ? _i2.ContrattoEnelFibra.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelFibra> findFirstOrThrow({
    _i3.ContrattoEnelFibraWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ContrattoEnelFibraOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoEnelFibraOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelFibraWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoEnelFibraScalar,
            Iterable<_i3.ContrattoEnelFibraScalar>>?
        distinct,
    _i3.ContrattoEnelFibraSelect? select,
    _i3.ContrattoEnelFibraInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelFibra>(
      action: 'findFirstContrattoEnelFibraOrThrow',
      result: result,
      factory: (e) => _i2.ContrattoEnelFibra.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.ContrattoEnelFibra>> findMany({
    _i3.ContrattoEnelFibraWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ContrattoEnelFibraOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoEnelFibraOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelFibraWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ContrattoEnelFibraScalar,
            Iterable<_i3.ContrattoEnelFibraScalar>>?
        distinct,
    _i3.ContrattoEnelFibraSelect? select,
    _i3.ContrattoEnelFibraInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.ContrattoEnelFibra>>(
      action: 'findManyContrattoEnelFibra',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.ContrattoEnelFibra.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelFibra> create({
    required _i1.PrismaUnion<_i3.ContrattoEnelFibraCreateInput,
            _i3.ContrattoEnelFibraUncheckedCreateInput>
        data,
    _i3.ContrattoEnelFibraSelect? select,
    _i3.ContrattoEnelFibraInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelFibra>(
      action: 'createOneContrattoEnelFibra',
      result: result,
      factory: (e) => _i2.ContrattoEnelFibra.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ContrattoEnelFibraCreateManyInput,
            Iterable<_i3.ContrattoEnelFibraCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyContrattoEnelFibra',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelFibra?> update({
    required _i1.PrismaUnion<_i3.ContrattoEnelFibraUpdateInput,
            _i3.ContrattoEnelFibraUncheckedUpdateInput>
        data,
    required _i3.ContrattoEnelFibraWhereUniqueInput where,
    _i3.ContrattoEnelFibraSelect? select,
    _i3.ContrattoEnelFibraInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelFibra?>(
      action: 'updateOneContrattoEnelFibra',
      result: result,
      factory: (e) => e != null ? _i2.ContrattoEnelFibra.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ContrattoEnelFibraUpdateManyMutationInput,
            _i3.ContrattoEnelFibraUncheckedUpdateManyInput>
        data,
    _i3.ContrattoEnelFibraWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyContrattoEnelFibra',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelFibra> upsert({
    required _i3.ContrattoEnelFibraWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ContrattoEnelFibraCreateInput,
            _i3.ContrattoEnelFibraUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ContrattoEnelFibraUpdateInput,
            _i3.ContrattoEnelFibraUncheckedUpdateInput>
        update,
    _i3.ContrattoEnelFibraSelect? select,
    _i3.ContrattoEnelFibraInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelFibra>(
      action: 'upsertOneContrattoEnelFibra',
      result: result,
      factory: (e) => _i2.ContrattoEnelFibra.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ContrattoEnelFibra?> delete({
    required _i3.ContrattoEnelFibraWhereUniqueInput where,
    _i3.ContrattoEnelFibraSelect? select,
    _i3.ContrattoEnelFibraInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ContrattoEnelFibra?>(
      action: 'deleteOneContrattoEnelFibra',
      result: result,
      factory: (e) => e != null ? _i2.ContrattoEnelFibra.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ContrattoEnelFibraWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyContrattoEnelFibra',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ContrattoEnelFibraGroupByOutputType>> groupBy({
    _i3.ContrattoEnelFibraWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ContrattoEnelFibraOrderByWithAggregationInput>,
            _i3.ContrattoEnelFibraOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ContrattoEnelFibraScalar>,
            _i3.ContrattoEnelFibraScalar>
        by,
    _i3.ContrattoEnelFibraScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ContrattoEnelFibraGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ContrattoEnelFibraGroupByOutputType>>(
      action: 'groupByContrattoEnelFibra',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ContrattoEnelFibraGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateContrattoEnelFibra> aggregate({
    _i3.ContrattoEnelFibraWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ContrattoEnelFibraOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ContrattoEnelFibraOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ContrattoEnelFibraWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateContrattoEnelFibraSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ContrattoEnelFibra',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateContrattoEnelFibra>(
      action: 'aggregateContrattoEnelFibra',
      result: result,
      factory: (e) => _i3.AggregateContrattoEnelFibra.fromJson(e),
    );
  }
}

class ClasseMisuratoreGasDelegate {
  const ClasseMisuratoreGasDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.ClasseMisuratoreGas?> findUnique({
    required _i3.ClasseMisuratoreGasWhereUniqueInput where,
    _i3.ClasseMisuratoreGasSelect? select,
    _i3.ClasseMisuratoreGasInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ClasseMisuratoreGas?>(
      action: 'findUniqueClasseMisuratoreGas',
      result: result,
      factory: (e) => e != null ? _i2.ClasseMisuratoreGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ClasseMisuratoreGas> findUniqueOrThrow({
    required _i3.ClasseMisuratoreGasWhereUniqueInput where,
    _i3.ClasseMisuratoreGasSelect? select,
    _i3.ClasseMisuratoreGasInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ClasseMisuratoreGas>(
      action: 'findUniqueClasseMisuratoreGasOrThrow',
      result: result,
      factory: (e) => _i2.ClasseMisuratoreGas.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ClasseMisuratoreGas?> findFirst({
    _i3.ClasseMisuratoreGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ClasseMisuratoreGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ClasseMisuratoreGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ClasseMisuratoreGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ClasseMisuratoreGasScalar,
            Iterable<_i3.ClasseMisuratoreGasScalar>>?
        distinct,
    _i3.ClasseMisuratoreGasSelect? select,
    _i3.ClasseMisuratoreGasInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ClasseMisuratoreGas?>(
      action: 'findFirstClasseMisuratoreGas',
      result: result,
      factory: (e) => e != null ? _i2.ClasseMisuratoreGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ClasseMisuratoreGas> findFirstOrThrow({
    _i3.ClasseMisuratoreGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ClasseMisuratoreGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ClasseMisuratoreGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ClasseMisuratoreGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ClasseMisuratoreGasScalar,
            Iterable<_i3.ClasseMisuratoreGasScalar>>?
        distinct,
    _i3.ClasseMisuratoreGasSelect? select,
    _i3.ClasseMisuratoreGasInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ClasseMisuratoreGas>(
      action: 'findFirstClasseMisuratoreGasOrThrow',
      result: result,
      factory: (e) => _i2.ClasseMisuratoreGas.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.ClasseMisuratoreGas>> findMany({
    _i3.ClasseMisuratoreGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ClasseMisuratoreGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ClasseMisuratoreGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ClasseMisuratoreGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ClasseMisuratoreGasScalar,
            Iterable<_i3.ClasseMisuratoreGasScalar>>?
        distinct,
    _i3.ClasseMisuratoreGasSelect? select,
    _i3.ClasseMisuratoreGasInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.ClasseMisuratoreGas>>(
      action: 'findManyClasseMisuratoreGas',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.ClasseMisuratoreGas.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ClasseMisuratoreGas> create({
    required _i1.PrismaUnion<_i3.ClasseMisuratoreGasCreateInput,
            _i3.ClasseMisuratoreGasUncheckedCreateInput>
        data,
    _i3.ClasseMisuratoreGasSelect? select,
    _i3.ClasseMisuratoreGasInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ClasseMisuratoreGas>(
      action: 'createOneClasseMisuratoreGas',
      result: result,
      factory: (e) => _i2.ClasseMisuratoreGas.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ClasseMisuratoreGasCreateManyInput,
            Iterable<_i3.ClasseMisuratoreGasCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyClasseMisuratoreGas',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ClasseMisuratoreGas?> update({
    required _i1.PrismaUnion<_i3.ClasseMisuratoreGasUpdateInput,
            _i3.ClasseMisuratoreGasUncheckedUpdateInput>
        data,
    required _i3.ClasseMisuratoreGasWhereUniqueInput where,
    _i3.ClasseMisuratoreGasSelect? select,
    _i3.ClasseMisuratoreGasInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ClasseMisuratoreGas?>(
      action: 'updateOneClasseMisuratoreGas',
      result: result,
      factory: (e) => e != null ? _i2.ClasseMisuratoreGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ClasseMisuratoreGasUpdateManyMutationInput,
            _i3.ClasseMisuratoreGasUncheckedUpdateManyInput>
        data,
    _i3.ClasseMisuratoreGasWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyClasseMisuratoreGas',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ClasseMisuratoreGas> upsert({
    required _i3.ClasseMisuratoreGasWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ClasseMisuratoreGasCreateInput,
            _i3.ClasseMisuratoreGasUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ClasseMisuratoreGasUpdateInput,
            _i3.ClasseMisuratoreGasUncheckedUpdateInput>
        update,
    _i3.ClasseMisuratoreGasSelect? select,
    _i3.ClasseMisuratoreGasInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ClasseMisuratoreGas>(
      action: 'upsertOneClasseMisuratoreGas',
      result: result,
      factory: (e) => _i2.ClasseMisuratoreGas.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ClasseMisuratoreGas?> delete({
    required _i3.ClasseMisuratoreGasWhereUniqueInput where,
    _i3.ClasseMisuratoreGasSelect? select,
    _i3.ClasseMisuratoreGasInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ClasseMisuratoreGas?>(
      action: 'deleteOneClasseMisuratoreGas',
      result: result,
      factory: (e) => e != null ? _i2.ClasseMisuratoreGas.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ClasseMisuratoreGasWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyClasseMisuratoreGas',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ClasseMisuratoreGasGroupByOutputType>> groupBy({
    _i3.ClasseMisuratoreGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ClasseMisuratoreGasOrderByWithAggregationInput>,
            _i3.ClasseMisuratoreGasOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ClasseMisuratoreGasScalar>,
            _i3.ClasseMisuratoreGasScalar>
        by,
    _i3.ClasseMisuratoreGasScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ClasseMisuratoreGasGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ClasseMisuratoreGasGroupByOutputType>>(
      action: 'groupByClasseMisuratoreGas',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ClasseMisuratoreGasGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateClasseMisuratoreGas> aggregate({
    _i3.ClasseMisuratoreGasWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .ClasseMisuratoreGasOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ClasseMisuratoreGasOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ClasseMisuratoreGasWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateClasseMisuratoreGasSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ClasseMisuratoreGas',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateClasseMisuratoreGas>(
      action: 'aggregateClasseMisuratoreGas',
      result: result,
      factory: (e) => _i3.AggregateClasseMisuratoreGas.fromJson(e),
    );
  }
}

class FornitoreDelegate {
  const FornitoreDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Fornitore?> findUnique({
    required _i3.FornitoreWhereUniqueInput where,
    _i3.FornitoreSelect? select,
    _i3.FornitoreInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitore?>(
      action: 'findUniqueFornitore',
      result: result,
      factory: (e) => e != null ? _i2.Fornitore.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Fornitore> findUniqueOrThrow({
    required _i3.FornitoreWhereUniqueInput where,
    _i3.FornitoreSelect? select,
    _i3.FornitoreInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitore>(
      action: 'findUniqueFornitoreOrThrow',
      result: result,
      factory: (e) => _i2.Fornitore.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Fornitore?> findFirst({
    _i3.FornitoreWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.FornitoreOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornitoreOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornitoreWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.FornitoreScalar, Iterable<_i3.FornitoreScalar>>?
        distinct,
    _i3.FornitoreSelect? select,
    _i3.FornitoreInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitore?>(
      action: 'findFirstFornitore',
      result: result,
      factory: (e) => e != null ? _i2.Fornitore.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Fornitore> findFirstOrThrow({
    _i3.FornitoreWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.FornitoreOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornitoreOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornitoreWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.FornitoreScalar, Iterable<_i3.FornitoreScalar>>?
        distinct,
    _i3.FornitoreSelect? select,
    _i3.FornitoreInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitore>(
      action: 'findFirstFornitoreOrThrow',
      result: result,
      factory: (e) => _i2.Fornitore.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Fornitore>> findMany({
    _i3.FornitoreWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.FornitoreOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornitoreOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornitoreWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.FornitoreScalar, Iterable<_i3.FornitoreScalar>>?
        distinct,
    _i3.FornitoreSelect? select,
    _i3.FornitoreInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Fornitore>>(
      action: 'findManyFornitore',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Fornitore.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Fornitore> create({
    required _i1.PrismaUnion<_i3.FornitoreCreateInput,
            _i3.FornitoreUncheckedCreateInput>
        data,
    _i3.FornitoreSelect? select,
    _i3.FornitoreInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitore>(
      action: 'createOneFornitore',
      result: result,
      factory: (e) => _i2.Fornitore.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.FornitoreCreateManyInput,
            Iterable<_i3.FornitoreCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyFornitore',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Fornitore?> update({
    required _i1.PrismaUnion<_i3.FornitoreUpdateInput,
            _i3.FornitoreUncheckedUpdateInput>
        data,
    required _i3.FornitoreWhereUniqueInput where,
    _i3.FornitoreSelect? select,
    _i3.FornitoreInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitore?>(
      action: 'updateOneFornitore',
      result: result,
      factory: (e) => e != null ? _i2.Fornitore.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.FornitoreUpdateManyMutationInput,
            _i3.FornitoreUncheckedUpdateManyInput>
        data,
    _i3.FornitoreWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyFornitore',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Fornitore> upsert({
    required _i3.FornitoreWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.FornitoreCreateInput,
            _i3.FornitoreUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.FornitoreUpdateInput,
            _i3.FornitoreUncheckedUpdateInput>
        update,
    _i3.FornitoreSelect? select,
    _i3.FornitoreInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitore>(
      action: 'upsertOneFornitore',
      result: result,
      factory: (e) => _i2.Fornitore.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Fornitore?> delete({
    required _i3.FornitoreWhereUniqueInput where,
    _i3.FornitoreSelect? select,
    _i3.FornitoreInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Fornitore?>(
      action: 'deleteOneFornitore',
      result: result,
      factory: (e) => e != null ? _i2.Fornitore.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.FornitoreWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyFornitore',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.FornitoreGroupByOutputType>> groupBy({
    _i3.FornitoreWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.FornitoreOrderByWithAggregationInput>,
            _i3.FornitoreOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.FornitoreScalar>, _i3.FornitoreScalar>
        by,
    _i3.FornitoreScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.FornitoreGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.FornitoreGroupByOutputType>>(
      action: 'groupByFornitore',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.FornitoreGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateFornitore> aggregate({
    _i3.FornitoreWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.FornitoreOrderByWithRelationAndSearchRelevanceInput>,
            _i3.FornitoreOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.FornitoreWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateFornitoreSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Fornitore',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateFornitore>(
      action: 'aggregateFornitore',
      result: result,
      factory: (e) => _i3.AggregateFornitore.fromJson(e),
    );
  }
}

class OrdineDelegate {
  const OrdineDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Ordine?> findUnique({
    required _i3.OrdineWhereUniqueInput where,
    _i3.OrdineSelect? select,
    _i3.OrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ordine?>(
      action: 'findUniqueOrdine',
      result: result,
      factory: (e) => e != null ? _i2.Ordine.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Ordine> findUniqueOrThrow({
    required _i3.OrdineWhereUniqueInput where,
    _i3.OrdineSelect? select,
    _i3.OrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ordine>(
      action: 'findUniqueOrdineOrThrow',
      result: result,
      factory: (e) => _i2.Ordine.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Ordine?> findFirst({
    _i3.OrdineWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.OrdineOrderByWithRelationAndSearchRelevanceInput>,
            _i3.OrdineOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.OrdineWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OrdineScalar, Iterable<_i3.OrdineScalar>>? distinct,
    _i3.OrdineSelect? select,
    _i3.OrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ordine?>(
      action: 'findFirstOrdine',
      result: result,
      factory: (e) => e != null ? _i2.Ordine.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Ordine> findFirstOrThrow({
    _i3.OrdineWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.OrdineOrderByWithRelationAndSearchRelevanceInput>,
            _i3.OrdineOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.OrdineWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OrdineScalar, Iterable<_i3.OrdineScalar>>? distinct,
    _i3.OrdineSelect? select,
    _i3.OrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ordine>(
      action: 'findFirstOrdineOrThrow',
      result: result,
      factory: (e) => _i2.Ordine.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Ordine>> findMany({
    _i3.OrdineWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.OrdineOrderByWithRelationAndSearchRelevanceInput>,
            _i3.OrdineOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.OrdineWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OrdineScalar, Iterable<_i3.OrdineScalar>>? distinct,
    _i3.OrdineSelect? select,
    _i3.OrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Ordine>>(
      action: 'findManyOrdine',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Ordine.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Ordine> create({
    required _i1
        .PrismaUnion<_i3.OrdineCreateInput, _i3.OrdineUncheckedCreateInput>
        data,
    _i3.OrdineSelect? select,
    _i3.OrdineInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ordine>(
      action: 'createOneOrdine',
      result: result,
      factory: (e) => _i2.Ordine.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.OrdineCreateManyInput,
            Iterable<_i3.OrdineCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyOrdine',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Ordine?> update({
    required _i1
        .PrismaUnion<_i3.OrdineUpdateInput, _i3.OrdineUncheckedUpdateInput>
        data,
    required _i3.OrdineWhereUniqueInput where,
    _i3.OrdineSelect? select,
    _i3.OrdineInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ordine?>(
      action: 'updateOneOrdine',
      result: result,
      factory: (e) => e != null ? _i2.Ordine.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.OrdineUpdateManyMutationInput,
            _i3.OrdineUncheckedUpdateManyInput>
        data,
    _i3.OrdineWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyOrdine',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Ordine> upsert({
    required _i3.OrdineWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.OrdineCreateInput, _i3.OrdineUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.OrdineUpdateInput, _i3.OrdineUncheckedUpdateInput>
        update,
    _i3.OrdineSelect? select,
    _i3.OrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ordine>(
      action: 'upsertOneOrdine',
      result: result,
      factory: (e) => _i2.Ordine.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Ordine?> delete({
    required _i3.OrdineWhereUniqueInput where,
    _i3.OrdineSelect? select,
    _i3.OrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ordine?>(
      action: 'deleteOneOrdine',
      result: result,
      factory: (e) => e != null ? _i2.Ordine.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.OrdineWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyOrdine',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.OrdineGroupByOutputType>> groupBy({
    _i3.OrdineWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.OrdineOrderByWithAggregationInput>,
            _i3.OrdineOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.OrdineScalar>, _i3.OrdineScalar> by,
    _i3.OrdineScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.OrdineGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.OrdineGroupByOutputType>>(
      action: 'groupByOrdine',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.OrdineGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateOrdine> aggregate({
    _i3.OrdineWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.OrdineOrderByWithRelationAndSearchRelevanceInput>,
            _i3.OrdineOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.OrdineWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateOrdineSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ordine',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateOrdine>(
      action: 'aggregateOrdine',
      result: result,
      factory: (e) => _i3.AggregateOrdine.fromJson(e),
    );
  }
}

class StatoOrdineDelegate {
  const StatoOrdineDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.StatoOrdine?> findUnique({
    required _i3.StatoOrdineWhereUniqueInput where,
    _i3.StatoOrdineSelect? select,
    _i3.StatoOrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOrdine?>(
      action: 'findUniqueStatoOrdine',
      result: result,
      factory: (e) => e != null ? _i2.StatoOrdine.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.StatoOrdine> findUniqueOrThrow({
    required _i3.StatoOrdineWhereUniqueInput where,
    _i3.StatoOrdineSelect? select,
    _i3.StatoOrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOrdine>(
      action: 'findUniqueStatoOrdineOrThrow',
      result: result,
      factory: (e) => _i2.StatoOrdine.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoOrdine?> findFirst({
    _i3.StatoOrdineWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.StatoOrdineOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoOrdineOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoOrdineWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.StatoOrdineScalar, Iterable<_i3.StatoOrdineScalar>>?
        distinct,
    _i3.StatoOrdineSelect? select,
    _i3.StatoOrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOrdine?>(
      action: 'findFirstStatoOrdine',
      result: result,
      factory: (e) => e != null ? _i2.StatoOrdine.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.StatoOrdine> findFirstOrThrow({
    _i3.StatoOrdineWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.StatoOrdineOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoOrdineOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoOrdineWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.StatoOrdineScalar, Iterable<_i3.StatoOrdineScalar>>?
        distinct,
    _i3.StatoOrdineSelect? select,
    _i3.StatoOrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOrdine>(
      action: 'findFirstStatoOrdineOrThrow',
      result: result,
      factory: (e) => _i2.StatoOrdine.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.StatoOrdine>> findMany({
    _i3.StatoOrdineWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.StatoOrdineOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoOrdineOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoOrdineWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.StatoOrdineScalar, Iterable<_i3.StatoOrdineScalar>>?
        distinct,
    _i3.StatoOrdineSelect? select,
    _i3.StatoOrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.StatoOrdine>>(
      action: 'findManyStatoOrdine',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.StatoOrdine.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.StatoOrdine> create({
    required _i1.PrismaUnion<_i3.StatoOrdineCreateInput,
            _i3.StatoOrdineUncheckedCreateInput>
        data,
    _i3.StatoOrdineSelect? select,
    _i3.StatoOrdineInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOrdine>(
      action: 'createOneStatoOrdine',
      result: result,
      factory: (e) => _i2.StatoOrdine.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.StatoOrdineCreateManyInput,
            Iterable<_i3.StatoOrdineCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyStatoOrdine',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoOrdine?> update({
    required _i1.PrismaUnion<_i3.StatoOrdineUpdateInput,
            _i3.StatoOrdineUncheckedUpdateInput>
        data,
    required _i3.StatoOrdineWhereUniqueInput where,
    _i3.StatoOrdineSelect? select,
    _i3.StatoOrdineInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOrdine?>(
      action: 'updateOneStatoOrdine',
      result: result,
      factory: (e) => e != null ? _i2.StatoOrdine.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.StatoOrdineUpdateManyMutationInput,
            _i3.StatoOrdineUncheckedUpdateManyInput>
        data,
    _i3.StatoOrdineWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyStatoOrdine',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoOrdine> upsert({
    required _i3.StatoOrdineWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.StatoOrdineCreateInput,
            _i3.StatoOrdineUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.StatoOrdineUpdateInput,
            _i3.StatoOrdineUncheckedUpdateInput>
        update,
    _i3.StatoOrdineSelect? select,
    _i3.StatoOrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOrdine>(
      action: 'upsertOneStatoOrdine',
      result: result,
      factory: (e) => _i2.StatoOrdine.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoOrdine?> delete({
    required _i3.StatoOrdineWhereUniqueInput where,
    _i3.StatoOrdineSelect? select,
    _i3.StatoOrdineInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOrdine?>(
      action: 'deleteOneStatoOrdine',
      result: result,
      factory: (e) => e != null ? _i2.StatoOrdine.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.StatoOrdineWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyStatoOrdine',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.StatoOrdineGroupByOutputType>> groupBy({
    _i3.StatoOrdineWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.StatoOrdineOrderByWithAggregationInput>,
            _i3.StatoOrdineOrderByWithAggregationInput>?
        orderBy,
    required _i1
        .PrismaUnion<Iterable<_i3.StatoOrdineScalar>, _i3.StatoOrdineScalar>
        by,
    _i3.StatoOrdineScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.StatoOrdineGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.StatoOrdineGroupByOutputType>>(
      action: 'groupByStatoOrdine',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.StatoOrdineGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateStatoOrdine> aggregate({
    _i3.StatoOrdineWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.StatoOrdineOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoOrdineOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoOrdineWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateStatoOrdineSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOrdine',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateStatoOrdine>(
      action: 'aggregateStatoOrdine',
      result: result,
      factory: (e) => _i3.AggregateStatoOrdine.fromJson(e),
    );
  }
}

class ProdottoDelegate {
  const ProdottoDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Prodotto?> findUnique({
    required _i3.ProdottoWhereUniqueInput where,
    _i3.ProdottoSelect? select,
    _i3.ProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Prodotto?>(
      action: 'findUniqueProdotto',
      result: result,
      factory: (e) => e != null ? _i2.Prodotto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Prodotto> findUniqueOrThrow({
    required _i3.ProdottoWhereUniqueInput where,
    _i3.ProdottoSelect? select,
    _i3.ProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Prodotto>(
      action: 'findUniqueProdottoOrThrow',
      result: result,
      factory: (e) => _i2.Prodotto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Prodotto?> findFirst({
    _i3.ProdottoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ProdottoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ProdottoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ProdottoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProdottoScalar, Iterable<_i3.ProdottoScalar>>? distinct,
    _i3.ProdottoSelect? select,
    _i3.ProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Prodotto?>(
      action: 'findFirstProdotto',
      result: result,
      factory: (e) => e != null ? _i2.Prodotto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Prodotto> findFirstOrThrow({
    _i3.ProdottoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ProdottoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ProdottoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ProdottoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProdottoScalar, Iterable<_i3.ProdottoScalar>>? distinct,
    _i3.ProdottoSelect? select,
    _i3.ProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Prodotto>(
      action: 'findFirstProdottoOrThrow',
      result: result,
      factory: (e) => _i2.Prodotto.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Prodotto>> findMany({
    _i3.ProdottoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ProdottoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ProdottoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ProdottoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProdottoScalar, Iterable<_i3.ProdottoScalar>>? distinct,
    _i3.ProdottoSelect? select,
    _i3.ProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Prodotto>>(
      action: 'findManyProdotto',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Prodotto.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Prodotto> create({
    required _i1
        .PrismaUnion<_i3.ProdottoCreateInput, _i3.ProdottoUncheckedCreateInput>
        data,
    _i3.ProdottoSelect? select,
    _i3.ProdottoInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Prodotto>(
      action: 'createOneProdotto',
      result: result,
      factory: (e) => _i2.Prodotto.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ProdottoCreateManyInput,
            Iterable<_i3.ProdottoCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyProdotto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Prodotto?> update({
    required _i1
        .PrismaUnion<_i3.ProdottoUpdateInput, _i3.ProdottoUncheckedUpdateInput>
        data,
    required _i3.ProdottoWhereUniqueInput where,
    _i3.ProdottoSelect? select,
    _i3.ProdottoInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Prodotto?>(
      action: 'updateOneProdotto',
      result: result,
      factory: (e) => e != null ? _i2.Prodotto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ProdottoUpdateManyMutationInput,
            _i3.ProdottoUncheckedUpdateManyInput>
        data,
    _i3.ProdottoWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyProdotto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Prodotto> upsert({
    required _i3.ProdottoWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.ProdottoCreateInput, _i3.ProdottoUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.ProdottoUpdateInput, _i3.ProdottoUncheckedUpdateInput>
        update,
    _i3.ProdottoSelect? select,
    _i3.ProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Prodotto>(
      action: 'upsertOneProdotto',
      result: result,
      factory: (e) => _i2.Prodotto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Prodotto?> delete({
    required _i3.ProdottoWhereUniqueInput where,
    _i3.ProdottoSelect? select,
    _i3.ProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Prodotto?>(
      action: 'deleteOneProdotto',
      result: result,
      factory: (e) => e != null ? _i2.Prodotto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ProdottoWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyProdotto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ProdottoGroupByOutputType>> groupBy({
    _i3.ProdottoWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProdottoOrderByWithAggregationInput>,
            _i3.ProdottoOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ProdottoScalar>, _i3.ProdottoScalar>
        by,
    _i3.ProdottoScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ProdottoGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ProdottoGroupByOutputType>>(
      action: 'groupByProdotto',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ProdottoGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateProdotto> aggregate({
    _i3.ProdottoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ProdottoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ProdottoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ProdottoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateProdottoSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Prodotto',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateProdotto>(
      action: 'aggregateProdotto',
      result: result,
      factory: (e) => _i3.AggregateProdotto.fromJson(e),
    );
  }
}

class TipoProdottoDelegate {
  const TipoProdottoDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.TipoProdotto?> findUnique({
    required _i3.TipoProdottoWhereUniqueInput where,
    _i3.TipoProdottoSelect? select,
    _i3.TipoProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoProdotto?>(
      action: 'findUniqueTipoProdotto',
      result: result,
      factory: (e) => e != null ? _i2.TipoProdotto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.TipoProdotto> findUniqueOrThrow({
    required _i3.TipoProdottoWhereUniqueInput where,
    _i3.TipoProdottoSelect? select,
    _i3.TipoProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoProdotto>(
      action: 'findUniqueTipoProdottoOrThrow',
      result: result,
      factory: (e) => _i2.TipoProdotto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.TipoProdotto?> findFirst({
    _i3.TipoProdottoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.TipoProdottoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.TipoProdottoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.TipoProdottoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.TipoProdottoScalar, Iterable<_i3.TipoProdottoScalar>>?
        distinct,
    _i3.TipoProdottoSelect? select,
    _i3.TipoProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoProdotto?>(
      action: 'findFirstTipoProdotto',
      result: result,
      factory: (e) => e != null ? _i2.TipoProdotto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.TipoProdotto> findFirstOrThrow({
    _i3.TipoProdottoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.TipoProdottoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.TipoProdottoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.TipoProdottoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.TipoProdottoScalar, Iterable<_i3.TipoProdottoScalar>>?
        distinct,
    _i3.TipoProdottoSelect? select,
    _i3.TipoProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoProdotto>(
      action: 'findFirstTipoProdottoOrThrow',
      result: result,
      factory: (e) => _i2.TipoProdotto.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.TipoProdotto>> findMany({
    _i3.TipoProdottoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.TipoProdottoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.TipoProdottoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.TipoProdottoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.TipoProdottoScalar, Iterable<_i3.TipoProdottoScalar>>?
        distinct,
    _i3.TipoProdottoSelect? select,
    _i3.TipoProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.TipoProdotto>>(
      action: 'findManyTipoProdotto',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.TipoProdotto.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.TipoProdotto> create({
    required _i1.PrismaUnion<_i3.TipoProdottoCreateInput,
            _i3.TipoProdottoUncheckedCreateInput>
        data,
    _i3.TipoProdottoSelect? select,
    _i3.TipoProdottoInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoProdotto>(
      action: 'createOneTipoProdotto',
      result: result,
      factory: (e) => _i2.TipoProdotto.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.TipoProdottoCreateManyInput,
            Iterable<_i3.TipoProdottoCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyTipoProdotto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.TipoProdotto?> update({
    required _i1.PrismaUnion<_i3.TipoProdottoUpdateInput,
            _i3.TipoProdottoUncheckedUpdateInput>
        data,
    required _i3.TipoProdottoWhereUniqueInput where,
    _i3.TipoProdottoSelect? select,
    _i3.TipoProdottoInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoProdotto?>(
      action: 'updateOneTipoProdotto',
      result: result,
      factory: (e) => e != null ? _i2.TipoProdotto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.TipoProdottoUpdateManyMutationInput,
            _i3.TipoProdottoUncheckedUpdateManyInput>
        data,
    _i3.TipoProdottoWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyTipoProdotto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.TipoProdotto> upsert({
    required _i3.TipoProdottoWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.TipoProdottoCreateInput,
            _i3.TipoProdottoUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.TipoProdottoUpdateInput,
            _i3.TipoProdottoUncheckedUpdateInput>
        update,
    _i3.TipoProdottoSelect? select,
    _i3.TipoProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoProdotto>(
      action: 'upsertOneTipoProdotto',
      result: result,
      factory: (e) => _i2.TipoProdotto.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.TipoProdotto?> delete({
    required _i3.TipoProdottoWhereUniqueInput where,
    _i3.TipoProdottoSelect? select,
    _i3.TipoProdottoInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.TipoProdotto?>(
      action: 'deleteOneTipoProdotto',
      result: result,
      factory: (e) => e != null ? _i2.TipoProdotto.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.TipoProdottoWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyTipoProdotto',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.TipoProdottoGroupByOutputType>> groupBy({
    _i3.TipoProdottoWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.TipoProdottoOrderByWithAggregationInput>,
            _i3.TipoProdottoOrderByWithAggregationInput>?
        orderBy,
    required _i1
        .PrismaUnion<Iterable<_i3.TipoProdottoScalar>, _i3.TipoProdottoScalar>
        by,
    _i3.TipoProdottoScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.TipoProdottoGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.TipoProdottoGroupByOutputType>>(
      action: 'groupByTipoProdotto',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.TipoProdottoGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateTipoProdotto> aggregate({
    _i3.TipoProdottoWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.TipoProdottoOrderByWithRelationAndSearchRelevanceInput>,
            _i3.TipoProdottoOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.TipoProdottoWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateTipoProdottoSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'TipoProdotto',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateTipoProdotto>(
      action: 'aggregateTipoProdotto',
      result: result,
      factory: (e) => _i3.AggregateTipoProdotto.fromJson(e),
    );
  }
}

class ProduttoreDelegate {
  const ProduttoreDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Produttore?> findUnique({
    required _i3.ProduttoreWhereUniqueInput where,
    _i3.ProduttoreSelect? select,
    _i3.ProduttoreInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Produttore?>(
      action: 'findUniqueProduttore',
      result: result,
      factory: (e) => e != null ? _i2.Produttore.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Produttore> findUniqueOrThrow({
    required _i3.ProduttoreWhereUniqueInput where,
    _i3.ProduttoreSelect? select,
    _i3.ProduttoreInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Produttore>(
      action: 'findUniqueProduttoreOrThrow',
      result: result,
      factory: (e) => _i2.Produttore.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Produttore?> findFirst({
    _i3.ProduttoreWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ProduttoreOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ProduttoreOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ProduttoreWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProduttoreScalar, Iterable<_i3.ProduttoreScalar>>?
        distinct,
    _i3.ProduttoreSelect? select,
    _i3.ProduttoreInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Produttore?>(
      action: 'findFirstProduttore',
      result: result,
      factory: (e) => e != null ? _i2.Produttore.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Produttore> findFirstOrThrow({
    _i3.ProduttoreWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ProduttoreOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ProduttoreOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ProduttoreWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProduttoreScalar, Iterable<_i3.ProduttoreScalar>>?
        distinct,
    _i3.ProduttoreSelect? select,
    _i3.ProduttoreInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Produttore>(
      action: 'findFirstProduttoreOrThrow',
      result: result,
      factory: (e) => _i2.Produttore.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Produttore>> findMany({
    _i3.ProduttoreWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ProduttoreOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ProduttoreOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ProduttoreWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProduttoreScalar, Iterable<_i3.ProduttoreScalar>>?
        distinct,
    _i3.ProduttoreSelect? select,
    _i3.ProduttoreInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Produttore>>(
      action: 'findManyProduttore',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Produttore.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Produttore> create({
    required _i1.PrismaUnion<_i3.ProduttoreCreateInput,
            _i3.ProduttoreUncheckedCreateInput>
        data,
    _i3.ProduttoreSelect? select,
    _i3.ProduttoreInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Produttore>(
      action: 'createOneProduttore',
      result: result,
      factory: (e) => _i2.Produttore.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ProduttoreCreateManyInput,
            Iterable<_i3.ProduttoreCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyProduttore',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Produttore?> update({
    required _i1.PrismaUnion<_i3.ProduttoreUpdateInput,
            _i3.ProduttoreUncheckedUpdateInput>
        data,
    required _i3.ProduttoreWhereUniqueInput where,
    _i3.ProduttoreSelect? select,
    _i3.ProduttoreInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Produttore?>(
      action: 'updateOneProduttore',
      result: result,
      factory: (e) => e != null ? _i2.Produttore.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ProduttoreUpdateManyMutationInput,
            _i3.ProduttoreUncheckedUpdateManyInput>
        data,
    _i3.ProduttoreWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyProduttore',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Produttore> upsert({
    required _i3.ProduttoreWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ProduttoreCreateInput,
            _i3.ProduttoreUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ProduttoreUpdateInput,
            _i3.ProduttoreUncheckedUpdateInput>
        update,
    _i3.ProduttoreSelect? select,
    _i3.ProduttoreInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Produttore>(
      action: 'upsertOneProduttore',
      result: result,
      factory: (e) => _i2.Produttore.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Produttore?> delete({
    required _i3.ProduttoreWhereUniqueInput where,
    _i3.ProduttoreSelect? select,
    _i3.ProduttoreInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Produttore?>(
      action: 'deleteOneProduttore',
      result: result,
      factory: (e) => e != null ? _i2.Produttore.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ProduttoreWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyProduttore',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ProduttoreGroupByOutputType>> groupBy({
    _i3.ProduttoreWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProduttoreOrderByWithAggregationInput>,
            _i3.ProduttoreOrderByWithAggregationInput>?
        orderBy,
    required _i1
        .PrismaUnion<Iterable<_i3.ProduttoreScalar>, _i3.ProduttoreScalar>
        by,
    _i3.ProduttoreScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ProduttoreGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ProduttoreGroupByOutputType>>(
      action: 'groupByProduttore',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ProduttoreGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateProduttore> aggregate({
    _i3.ProduttoreWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ProduttoreOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ProduttoreOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ProduttoreWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateProduttoreSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Produttore',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateProduttore>(
      action: 'aggregateProduttore',
      result: result,
      factory: (e) => _i3.AggregateProduttore.fromJson(e),
    );
  }
}

class UtenteDelegate {
  const UtenteDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Utente?> findUnique({
    required _i3.UtenteWhereUniqueInput where,
    _i3.UtenteSelect? select,
    _i3.UtenteInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Utente?>(
      action: 'findUniqueUtente',
      result: result,
      factory: (e) => e != null ? _i2.Utente.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Utente> findUniqueOrThrow({
    required _i3.UtenteWhereUniqueInput where,
    _i3.UtenteSelect? select,
    _i3.UtenteInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Utente>(
      action: 'findUniqueUtenteOrThrow',
      result: result,
      factory: (e) => _i2.Utente.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Utente?> findFirst({
    _i3.UtenteWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.UtenteOrderByWithRelationAndSearchRelevanceInput>,
            _i3.UtenteOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.UtenteWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.UtenteScalar, Iterable<_i3.UtenteScalar>>? distinct,
    _i3.UtenteSelect? select,
    _i3.UtenteInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Utente?>(
      action: 'findFirstUtente',
      result: result,
      factory: (e) => e != null ? _i2.Utente.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Utente> findFirstOrThrow({
    _i3.UtenteWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.UtenteOrderByWithRelationAndSearchRelevanceInput>,
            _i3.UtenteOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.UtenteWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.UtenteScalar, Iterable<_i3.UtenteScalar>>? distinct,
    _i3.UtenteSelect? select,
    _i3.UtenteInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Utente>(
      action: 'findFirstUtenteOrThrow',
      result: result,
      factory: (e) => _i2.Utente.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Utente>> findMany({
    _i3.UtenteWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.UtenteOrderByWithRelationAndSearchRelevanceInput>,
            _i3.UtenteOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.UtenteWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.UtenteScalar, Iterable<_i3.UtenteScalar>>? distinct,
    _i3.UtenteSelect? select,
    _i3.UtenteInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Utente>>(
      action: 'findManyUtente',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Utente.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Utente> create({
    required _i1
        .PrismaUnion<_i3.UtenteCreateInput, _i3.UtenteUncheckedCreateInput>
        data,
    _i3.UtenteSelect? select,
    _i3.UtenteInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Utente>(
      action: 'createOneUtente',
      result: result,
      factory: (e) => _i2.Utente.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.UtenteCreateManyInput,
            Iterable<_i3.UtenteCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyUtente',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Utente?> update({
    required _i1
        .PrismaUnion<_i3.UtenteUpdateInput, _i3.UtenteUncheckedUpdateInput>
        data,
    required _i3.UtenteWhereUniqueInput where,
    _i3.UtenteSelect? select,
    _i3.UtenteInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Utente?>(
      action: 'updateOneUtente',
      result: result,
      factory: (e) => e != null ? _i2.Utente.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.UtenteUpdateManyMutationInput,
            _i3.UtenteUncheckedUpdateManyInput>
        data,
    _i3.UtenteWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyUtente',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Utente> upsert({
    required _i3.UtenteWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.UtenteCreateInput, _i3.UtenteUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.UtenteUpdateInput, _i3.UtenteUncheckedUpdateInput>
        update,
    _i3.UtenteSelect? select,
    _i3.UtenteInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Utente>(
      action: 'upsertOneUtente',
      result: result,
      factory: (e) => _i2.Utente.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Utente?> delete({
    required _i3.UtenteWhereUniqueInput where,
    _i3.UtenteSelect? select,
    _i3.UtenteInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Utente?>(
      action: 'deleteOneUtente',
      result: result,
      factory: (e) => e != null ? _i2.Utente.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.UtenteWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyUtente',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.UtenteGroupByOutputType>> groupBy({
    _i3.UtenteWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.UtenteOrderByWithAggregationInput>,
            _i3.UtenteOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.UtenteScalar>, _i3.UtenteScalar> by,
    _i3.UtenteScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.UtenteGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.UtenteGroupByOutputType>>(
      action: 'groupByUtente',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.UtenteGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateUtente> aggregate({
    _i3.UtenteWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.UtenteOrderByWithRelationAndSearchRelevanceInput>,
            _i3.UtenteOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.UtenteWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateUtenteSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Utente',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateUtente>(
      action: 'aggregateUtente',
      result: result,
      factory: (e) => _i3.AggregateUtente.fromJson(e),
    );
  }
}

class NegozioDelegate {
  const NegozioDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Negozio?> findUnique({
    required _i3.NegozioWhereUniqueInput where,
    _i3.NegozioSelect? select,
    _i3.NegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Negozio?>(
      action: 'findUniqueNegozio',
      result: result,
      factory: (e) => e != null ? _i2.Negozio.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Negozio> findUniqueOrThrow({
    required _i3.NegozioWhereUniqueInput where,
    _i3.NegozioSelect? select,
    _i3.NegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Negozio>(
      action: 'findUniqueNegozioOrThrow',
      result: result,
      factory: (e) => _i2.Negozio.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Negozio?> findFirst({
    _i3.NegozioWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.NegozioOrderByWithRelationAndSearchRelevanceInput>,
            _i3.NegozioOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.NegozioWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.NegozioScalar, Iterable<_i3.NegozioScalar>>? distinct,
    _i3.NegozioSelect? select,
    _i3.NegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Negozio?>(
      action: 'findFirstNegozio',
      result: result,
      factory: (e) => e != null ? _i2.Negozio.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Negozio> findFirstOrThrow({
    _i3.NegozioWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.NegozioOrderByWithRelationAndSearchRelevanceInput>,
            _i3.NegozioOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.NegozioWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.NegozioScalar, Iterable<_i3.NegozioScalar>>? distinct,
    _i3.NegozioSelect? select,
    _i3.NegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Negozio>(
      action: 'findFirstNegozioOrThrow',
      result: result,
      factory: (e) => _i2.Negozio.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Negozio>> findMany({
    _i3.NegozioWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.NegozioOrderByWithRelationAndSearchRelevanceInput>,
            _i3.NegozioOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.NegozioWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.NegozioScalar, Iterable<_i3.NegozioScalar>>? distinct,
    _i3.NegozioSelect? select,
    _i3.NegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Negozio>>(
      action: 'findManyNegozio',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Negozio.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Negozio> create({
    required _i1
        .PrismaUnion<_i3.NegozioCreateInput, _i3.NegozioUncheckedCreateInput>
        data,
    _i3.NegozioSelect? select,
    _i3.NegozioInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Negozio>(
      action: 'createOneNegozio',
      result: result,
      factory: (e) => _i2.Negozio.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.NegozioCreateManyInput,
            Iterable<_i3.NegozioCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyNegozio',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Negozio?> update({
    required _i1
        .PrismaUnion<_i3.NegozioUpdateInput, _i3.NegozioUncheckedUpdateInput>
        data,
    required _i3.NegozioWhereUniqueInput where,
    _i3.NegozioSelect? select,
    _i3.NegozioInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Negozio?>(
      action: 'updateOneNegozio',
      result: result,
      factory: (e) => e != null ? _i2.Negozio.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.NegozioUpdateManyMutationInput,
            _i3.NegozioUncheckedUpdateManyInput>
        data,
    _i3.NegozioWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyNegozio',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Negozio> upsert({
    required _i3.NegozioWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.NegozioCreateInput, _i3.NegozioUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.NegozioUpdateInput, _i3.NegozioUncheckedUpdateInput>
        update,
    _i3.NegozioSelect? select,
    _i3.NegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Negozio>(
      action: 'upsertOneNegozio',
      result: result,
      factory: (e) => _i2.Negozio.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Negozio?> delete({
    required _i3.NegozioWhereUniqueInput where,
    _i3.NegozioSelect? select,
    _i3.NegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Negozio?>(
      action: 'deleteOneNegozio',
      result: result,
      factory: (e) => e != null ? _i2.Negozio.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.NegozioWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyNegozio',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.NegozioGroupByOutputType>> groupBy({
    _i3.NegozioWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.NegozioOrderByWithAggregationInput>,
            _i3.NegozioOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.NegozioScalar>, _i3.NegozioScalar> by,
    _i3.NegozioScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.NegozioGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.NegozioGroupByOutputType>>(
      action: 'groupByNegozio',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.NegozioGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateNegozio> aggregate({
    _i3.NegozioWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.NegozioOrderByWithRelationAndSearchRelevanceInput>,
            _i3.NegozioOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.NegozioWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateNegozioSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Negozio',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateNegozio>(
      action: 'aggregateNegozio',
      result: result,
      factory: (e) => _i3.AggregateNegozio.fromJson(e),
    );
  }
}

class IngressiDelegate {
  const IngressiDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Ingressi?> findUnique({
    required _i3.IngressiWhereUniqueInput where,
    _i3.IngressiSelect? select,
    _i3.IngressiInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ingressi?>(
      action: 'findUniqueIngressi',
      result: result,
      factory: (e) => e != null ? _i2.Ingressi.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Ingressi> findUniqueOrThrow({
    required _i3.IngressiWhereUniqueInput where,
    _i3.IngressiSelect? select,
    _i3.IngressiInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ingressi>(
      action: 'findUniqueIngressiOrThrow',
      result: result,
      factory: (e) => _i2.Ingressi.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Ingressi?> findFirst({
    _i3.IngressiWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.IngressiOrderByWithRelationAndSearchRelevanceInput>,
            _i3.IngressiOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.IngressiWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.IngressiScalar, Iterable<_i3.IngressiScalar>>? distinct,
    _i3.IngressiSelect? select,
    _i3.IngressiInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ingressi?>(
      action: 'findFirstIngressi',
      result: result,
      factory: (e) => e != null ? _i2.Ingressi.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Ingressi> findFirstOrThrow({
    _i3.IngressiWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.IngressiOrderByWithRelationAndSearchRelevanceInput>,
            _i3.IngressiOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.IngressiWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.IngressiScalar, Iterable<_i3.IngressiScalar>>? distinct,
    _i3.IngressiSelect? select,
    _i3.IngressiInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ingressi>(
      action: 'findFirstIngressiOrThrow',
      result: result,
      factory: (e) => _i2.Ingressi.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Ingressi>> findMany({
    _i3.IngressiWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.IngressiOrderByWithRelationAndSearchRelevanceInput>,
            _i3.IngressiOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.IngressiWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.IngressiScalar, Iterable<_i3.IngressiScalar>>? distinct,
    _i3.IngressiSelect? select,
    _i3.IngressiInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Ingressi>>(
      action: 'findManyIngressi',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Ingressi.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Ingressi> create({
    required _i1
        .PrismaUnion<_i3.IngressiCreateInput, _i3.IngressiUncheckedCreateInput>
        data,
    _i3.IngressiSelect? select,
    _i3.IngressiInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ingressi>(
      action: 'createOneIngressi',
      result: result,
      factory: (e) => _i2.Ingressi.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.IngressiCreateManyInput,
            Iterable<_i3.IngressiCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyIngressi',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Ingressi?> update({
    required _i1
        .PrismaUnion<_i3.IngressiUpdateInput, _i3.IngressiUncheckedUpdateInput>
        data,
    required _i3.IngressiWhereUniqueInput where,
    _i3.IngressiSelect? select,
    _i3.IngressiInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ingressi?>(
      action: 'updateOneIngressi',
      result: result,
      factory: (e) => e != null ? _i2.Ingressi.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.IngressiUpdateManyMutationInput,
            _i3.IngressiUncheckedUpdateManyInput>
        data,
    _i3.IngressiWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyIngressi',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Ingressi> upsert({
    required _i3.IngressiWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.IngressiCreateInput, _i3.IngressiUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.IngressiUpdateInput, _i3.IngressiUncheckedUpdateInput>
        update,
    _i3.IngressiSelect? select,
    _i3.IngressiInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ingressi>(
      action: 'upsertOneIngressi',
      result: result,
      factory: (e) => _i2.Ingressi.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Ingressi?> delete({
    required _i3.IngressiWhereUniqueInput where,
    _i3.IngressiSelect? select,
    _i3.IngressiInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Ingressi?>(
      action: 'deleteOneIngressi',
      result: result,
      factory: (e) => e != null ? _i2.Ingressi.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.IngressiWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyIngressi',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.IngressiGroupByOutputType>> groupBy({
    _i3.IngressiWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.IngressiOrderByWithAggregationInput>,
            _i3.IngressiOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.IngressiScalar>, _i3.IngressiScalar>
        by,
    _i3.IngressiScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.IngressiGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.IngressiGroupByOutputType>>(
      action: 'groupByIngressi',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.IngressiGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateIngressi> aggregate({
    _i3.IngressiWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.IngressiOrderByWithRelationAndSearchRelevanceInput>,
            _i3.IngressiOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.IngressiWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateIngressiSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Ingressi',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateIngressi>(
      action: 'aggregateIngressi',
      result: result,
      factory: (e) => _i3.AggregateIngressi.fromJson(e),
    );
  }
}

class ZonaNegozioDelegate {
  const ZonaNegozioDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.ZonaNegozio?> findUnique({
    required _i3.ZonaNegozioWhereUniqueInput where,
    _i3.ZonaNegozioSelect? select,
    _i3.ZonaNegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ZonaNegozio?>(
      action: 'findUniqueZonaNegozio',
      result: result,
      factory: (e) => e != null ? _i2.ZonaNegozio.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ZonaNegozio> findUniqueOrThrow({
    required _i3.ZonaNegozioWhereUniqueInput where,
    _i3.ZonaNegozioSelect? select,
    _i3.ZonaNegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ZonaNegozio>(
      action: 'findUniqueZonaNegozioOrThrow',
      result: result,
      factory: (e) => _i2.ZonaNegozio.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ZonaNegozio?> findFirst({
    _i3.ZonaNegozioWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ZonaNegozioOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ZonaNegozioOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ZonaNegozioWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ZonaNegozioScalar, Iterable<_i3.ZonaNegozioScalar>>?
        distinct,
    _i3.ZonaNegozioSelect? select,
    _i3.ZonaNegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ZonaNegozio?>(
      action: 'findFirstZonaNegozio',
      result: result,
      factory: (e) => e != null ? _i2.ZonaNegozio.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ZonaNegozio> findFirstOrThrow({
    _i3.ZonaNegozioWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ZonaNegozioOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ZonaNegozioOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ZonaNegozioWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ZonaNegozioScalar, Iterable<_i3.ZonaNegozioScalar>>?
        distinct,
    _i3.ZonaNegozioSelect? select,
    _i3.ZonaNegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ZonaNegozio>(
      action: 'findFirstZonaNegozioOrThrow',
      result: result,
      factory: (e) => _i2.ZonaNegozio.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.ZonaNegozio>> findMany({
    _i3.ZonaNegozioWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ZonaNegozioOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ZonaNegozioOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ZonaNegozioWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ZonaNegozioScalar, Iterable<_i3.ZonaNegozioScalar>>?
        distinct,
    _i3.ZonaNegozioSelect? select,
    _i3.ZonaNegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.ZonaNegozio>>(
      action: 'findManyZonaNegozio',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.ZonaNegozio.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ZonaNegozio> create({
    required _i1.PrismaUnion<_i3.ZonaNegozioCreateInput,
            _i3.ZonaNegozioUncheckedCreateInput>
        data,
    _i3.ZonaNegozioSelect? select,
    _i3.ZonaNegozioInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ZonaNegozio>(
      action: 'createOneZonaNegozio',
      result: result,
      factory: (e) => _i2.ZonaNegozio.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.ZonaNegozioCreateManyInput,
            Iterable<_i3.ZonaNegozioCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyZonaNegozio',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ZonaNegozio?> update({
    required _i1.PrismaUnion<_i3.ZonaNegozioUpdateInput,
            _i3.ZonaNegozioUncheckedUpdateInput>
        data,
    required _i3.ZonaNegozioWhereUniqueInput where,
    _i3.ZonaNegozioSelect? select,
    _i3.ZonaNegozioInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ZonaNegozio?>(
      action: 'updateOneZonaNegozio',
      result: result,
      factory: (e) => e != null ? _i2.ZonaNegozio.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ZonaNegozioUpdateManyMutationInput,
            _i3.ZonaNegozioUncheckedUpdateManyInput>
        data,
    _i3.ZonaNegozioWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyZonaNegozio',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ZonaNegozio> upsert({
    required _i3.ZonaNegozioWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ZonaNegozioCreateInput,
            _i3.ZonaNegozioUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ZonaNegozioUpdateInput,
            _i3.ZonaNegozioUncheckedUpdateInput>
        update,
    _i3.ZonaNegozioSelect? select,
    _i3.ZonaNegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ZonaNegozio>(
      action: 'upsertOneZonaNegozio',
      result: result,
      factory: (e) => _i2.ZonaNegozio.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ZonaNegozio?> delete({
    required _i3.ZonaNegozioWhereUniqueInput where,
    _i3.ZonaNegozioSelect? select,
    _i3.ZonaNegozioInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ZonaNegozio?>(
      action: 'deleteOneZonaNegozio',
      result: result,
      factory: (e) => e != null ? _i2.ZonaNegozio.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.ZonaNegozioWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyZonaNegozio',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ZonaNegozioGroupByOutputType>> groupBy({
    _i3.ZonaNegozioWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ZonaNegozioOrderByWithAggregationInput>,
            _i3.ZonaNegozioOrderByWithAggregationInput>?
        orderBy,
    required _i1
        .PrismaUnion<Iterable<_i3.ZonaNegozioScalar>, _i3.ZonaNegozioScalar>
        by,
    _i3.ZonaNegozioScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ZonaNegozioGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ZonaNegozioGroupByOutputType>>(
      action: 'groupByZonaNegozio',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ZonaNegozioGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateZonaNegozio> aggregate({
    _i3.ZonaNegozioWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.ZonaNegozioOrderByWithRelationAndSearchRelevanceInput>,
            _i3.ZonaNegozioOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.ZonaNegozioWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateZonaNegozioSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ZonaNegozio',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateZonaNegozio>(
      action: 'aggregateZonaNegozio',
      result: result,
      factory: (e) => _i3.AggregateZonaNegozio.fromJson(e),
    );
  }
}

class LeadDelegate {
  const LeadDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Lead?> findUnique({
    required _i3.LeadWhereUniqueInput where,
    _i3.LeadSelect? select,
    _i3.LeadInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Lead?>(
      action: 'findUniqueLead',
      result: result,
      factory: (e) => e != null ? _i2.Lead.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Lead> findUniqueOrThrow({
    required _i3.LeadWhereUniqueInput where,
    _i3.LeadSelect? select,
    _i3.LeadInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Lead>(
      action: 'findUniqueLeadOrThrow',
      result: result,
      factory: (e) => _i2.Lead.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Lead?> findFirst({
    _i3.LeadWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.LeadOrderByWithRelationAndSearchRelevanceInput>,
            _i3.LeadOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.LeadWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.LeadScalar, Iterable<_i3.LeadScalar>>? distinct,
    _i3.LeadSelect? select,
    _i3.LeadInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Lead?>(
      action: 'findFirstLead',
      result: result,
      factory: (e) => e != null ? _i2.Lead.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Lead> findFirstOrThrow({
    _i3.LeadWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.LeadOrderByWithRelationAndSearchRelevanceInput>,
            _i3.LeadOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.LeadWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.LeadScalar, Iterable<_i3.LeadScalar>>? distinct,
    _i3.LeadSelect? select,
    _i3.LeadInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Lead>(
      action: 'findFirstLeadOrThrow',
      result: result,
      factory: (e) => _i2.Lead.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Lead>> findMany({
    _i3.LeadWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.LeadOrderByWithRelationAndSearchRelevanceInput>,
            _i3.LeadOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.LeadWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.LeadScalar, Iterable<_i3.LeadScalar>>? distinct,
    _i3.LeadSelect? select,
    _i3.LeadInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Lead>>(
      action: 'findManyLead',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Lead.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Lead> create({
    required _i1.PrismaUnion<_i3.LeadCreateInput, _i3.LeadUncheckedCreateInput>
        data,
    _i3.LeadSelect? select,
    _i3.LeadInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Lead>(
      action: 'createOneLead',
      result: result,
      factory: (e) => _i2.Lead.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1
        .PrismaUnion<_i3.LeadCreateManyInput, Iterable<_i3.LeadCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyLead',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Lead?> update({
    required _i1.PrismaUnion<_i3.LeadUpdateInput, _i3.LeadUncheckedUpdateInput>
        data,
    required _i3.LeadWhereUniqueInput where,
    _i3.LeadSelect? select,
    _i3.LeadInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Lead?>(
      action: 'updateOneLead',
      result: result,
      factory: (e) => e != null ? _i2.Lead.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.LeadUpdateManyMutationInput,
            _i3.LeadUncheckedUpdateManyInput>
        data,
    _i3.LeadWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyLead',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Lead> upsert({
    required _i3.LeadWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.LeadCreateInput, _i3.LeadUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.LeadUpdateInput, _i3.LeadUncheckedUpdateInput>
        update,
    _i3.LeadSelect? select,
    _i3.LeadInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Lead>(
      action: 'upsertOneLead',
      result: result,
      factory: (e) => _i2.Lead.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Lead?> delete({
    required _i3.LeadWhereUniqueInput where,
    _i3.LeadSelect? select,
    _i3.LeadInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Lead?>(
      action: 'deleteOneLead',
      result: result,
      factory: (e) => e != null ? _i2.Lead.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.LeadWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyLead',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.LeadGroupByOutputType>> groupBy({
    _i3.LeadWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.LeadOrderByWithAggregationInput>,
            _i3.LeadOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.LeadScalar>, _i3.LeadScalar> by,
    _i3.LeadScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.LeadGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.LeadGroupByOutputType>>(
      action: 'groupByLead',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.LeadGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateLead> aggregate({
    _i3.LeadWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.LeadOrderByWithRelationAndSearchRelevanceInput>,
            _i3.LeadOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.LeadWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateLeadSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Lead',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateLead>(
      action: 'aggregateLead',
      result: result,
      factory: (e) => _i3.AggregateLead.fromJson(e),
    );
  }
}

class OpportunitaDelegate {
  const OpportunitaDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Opportunita?> findUnique({
    required _i3.OpportunitaWhereUniqueInput where,
    _i3.OpportunitaSelect? select,
    _i3.OpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Opportunita?>(
      action: 'findUniqueOpportunita',
      result: result,
      factory: (e) => e != null ? _i2.Opportunita.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Opportunita> findUniqueOrThrow({
    required _i3.OpportunitaWhereUniqueInput where,
    _i3.OpportunitaSelect? select,
    _i3.OpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Opportunita>(
      action: 'findUniqueOpportunitaOrThrow',
      result: result,
      factory: (e) => _i2.Opportunita.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Opportunita?> findFirst({
    _i3.OpportunitaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.OpportunitaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.OpportunitaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.OpportunitaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OpportunitaScalar, Iterable<_i3.OpportunitaScalar>>?
        distinct,
    _i3.OpportunitaSelect? select,
    _i3.OpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Opportunita?>(
      action: 'findFirstOpportunita',
      result: result,
      factory: (e) => e != null ? _i2.Opportunita.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Opportunita> findFirstOrThrow({
    _i3.OpportunitaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.OpportunitaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.OpportunitaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.OpportunitaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OpportunitaScalar, Iterable<_i3.OpportunitaScalar>>?
        distinct,
    _i3.OpportunitaSelect? select,
    _i3.OpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Opportunita>(
      action: 'findFirstOpportunitaOrThrow',
      result: result,
      factory: (e) => _i2.Opportunita.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Opportunita>> findMany({
    _i3.OpportunitaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.OpportunitaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.OpportunitaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.OpportunitaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OpportunitaScalar, Iterable<_i3.OpportunitaScalar>>?
        distinct,
    _i3.OpportunitaSelect? select,
    _i3.OpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Opportunita>>(
      action: 'findManyOpportunita',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Opportunita.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Opportunita> create({
    required _i1.PrismaUnion<_i3.OpportunitaCreateInput,
            _i3.OpportunitaUncheckedCreateInput>
        data,
    _i3.OpportunitaSelect? select,
    _i3.OpportunitaInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Opportunita>(
      action: 'createOneOpportunita',
      result: result,
      factory: (e) => _i2.Opportunita.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.OpportunitaCreateManyInput,
            Iterable<_i3.OpportunitaCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyOpportunita',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Opportunita?> update({
    required _i1.PrismaUnion<_i3.OpportunitaUpdateInput,
            _i3.OpportunitaUncheckedUpdateInput>
        data,
    required _i3.OpportunitaWhereUniqueInput where,
    _i3.OpportunitaSelect? select,
    _i3.OpportunitaInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Opportunita?>(
      action: 'updateOneOpportunita',
      result: result,
      factory: (e) => e != null ? _i2.Opportunita.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.OpportunitaUpdateManyMutationInput,
            _i3.OpportunitaUncheckedUpdateManyInput>
        data,
    _i3.OpportunitaWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyOpportunita',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Opportunita> upsert({
    required _i3.OpportunitaWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.OpportunitaCreateInput,
            _i3.OpportunitaUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.OpportunitaUpdateInput,
            _i3.OpportunitaUncheckedUpdateInput>
        update,
    _i3.OpportunitaSelect? select,
    _i3.OpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Opportunita>(
      action: 'upsertOneOpportunita',
      result: result,
      factory: (e) => _i2.Opportunita.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Opportunita?> delete({
    required _i3.OpportunitaWhereUniqueInput where,
    _i3.OpportunitaSelect? select,
    _i3.OpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Opportunita?>(
      action: 'deleteOneOpportunita',
      result: result,
      factory: (e) => e != null ? _i2.Opportunita.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.OpportunitaWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyOpportunita',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.OpportunitaGroupByOutputType>> groupBy({
    _i3.OpportunitaWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.OpportunitaOrderByWithAggregationInput>,
            _i3.OpportunitaOrderByWithAggregationInput>?
        orderBy,
    required _i1
        .PrismaUnion<Iterable<_i3.OpportunitaScalar>, _i3.OpportunitaScalar>
        by,
    _i3.OpportunitaScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.OpportunitaGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.OpportunitaGroupByOutputType>>(
      action: 'groupByOpportunita',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.OpportunitaGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateOpportunita> aggregate({
    _i3.OpportunitaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.OpportunitaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.OpportunitaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.OpportunitaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateOpportunitaSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Opportunita',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateOpportunita>(
      action: 'aggregateOpportunita',
      result: result,
      factory: (e) => _i3.AggregateOpportunita.fromJson(e),
    );
  }
}

class StatoOpportunitaDelegate {
  const StatoOpportunitaDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.StatoOpportunita?> findUnique({
    required _i3.StatoOpportunitaWhereUniqueInput where,
    _i3.StatoOpportunitaSelect? select,
    _i3.StatoOpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOpportunita?>(
      action: 'findUniqueStatoOpportunita',
      result: result,
      factory: (e) => e != null ? _i2.StatoOpportunita.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.StatoOpportunita> findUniqueOrThrow({
    required _i3.StatoOpportunitaWhereUniqueInput where,
    _i3.StatoOpportunitaSelect? select,
    _i3.StatoOpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOpportunita>(
      action: 'findUniqueStatoOpportunitaOrThrow',
      result: result,
      factory: (e) => _i2.StatoOpportunita.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoOpportunita?> findFirst({
    _i3.StatoOpportunitaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.StatoOpportunitaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoOpportunitaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoOpportunitaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.StatoOpportunitaScalar,
            Iterable<_i3.StatoOpportunitaScalar>>?
        distinct,
    _i3.StatoOpportunitaSelect? select,
    _i3.StatoOpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOpportunita?>(
      action: 'findFirstStatoOpportunita',
      result: result,
      factory: (e) => e != null ? _i2.StatoOpportunita.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.StatoOpportunita> findFirstOrThrow({
    _i3.StatoOpportunitaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.StatoOpportunitaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoOpportunitaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoOpportunitaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.StatoOpportunitaScalar,
            Iterable<_i3.StatoOpportunitaScalar>>?
        distinct,
    _i3.StatoOpportunitaSelect? select,
    _i3.StatoOpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOpportunita>(
      action: 'findFirstStatoOpportunitaOrThrow',
      result: result,
      factory: (e) => _i2.StatoOpportunita.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.StatoOpportunita>> findMany({
    _i3.StatoOpportunitaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.StatoOpportunitaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoOpportunitaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoOpportunitaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.StatoOpportunitaScalar,
            Iterable<_i3.StatoOpportunitaScalar>>?
        distinct,
    _i3.StatoOpportunitaSelect? select,
    _i3.StatoOpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.StatoOpportunita>>(
      action: 'findManyStatoOpportunita',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.StatoOpportunita.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.StatoOpportunita> create({
    required _i1.PrismaUnion<_i3.StatoOpportunitaCreateInput,
            _i3.StatoOpportunitaUncheckedCreateInput>
        data,
    _i3.StatoOpportunitaSelect? select,
    _i3.StatoOpportunitaInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOpportunita>(
      action: 'createOneStatoOpportunita',
      result: result,
      factory: (e) => _i2.StatoOpportunita.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.StatoOpportunitaCreateManyInput,
            Iterable<_i3.StatoOpportunitaCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyStatoOpportunita',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoOpportunita?> update({
    required _i1.PrismaUnion<_i3.StatoOpportunitaUpdateInput,
            _i3.StatoOpportunitaUncheckedUpdateInput>
        data,
    required _i3.StatoOpportunitaWhereUniqueInput where,
    _i3.StatoOpportunitaSelect? select,
    _i3.StatoOpportunitaInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOpportunita?>(
      action: 'updateOneStatoOpportunita',
      result: result,
      factory: (e) => e != null ? _i2.StatoOpportunita.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.StatoOpportunitaUpdateManyMutationInput,
            _i3.StatoOpportunitaUncheckedUpdateManyInput>
        data,
    _i3.StatoOpportunitaWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyStatoOpportunita',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoOpportunita> upsert({
    required _i3.StatoOpportunitaWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.StatoOpportunitaCreateInput,
            _i3.StatoOpportunitaUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.StatoOpportunitaUpdateInput,
            _i3.StatoOpportunitaUncheckedUpdateInput>
        update,
    _i3.StatoOpportunitaSelect? select,
    _i3.StatoOpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOpportunita>(
      action: 'upsertOneStatoOpportunita',
      result: result,
      factory: (e) => _i2.StatoOpportunita.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.StatoOpportunita?> delete({
    required _i3.StatoOpportunitaWhereUniqueInput where,
    _i3.StatoOpportunitaSelect? select,
    _i3.StatoOpportunitaInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.StatoOpportunita?>(
      action: 'deleteOneStatoOpportunita',
      result: result,
      factory: (e) => e != null ? _i2.StatoOpportunita.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.StatoOpportunitaWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyStatoOpportunita',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.StatoOpportunitaGroupByOutputType>> groupBy({
    _i3.StatoOpportunitaWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.StatoOpportunitaOrderByWithAggregationInput>,
            _i3.StatoOpportunitaOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.StatoOpportunitaScalar>,
            _i3.StatoOpportunitaScalar>
        by,
    _i3.StatoOpportunitaScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.StatoOpportunitaGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.StatoOpportunitaGroupByOutputType>>(
      action: 'groupByStatoOpportunita',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.StatoOpportunitaGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateStatoOpportunita> aggregate({
    _i3.StatoOpportunitaWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.StatoOpportunitaOrderByWithRelationAndSearchRelevanceInput>,
            _i3.StatoOpportunitaOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.StatoOpportunitaWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateStatoOpportunitaSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'StatoOpportunita',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateStatoOpportunita>(
      action: 'aggregateStatoOpportunita',
      result: result,
      factory: (e) => _i3.AggregateStatoOpportunita.fromJson(e),
    );
  }
}

class HistoryDelegate {
  const HistoryDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.History?> findUnique({
    required _i3.HistoryWhereUniqueInput where,
    _i3.HistorySelect? select,
    _i3.HistoryInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.History?>(
      action: 'findUniqueHistory',
      result: result,
      factory: (e) => e != null ? _i2.History.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.History> findUniqueOrThrow({
    required _i3.HistoryWhereUniqueInput where,
    _i3.HistorySelect? select,
    _i3.HistoryInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.History>(
      action: 'findUniqueHistoryOrThrow',
      result: result,
      factory: (e) => _i2.History.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.History?> findFirst({
    _i3.HistoryWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.HistoryOrderByWithRelationAndSearchRelevanceInput>,
            _i3.HistoryOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.HistoryWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.HistoryScalar, Iterable<_i3.HistoryScalar>>? distinct,
    _i3.HistorySelect? select,
    _i3.HistoryInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.History?>(
      action: 'findFirstHistory',
      result: result,
      factory: (e) => e != null ? _i2.History.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.History> findFirstOrThrow({
    _i3.HistoryWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.HistoryOrderByWithRelationAndSearchRelevanceInput>,
            _i3.HistoryOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.HistoryWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.HistoryScalar, Iterable<_i3.HistoryScalar>>? distinct,
    _i3.HistorySelect? select,
    _i3.HistoryInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.History>(
      action: 'findFirstHistoryOrThrow',
      result: result,
      factory: (e) => _i2.History.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.History>> findMany({
    _i3.HistoryWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.HistoryOrderByWithRelationAndSearchRelevanceInput>,
            _i3.HistoryOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.HistoryWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.HistoryScalar, Iterable<_i3.HistoryScalar>>? distinct,
    _i3.HistorySelect? select,
    _i3.HistoryInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.History>>(
      action: 'findManyHistory',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.History.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.History> create({
    required _i1
        .PrismaUnion<_i3.HistoryCreateInput, _i3.HistoryUncheckedCreateInput>
        data,
    _i3.HistorySelect? select,
    _i3.HistoryInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.History>(
      action: 'createOneHistory',
      result: result,
      factory: (e) => _i2.History.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.HistoryCreateManyInput,
            Iterable<_i3.HistoryCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyHistory',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.History?> update({
    required _i1
        .PrismaUnion<_i3.HistoryUpdateInput, _i3.HistoryUncheckedUpdateInput>
        data,
    required _i3.HistoryWhereUniqueInput where,
    _i3.HistorySelect? select,
    _i3.HistoryInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.History?>(
      action: 'updateOneHistory',
      result: result,
      factory: (e) => e != null ? _i2.History.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.HistoryUpdateManyMutationInput,
            _i3.HistoryUncheckedUpdateManyInput>
        data,
    _i3.HistoryWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyHistory',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.History> upsert({
    required _i3.HistoryWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.HistoryCreateInput, _i3.HistoryUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.HistoryUpdateInput, _i3.HistoryUncheckedUpdateInput>
        update,
    _i3.HistorySelect? select,
    _i3.HistoryInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.History>(
      action: 'upsertOneHistory',
      result: result,
      factory: (e) => _i2.History.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.History?> delete({
    required _i3.HistoryWhereUniqueInput where,
    _i3.HistorySelect? select,
    _i3.HistoryInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.History?>(
      action: 'deleteOneHistory',
      result: result,
      factory: (e) => e != null ? _i2.History.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.HistoryWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyHistory',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.HistoryGroupByOutputType>> groupBy({
    _i3.HistoryWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.HistoryOrderByWithAggregationInput>,
            _i3.HistoryOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.HistoryScalar>, _i3.HistoryScalar> by,
    _i3.HistoryScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.HistoryGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.HistoryGroupByOutputType>>(
      action: 'groupByHistory',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.HistoryGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateHistory> aggregate({
    _i3.HistoryWhereInput? where,
    _i1.PrismaUnion<
            Iterable<_i3.HistoryOrderByWithRelationAndSearchRelevanceInput>,
            _i3.HistoryOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.HistoryWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateHistorySelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'History',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateHistory>(
      action: 'aggregateHistory',
      result: result,
      factory: (e) => _i3.AggregateHistory.fromJson(e),
    );
  }
}

class HistoryCommentDelegate {
  const HistoryCommentDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.HistoryComment?> findUnique({
    required _i3.HistoryCommentWhereUniqueInput where,
    _i3.HistoryCommentSelect? select,
    _i3.HistoryCommentInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryComment?>(
      action: 'findUniqueHistoryComment',
      result: result,
      factory: (e) => e != null ? _i2.HistoryComment.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.HistoryComment> findUniqueOrThrow({
    required _i3.HistoryCommentWhereUniqueInput where,
    _i3.HistoryCommentSelect? select,
    _i3.HistoryCommentInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryComment>(
      action: 'findUniqueHistoryCommentOrThrow',
      result: result,
      factory: (e) => _i2.HistoryComment.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.HistoryComment?> findFirst({
    _i3.HistoryCommentWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.HistoryCommentOrderByWithRelationAndSearchRelevanceInput>,
            _i3.HistoryCommentOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.HistoryCommentWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.HistoryCommentScalar,
            Iterable<_i3.HistoryCommentScalar>>?
        distinct,
    _i3.HistoryCommentSelect? select,
    _i3.HistoryCommentInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryComment?>(
      action: 'findFirstHistoryComment',
      result: result,
      factory: (e) => e != null ? _i2.HistoryComment.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.HistoryComment> findFirstOrThrow({
    _i3.HistoryCommentWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.HistoryCommentOrderByWithRelationAndSearchRelevanceInput>,
            _i3.HistoryCommentOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.HistoryCommentWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.HistoryCommentScalar,
            Iterable<_i3.HistoryCommentScalar>>?
        distinct,
    _i3.HistoryCommentSelect? select,
    _i3.HistoryCommentInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryComment>(
      action: 'findFirstHistoryCommentOrThrow',
      result: result,
      factory: (e) => _i2.HistoryComment.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.HistoryComment>> findMany({
    _i3.HistoryCommentWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.HistoryCommentOrderByWithRelationAndSearchRelevanceInput>,
            _i3.HistoryCommentOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.HistoryCommentWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.HistoryCommentScalar,
            Iterable<_i3.HistoryCommentScalar>>?
        distinct,
    _i3.HistoryCommentSelect? select,
    _i3.HistoryCommentInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.HistoryComment>>(
      action: 'findManyHistoryComment',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.HistoryComment.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.HistoryComment> create({
    required _i1.PrismaUnion<_i3.HistoryCommentCreateInput,
            _i3.HistoryCommentUncheckedCreateInput>
        data,
    _i3.HistoryCommentSelect? select,
    _i3.HistoryCommentInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryComment>(
      action: 'createOneHistoryComment',
      result: result,
      factory: (e) => _i2.HistoryComment.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.HistoryCommentCreateManyInput,
            Iterable<_i3.HistoryCommentCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyHistoryComment',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.HistoryComment?> update({
    required _i1.PrismaUnion<_i3.HistoryCommentUpdateInput,
            _i3.HistoryCommentUncheckedUpdateInput>
        data,
    required _i3.HistoryCommentWhereUniqueInput where,
    _i3.HistoryCommentSelect? select,
    _i3.HistoryCommentInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryComment?>(
      action: 'updateOneHistoryComment',
      result: result,
      factory: (e) => e != null ? _i2.HistoryComment.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.HistoryCommentUpdateManyMutationInput,
            _i3.HistoryCommentUncheckedUpdateManyInput>
        data,
    _i3.HistoryCommentWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyHistoryComment',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.HistoryComment> upsert({
    required _i3.HistoryCommentWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.HistoryCommentCreateInput,
            _i3.HistoryCommentUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.HistoryCommentUpdateInput,
            _i3.HistoryCommentUncheckedUpdateInput>
        update,
    _i3.HistoryCommentSelect? select,
    _i3.HistoryCommentInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryComment>(
      action: 'upsertOneHistoryComment',
      result: result,
      factory: (e) => _i2.HistoryComment.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.HistoryComment?> delete({
    required _i3.HistoryCommentWhereUniqueInput where,
    _i3.HistoryCommentSelect? select,
    _i3.HistoryCommentInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryComment?>(
      action: 'deleteOneHistoryComment',
      result: result,
      factory: (e) => e != null ? _i2.HistoryComment.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.HistoryCommentWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyHistoryComment',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.HistoryCommentGroupByOutputType>> groupBy({
    _i3.HistoryCommentWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.HistoryCommentOrderByWithAggregationInput>,
            _i3.HistoryCommentOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.HistoryCommentScalar>,
            _i3.HistoryCommentScalar>
        by,
    _i3.HistoryCommentScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.HistoryCommentGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.HistoryCommentGroupByOutputType>>(
      action: 'groupByHistoryComment',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.HistoryCommentGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateHistoryComment> aggregate({
    _i3.HistoryCommentWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3.HistoryCommentOrderByWithRelationAndSearchRelevanceInput>,
            _i3.HistoryCommentOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.HistoryCommentWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateHistoryCommentSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryComment',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateHistoryComment>(
      action: 'aggregateHistoryComment',
      result: result,
      factory: (e) => _i3.AggregateHistoryComment.fromJson(e),
    );
  }
}

class HistoryAttachmentDelegate {
  const HistoryAttachmentDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.HistoryAttachment?> findUnique({
    required _i3.HistoryAttachmentWhereUniqueInput where,
    _i3.HistoryAttachmentSelect? select,
    _i3.HistoryAttachmentInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryAttachment?>(
      action: 'findUniqueHistoryAttachment',
      result: result,
      factory: (e) => e != null ? _i2.HistoryAttachment.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.HistoryAttachment> findUniqueOrThrow({
    required _i3.HistoryAttachmentWhereUniqueInput where,
    _i3.HistoryAttachmentSelect? select,
    _i3.HistoryAttachmentInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryAttachment>(
      action: 'findUniqueHistoryAttachmentOrThrow',
      result: result,
      factory: (e) => _i2.HistoryAttachment.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.HistoryAttachment?> findFirst({
    _i3.HistoryAttachmentWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .HistoryAttachmentOrderByWithRelationAndSearchRelevanceInput>,
            _i3.HistoryAttachmentOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.HistoryAttachmentWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.HistoryAttachmentScalar,
            Iterable<_i3.HistoryAttachmentScalar>>?
        distinct,
    _i3.HistoryAttachmentSelect? select,
    _i3.HistoryAttachmentInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryAttachment?>(
      action: 'findFirstHistoryAttachment',
      result: result,
      factory: (e) => e != null ? _i2.HistoryAttachment.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.HistoryAttachment> findFirstOrThrow({
    _i3.HistoryAttachmentWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .HistoryAttachmentOrderByWithRelationAndSearchRelevanceInput>,
            _i3.HistoryAttachmentOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.HistoryAttachmentWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.HistoryAttachmentScalar,
            Iterable<_i3.HistoryAttachmentScalar>>?
        distinct,
    _i3.HistoryAttachmentSelect? select,
    _i3.HistoryAttachmentInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryAttachment>(
      action: 'findFirstHistoryAttachmentOrThrow',
      result: result,
      factory: (e) => _i2.HistoryAttachment.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.HistoryAttachment>> findMany({
    _i3.HistoryAttachmentWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .HistoryAttachmentOrderByWithRelationAndSearchRelevanceInput>,
            _i3.HistoryAttachmentOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.HistoryAttachmentWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.HistoryAttachmentScalar,
            Iterable<_i3.HistoryAttachmentScalar>>?
        distinct,
    _i3.HistoryAttachmentSelect? select,
    _i3.HistoryAttachmentInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.HistoryAttachment>>(
      action: 'findManyHistoryAttachment',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.HistoryAttachment.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.HistoryAttachment> create({
    required _i1.PrismaUnion<_i3.HistoryAttachmentCreateInput,
            _i3.HistoryAttachmentUncheckedCreateInput>
        data,
    _i3.HistoryAttachmentSelect? select,
    _i3.HistoryAttachmentInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryAttachment>(
      action: 'createOneHistoryAttachment',
      result: result,
      factory: (e) => _i2.HistoryAttachment.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.HistoryAttachmentCreateManyInput,
            Iterable<_i3.HistoryAttachmentCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyHistoryAttachment',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.HistoryAttachment?> update({
    required _i1.PrismaUnion<_i3.HistoryAttachmentUpdateInput,
            _i3.HistoryAttachmentUncheckedUpdateInput>
        data,
    required _i3.HistoryAttachmentWhereUniqueInput where,
    _i3.HistoryAttachmentSelect? select,
    _i3.HistoryAttachmentInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryAttachment?>(
      action: 'updateOneHistoryAttachment',
      result: result,
      factory: (e) => e != null ? _i2.HistoryAttachment.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.HistoryAttachmentUpdateManyMutationInput,
            _i3.HistoryAttachmentUncheckedUpdateManyInput>
        data,
    _i3.HistoryAttachmentWhereInput? where,
  }) {
    final args = {
      'data': data,
      'where': where,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyHistoryAttachment',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.HistoryAttachment> upsert({
    required _i3.HistoryAttachmentWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.HistoryAttachmentCreateInput,
            _i3.HistoryAttachmentUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.HistoryAttachmentUpdateInput,
            _i3.HistoryAttachmentUncheckedUpdateInput>
        update,
    _i3.HistoryAttachmentSelect? select,
    _i3.HistoryAttachmentInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryAttachment>(
      action: 'upsertOneHistoryAttachment',
      result: result,
      factory: (e) => _i2.HistoryAttachment.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.HistoryAttachment?> delete({
    required _i3.HistoryAttachmentWhereUniqueInput where,
    _i3.HistoryAttachmentSelect? select,
    _i3.HistoryAttachmentInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.HistoryAttachment?>(
      action: 'deleteOneHistoryAttachment',
      result: result,
      factory: (e) => e != null ? _i2.HistoryAttachment.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany(
      {_i3.HistoryAttachmentWhereInput? where}) {
    final args = {'where': where};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyHistoryAttachment',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.HistoryAttachmentGroupByOutputType>> groupBy({
    _i3.HistoryAttachmentWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.HistoryAttachmentOrderByWithAggregationInput>,
            _i3.HistoryAttachmentOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.HistoryAttachmentScalar>,
            _i3.HistoryAttachmentScalar>
        by,
    _i3.HistoryAttachmentScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.HistoryAttachmentGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.HistoryAttachmentGroupByOutputType>>(
      action: 'groupByHistoryAttachment',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.HistoryAttachmentGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateHistoryAttachment> aggregate({
    _i3.HistoryAttachmentWhereInput? where,
    _i1.PrismaUnion<
            Iterable<
                _i3
                .HistoryAttachmentOrderByWithRelationAndSearchRelevanceInput>,
            _i3.HistoryAttachmentOrderByWithRelationAndSearchRelevanceInput>?
        orderBy,
    _i3.HistoryAttachmentWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateHistoryAttachmentSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'HistoryAttachment',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client._engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateHistoryAttachment>(
      action: 'aggregateHistoryAttachment',
      result: result,
      factory: (e) => _i3.AggregateHistoryAttachment.fromJson(e),
    );
  }
}

class PrismaClient {
  const PrismaClient._(
    this._engine,
    this.$transaction,
    this.$metrics,
  );

  factory PrismaClient({
    String? datasourceUrl,
    Map<String, String>? datasources,
  }) {
    datasources ??= {
      'db':
          'postgresql://johndoe:randompassword@localhost:5432/mydb?schema=public'
    };
    if (datasourceUrl != null) {
      datasources = datasources.map((
        key,
        value,
      ) =>
          MapEntry(
            key,
            datasourceUrl,
          ));
    }
    final engine = _i4.BinaryEngine(
      schema:
          'generator client {\n  provider        = "dart run orm"\n  previewFeatures = ["fullTextSearch", "fullTextIndex"]\n}\n\ndatasource db {\n  provider     = "mysql"\n  url          = env("DATABASE_URL")\n  relationMode = "prisma"\n}\n\nmodel Soggetto {\n  uuid                 String                @id @default(uuid())\n  ragioneSociale       String\n  iban                 String?\n  tipo                 TipoSoggetto\n  negozioPreferitoUuid String?\n  codiceFiscale        String?               @unique\n  note                 String?\n  soggettoBusinessInfo SoggettoBusinessInfo?\n  domicili             Domicilio[]\n  praticheIntestate    Pratica[]\n  contratti            Contratto[]\n  indirizziEmail       IndirizzoEmail[]\n  numeriTelefono       NumeroTelefono[]\n  negozioPreferito     Negozio?              @relation(fields: [negozioPreferitoUuid], references: [codice])\n  prodottiOrdinati     Ordine[]\n  leads                Lead[]\n  // TODO remove nullability after upgrade to Prisma > 4.x\n  privacy              Privacy?\n\n  @@index([negozioPreferitoUuid])\n  @@index([tipo])\n}\n\nmodel Privacy {\n  uuid          String    @id @default(uuid())\n  trattamento   Boolean   @default(true)\n  comunicazione Boolean   @default(false)\n  profilazione  Boolean   @default(false)\n  soggetto      Soggetto? @relation(fields: [soggettoUuid], references: [uuid], onDelete: Cascade)\n  soggettoUuid  String?   @unique\n}\n\nmodel SoggettoBusinessInfo {\n  uuid                 String                @id @default(uuid())\n  rea                  String?\n  partitaIVA           String                @unique\n  sdi                  String?\n  soggettoUuid         String                @unique\n  legaleRappresentante LegaleRappresentante?\n  referente            Referente?\n  soggetto             Soggetto              @relation(fields: [soggettoUuid], references: [uuid], onDelete: Cascade)\n\n  @@index([soggettoUuid])\n}\n\nmodel LegaleRappresentante {\n  uuid                     String               @id @default(uuid())\n  nome                     String\n  cognome                  String\n  soggettoBusinessInfoUuid String               @unique\n  numeroTelefono           NumeroTelefono?\n  indirizzoEmail           IndirizzoEmail?\n  soggettoBusinessInfo     SoggettoBusinessInfo @relation(fields: [soggettoBusinessInfoUuid], references: [uuid])\n}\n\nmodel Referente {\n  uuid                     String               @id @default(uuid())\n  nome                     String\n  cognome                  String\n  soggettoBusinessInfoUuid String               @unique\n  numeroTelefono           NumeroTelefono?\n  indirizzoEmail           IndirizzoEmail?\n  soggettoBusinessInfo     SoggettoBusinessInfo @relation(fields: [soggettoBusinessInfoUuid], references: [uuid])\n}\n\nmodel IndirizzoEmail {\n  uuid                     String                @id @default(uuid())\n  indirizzo                String\n  etichetta                String?\n  soggettoUuid             String?\n  legaleRappresentanteUuid String?               @unique\n  referenteUuid            String?               @unique\n  soggetto                 Soggetto?             @relation(fields: [soggettoUuid], references: [uuid], onDelete: Cascade)\n  referente                Referente?            @relation(fields: [referenteUuid], references: [uuid])\n  legaleRappresentante     LegaleRappresentante? @relation(fields: [legaleRappresentanteUuid], references: [uuid])\n\n  @@unique([indirizzo, soggettoUuid])\n  @@index([soggettoUuid])\n}\n\nmodel NumeroTelefono {\n  uuid                    String                @id @default(uuid())\n  numero                  String\n  etichetta               String?\n  soggettoUuid            String?\n  legaleRappresentateUuid String?               @unique\n  referenteUuid           String?               @unique\n  soggetto                Soggetto?             @relation(fields: [soggettoUuid], references: [uuid], onDelete: Cascade)\n  legaleRappresentate     LegaleRappresentante? @relation(fields: [legaleRappresentateUuid], references: [uuid])\n  referente               Referente?            @relation(fields: [referenteUuid], references: [uuid])\n\n  @@unique([numero, soggettoUuid])\n  @@index([soggettoUuid])\n}\n\nmodel Domicilio {\n  uuid                        String                        @id @default(uuid())\n  etichetta                   String?\n  indirizzo                   String?\n  numeroCivico                String?\n  citta                       String?\n  cap                         String?\n  provincia                   String?\n  soggettoUuid                String\n  soggetto                    Soggetto                      @relation(fields: [soggettoUuid], references: [uuid], onDelete: Cascade)\n  contrattiEnelXAssicurazione ContrattoEnelXAssicurazione[]\n  forniture                   Fornitura[]\n  contrattiEnelFibra          ContrattoEnelFibra[]\n  prodottiOrdinati            Ordine[]\n  leads                       Lead[]\n\n  @@index([soggettoUuid])\n}\n\nmodel ServizioEwo {\n  id                      String            @id\n  nome                    String            @unique\n  fornitoreId             String\n  tipoServizioEwo         TipoServizioEwo\n  fornitore               Fornitore         @relation(fields: [fornitoreId], references: [id])\n  tipiPratiche            TipoPratica[]\n  colore                  String\n  icona                   String\n  forniture               Fornitura[]\n  statiPossibiliPratiche  StatoPratica[]\n  statiPossibiliContratti StatoContratto[]\n  offerte                 Offerta[]\n  moduliContratto         ModuloContratto[]\n\n  @@index([fornitoreId])\n}\n\nmodel Fornitura {\n  uuid          String         @id @default(uuid())\n  etichetta     String?\n  domicilioUuid String\n  servizioEwoId String\n  domicilio     Domicilio      @relation(fields: [domicilioUuid], references: [uuid], onDelete: Cascade)\n  servizioEwo   ServizioEwo    @relation(fields: [servizioEwoId], references: [id])\n  fornituraLuce FornituraLuce?\n  fornituraGas  FornituraGas?\n\n  @@index([domicilioUuid])\n  @@index([servizioEwoId])\n}\n\nmodel FornituraLuce {\n  uuid              String              @id @default(uuid())\n  pod               String              @unique\n  fornituraUuid     String              @unique\n  potenza           Float?\n  tensione          Float?\n  consumoAnnuoLuce  ConsumoAnnuoLuce?\n  contrattiEnelLuce ContrattoEnelLuce[]\n  fornitura         Fornitura           @relation(fields: [fornituraUuid], references: [uuid], onDelete: Cascade)\n\n  @@index([fornituraUuid])\n}\n\nmodel ConsumoAnnuoLuce {\n  uuid                        String        @id @default(uuid())\n  consumo                     Float\n  meseRiferimentoConsumoAnnuo DateTime\n  fornituraLuceUuid           String        @unique\n  fornituraLuce               FornituraLuce @relation(fields: [fornituraLuceUuid], references: [uuid], onDelete: Cascade)\n\n  @@index([meseRiferimentoConsumoAnnuo, fornituraLuceUuid])\n  @@index([fornituraLuceUuid])\n}\n\nmodel FornituraGas {\n  uuid                  String               @id @default(uuid())\n  pdr                   String               @unique\n  fornituraUuid         String               @unique\n  classeMisuratoreGasId String?\n  matricolaContatore    String?\n  remi                  String?\n  classeMisuratore      ClasseMisuratoreGas? @relation(fields: [classeMisuratoreGasId], references: [id])\n  consumoAnnuoGas       ConsumoAnnuoGas?\n  contrattiEnelGas      ContrattoEnelGas[]\n  fornitura             Fornitura            @relation(fields: [fornituraUuid], references: [uuid], onDelete: Cascade)\n\n  @@index([classeMisuratoreGasId])\n  @@index([fornituraUuid])\n}\n\nmodel ConsumoAnnuoGas {\n  uuid                        String       @id @default(uuid())\n  consumo                     Float\n  meseRiferimentoConsumoAnnuo DateTime\n  fornituraGasUuid            String       @unique\n  fornituraGas                FornituraGas @relation(fields: [fornituraGasUuid], references: [uuid], onDelete: Cascade)\n\n  @@index([meseRiferimentoConsumoAnnuo, fornituraGasUuid])\n  @@index([fornituraGasUuid])\n}\n\nmodel Contratto {\n  uuid                        String                        @id @default(uuid())\n  codice                      String                        @unique\n  dataInserimento             DateTime                      @default(now())\n  dataAttivazione             DateTime?\n  ultimoAggiornamentoStato    DateTime?\n  trend                       Boolean?\n  nota                        String?\n  marketingEnelEnergia        Boolean                       @default(false)\n  marketingGruppoEnel         Boolean                       @default(false)\n  profilazioneEnelEnergia     Boolean                       @default(false)\n  bollettaWeb                 Boolean                       @default(false)\n  rid                         Boolean                       @default(false)\n  dataCessazione              DateTime?\n  mesiDurata                  Int?\n  offertaUuid                 String?\n  contrattiEnelLuce           ContrattoEnelLuce[]\n  contrattiEnelGas            ContrattoEnelGas[]\n  contrattiEnelFibra          ContrattoEnelFibra[]\n  contrattiEnelXAssicurazione ContrattoEnelXAssicurazione[]\n  stato                       StatoContratto                @relation(fields: [statoContrattoId], references: [id])\n  statoContrattoId            String\n  soggetto                    Soggetto?                     @relation(fields: [soggettoUuid], references: [uuid])\n  soggettoUuid                String?\n  utente                      Utente?                       @relation(fields: [utenteUuid], references: [uuid])\n  utenteUuid                  String?\n  negozio                     Negozio?                      @relation(fields: [negozioCodice], references: [codice])\n  negozioCodice               String?\n  pratica                     Pratica?                      @relation(fields: [praticaUuid], references: [uuid])\n  praticaUuid                 String?\n  modulo                      ModuloContratto?              @relation(fields: [moduloContrattoId], references: [id])\n  moduloContrattoId           String?\n\n  @@index([statoContrattoId])\n  @@index([praticaUuid])\n  @@index([negozioCodice])\n  @@index([utenteUuid])\n  @@index([soggettoUuid])\n  @@index([offertaUuid])\n  @@index([moduloContrattoId])\n  @@index([dataInserimento])\n}\n\nmodel ModuloContratto {\n  id                    String              @id\n  nome                  String              @unique\n  fornitoreId           String\n  clienteTarget         TipoSoggetto\n  canale                Canale\n  serviziEwoCollegabili ServizioEwo[]\n  contratti             Contratto[]\n  fornitore             Fornitore           @relation(fields: [fornitoreId], references: [id])\n  tipoModulo            TipoModuloContratto @relation(fields: [tipoModuloContrattoId], references: [id])\n  tipoModuloContrattoId String\n\n  @@index([tipoModuloContrattoId])\n  @@index([fornitoreId])\n  @@index([canale])\n}\n\nmodel TipoModuloContratto {\n  id                       String            @id\n  nome                     String\n  numeroOfferteCollegabili Int\n  ModuloContratto          ModuloContratto[]\n}\n\nmodel StatoContratto {\n  id                          String                        @id\n  nome                        String\n  contratti                   Contratto[]\n  serviziEwo                  ServizioEwo[]\n  contrattiEnelLuce           ContrattoEnelLuce[]\n  contrattiEnelGas            ContrattoEnelGas[]\n  contrattiEnelFibra          ContrattoEnelFibra[]\n  contrattiEnelXAssicurazione ContrattoEnelXAssicurazione[]\n}\n\nmodel Offerta {\n  uuid                        String                        @id @default(uuid())\n  nome                        String                        @unique\n  dataFineOfferta             DateTime\n  dataInizioOfferta           DateTime\n  servizioEwoId               String\n  servizioEwo                 ServizioEwo                   @relation(fields: [servizioEwoId], references: [id])\n  contrattiEnelLuce           ContrattoEnelLuce[]\n  contrattiEnelGas            ContrattoEnelGas[]\n  contrattiEnelFibra          ContrattoEnelFibra[]\n  contrattiEnelXAssicurazione ContrattoEnelXAssicurazione[]\n  offerteIncluse              Offerta[]                     @relation("OfferteIncluse")\n  inclusaInOfferte            Offerta[]                     @relation("OfferteIncluse")\n\n  @@index([servizioEwoId])\n}\n\nmodel Pratica {\n  uuid                     String        @id @default(uuid())\n  codice                   String\n  dataInserimento          DateTime      @default(now())\n  tipoPraticaId            String\n  soggettoUuid             String?\n  utenteUuid               String?\n  negozioCodice            String?\n  statoPraticaId           String?\n  ultimoAggiornamentoStato DateTime?\n  tipoPratica              TipoPratica   @relation(fields: [tipoPraticaId], references: [id])\n  soggetto                 Soggetto?     @relation(fields: [soggettoUuid], references: [uuid])\n  utente                   Utente?       @relation(fields: [utenteUuid], references: [uuid])\n  negozio                  Negozio?      @relation(fields: [negozioCodice], references: [codice])\n  stato                    StatoPratica? @relation(fields: [statoPraticaId], references: [id])\n  contratto                Contratto[]\n\n  @@unique([codice, tipoPraticaId], name: "codicePratica_tipoPratica")\n  @@index([tipoPraticaId])\n  @@index([statoPraticaId])\n  @@index([negozioCodice])\n  @@index([utenteUuid])\n  @@index([soggettoUuid])\n}\n\nmodel TipoPratica {\n  id         String        @id\n  nome       String        @unique\n  serviziEwo ServizioEwo[]\n  pratiche   Pratica[]\n}\n\nmodel StatoPratica {\n  id         String        @id\n  nome       String\n  pratiche   Pratica[]\n  serviziEwo ServizioEwo[]\n}\n\nmodel ContrattoEnelLuce {\n  uuid              String         @id @default(uuid())\n  statoContrattoId  String\n  fornituraLuceUuid String\n  contrattoUuid     String\n  offertaUuid       String?\n  stato             StatoContratto @relation(fields: [statoContrattoId], references: [id])\n  fornituraLuce     FornituraLuce  @relation(fields: [fornituraLuceUuid], references: [uuid], onDelete: Cascade)\n  contratto         Contratto      @relation(fields: [contrattoUuid], references: [uuid], onDelete: Cascade)\n  offerta           Offerta?       @relation(fields: [offertaUuid], references: [uuid])\n\n  @@index([statoContrattoId])\n  @@index([contrattoUuid])\n  @@index([fornituraLuceUuid])\n  @@index([offertaUuid])\n}\n\nmodel ContrattoEnelGas {\n  uuid             String         @id @default(uuid())\n  statoContrattoId String\n  fornituraGasUuid String\n  contrattoUuid    String\n  offertaUuid      String?\n  stato            StatoContratto @relation(fields: [statoContrattoId], references: [id])\n  fornituraGas     FornituraGas   @relation(fields: [fornituraGasUuid], references: [uuid], onDelete: Cascade)\n  contratto        Contratto      @relation(fields: [contrattoUuid], references: [uuid], onDelete: Cascade)\n  offerta          Offerta?       @relation(fields: [offertaUuid], references: [uuid])\n\n  @@index([statoContrattoId])\n  @@index([fornituraGasUuid])\n  @@index([contrattoUuid])\n  @@index([offertaUuid])\n}\n\nmodel ContrattoEnelXAssicurazione {\n  uuid             String         @id @default(uuid())\n  statoContrattoId String\n  contrattoUuid    String\n  domicilioUuid    String\n  offertaUuid      String?\n  stato            StatoContratto @relation(fields: [statoContrattoId], references: [id])\n  contratto        Contratto      @relation(fields: [contrattoUuid], references: [uuid], onDelete: Cascade)\n  domicilio        Domicilio      @relation(fields: [domicilioUuid], references: [uuid], onDelete: Cascade)\n  offerta          Offerta?       @relation(fields: [offertaUuid], references: [uuid])\n\n  @@index([statoContrattoId])\n  @@index([contrattoUuid])\n  @@index([domicilioUuid])\n  @@index([offertaUuid])\n}\n\nmodel ContrattoEnelFibra {\n  uuid                         String                       @id @default(uuid())\n  statoContrattoId             String\n  contrattoUuid                String\n  servizioContrattoEnelFibra   ServizioContrattoEnelFibra\n  tipoContrattoEnelFibra       TipoContrattoEnelFibra\n  tecnologiaContrattoEnelFibra TecnologiaContrattoEnelFibra\n  domicilioUuid                String?\n  offertaUuid                  String?\n  stato                        StatoContratto               @relation(fields: [statoContrattoId], references: [id])\n  contratto                    Contratto                    @relation(fields: [contrattoUuid], references: [uuid], onDelete: Cascade)\n  offerta                      Offerta?                     @relation(fields: [offertaUuid], references: [uuid])\n  domicilio                    Domicilio?                   @relation(fields: [domicilioUuid], references: [uuid])\n\n  @@index([statoContrattoId])\n  @@index([contrattoUuid])\n  @@index([offertaUuid])\n  @@index([domicilioUuid])\n}\n\nmodel ClasseMisuratoreGas {\n  portataMin      Float\n  portataNominale Float\n  portataMax      Float\n  id              String         @id\n  classe          String         @unique\n  fornituraGas    FornituraGas[]\n}\n\nmodel Fornitore {\n  id              String            @id\n  nome            String            @unique\n  serviziEwo      ServizioEwo[]\n  moduliContratto ModuloContratto[]\n  prodotti        Prodotto[]\n}\n\n/// Model for "Prodotti" sold to "Clienti"\nmodel Ordine {\n  /// Unique identifier\n  uuid            String     @id @default(uuid())\n  codice          String     @unique\n  /// Date when the "Prodotto" was sold\n  dataInserimento DateTime   @default(now())\n  /// Valore dell\'ordine preventivato dall\'agente\n  valore          Float\n  /// The "Prodotti" sold\n  prodotti        Prodotto[]\n  /// The "Cliente" who bought the "Prodotto"\n  soggetto        Soggetto   @relation(fields: [soggettoUuid], references: [uuid])\n  soggettoUuid    String\n  /// The "Domicilio" linked to this "Prodotto" (and usually used in)\n  domicilio       Domicilio? @relation(fields: [domicilioUuid], references: [uuid])\n  domicilioUuid   String?\n\n  statoOrdine   StatoOrdine? @relation(fields: [statoOrdineId], references: [id])\n  statoOrdineId String?\n\n  lead     Lead?   @relation(fields: [leadUuid], references: [uuid])\n  leadUuid String?\n\n  utente        Utente   @relation(fields: [utenteUuid], references: [uuid])\n  utenteUuid    String\n  negozio       Negozio? @relation(fields: [negozioCodice], references: [codice])\n  negozioCodice String?\n\n  @@index([soggettoUuid])\n  @@index([domicilioUuid])\n  @@index([statoOrdineId])\n  @@index([leadUuid])\n  @@index([utenteUuid])\n  @@index([negozioCodice])\n}\n\nmodel StatoOrdine {\n  id        String    @id\n  nome      String\n  ordini    Ordine[]\n  tipoStato TipoStato\n  /// ordinamento del progresso degli stati\n  ordine    Int\n  colore    String\n}\n\n/// Model of unique "Prodotti" sellable to the "Clienti"\nmodel Prodotto {\n  uuid             String       @id @default(uuid())\n  /// Name of the product\n  modello          String\n  /// Price of the product\n  prezzo           Float?\n  /// Tells if the product is available for sale\n  vendibileDal     DateTime?\n  /// Tells if the product is still available for sale\n  vendibileAl      DateTime?\n  /// The "Produttore" of this "Prodotto"\n  produttore       Produttore   @relation(fields: [produttoreId], references: [id])\n  produttoreId     String\n  /// The "Prodotti Rivenduti" of this prodotto\n  prodottiOrdinati Ordine[]\n  /// The "Fornitore" of this "Prodotto"\n  fornitore        Fornitore    @relation(fields: [fornitoreId], references: [id])\n  fornitoreId      String\n  tipoProdotto     TipoProdotto @relation(fields: [tipoProdottoId], references: [id])\n  tipoProdottoId   String\n\n  @@index([produttoreId])\n  @@index([fornitoreId])\n  @@index([tipoProdottoId])\n}\n\nmodel TipoProdotto {\n  id   String @id\n  nome String @unique\n\n  prodotti Prodotto[]\n}\n\n/// Model of unique "Produttori"\nmodel Produttore {\n  /// Unique identifier\n  id   String @id\n  /// Name of the "Produttore"\n  nome String @unique\n\n  /// The "Prodotti" produced by this "Produttore"\n  prodotti Prodotto[]\n}\n\nmodel Utente {\n  uuid                 String        @id @default(uuid())\n  firebaseUid          String?       @unique\n  email                String        @unique\n  ruolo                RuoloUtente\n  photoUrl             String?\n  negozioCodice        String?\n  nomeVisualizzato     String\n  negozio              Negozio?      @relation(fields: [negozioCodice], references: [codice])\n  contratti            Contratto[]\n  pratiche             Pratica[]\n  ingressi             Ingressi[]\n  leadsGestiti         Lead[]        @relation(name: "LeadsGestore")\n  leadsAssegnati       Lead[]        @relation(name: "LeadsAgente")\n  opportunitaGestite   Opportunita[] @relation(name: "GestoriLead")\n  opportunitaAssegnate Opportunita[] @relation(name: "Agenti")\n  ordini               Ordine[]\n  history              History[]\n\n  @@index([negozioCodice])\n}\n\nmodel Negozio {\n  codice        String      @id\n  nome          String      @unique\n  pratiche      Pratica[]\n  utenti        Utente[]\n  contratti     Contratto[]\n  soggetti      Soggetto[]\n  zonaNegozio   ZonaNegozio @relation(fields: [zonaNegozioId], references: [id])\n  zonaNegozioId String\n  ingressi      Ingressi[]\n  leads         Lead[]\n  Ordine        Ordine[]\n\n  @@index([zonaNegozioId])\n}\n\nmodel Ingressi {\n  uuid          String   @id @default(uuid())\n  data          DateTime\n  clienti       Int\n  nonClienti    Int\n  utenteUuid    String\n  negozioCodice String\n  utente        Utente   @relation(fields: [utenteUuid], references: [uuid])\n  negozio       Negozio  @relation(fields: [negozioCodice], references: [codice])\n\n  @@index([data])\n  @@index([negozioCodice])\n  @@index([utenteUuid])\n}\n\nmodel ZonaNegozio {\n  id     String    @id\n  nome   String    @unique\n  negozi Negozio[]\n}\n\nmodel Lead {\n  uuid                 String           @id @default(uuid())\n  opportunita          Opportunita      @relation(fields: [opportunitaUuid], references: [uuid])\n  opportunitaUuid      String\n  soggetto             Soggetto         @relation(fields: [soggettoUuid], references: [uuid])\n  soggettoUuid         String\n  domicilio            Domicilio?       @relation(fields: [domicilioUuid], references: [uuid])\n  domicilioUuid        String?\n  statoOpportunita     StatoOpportunita @relation(fields: [statoOpportunitaUuid], references: [uuid])\n  statoOpportunitaUuid String\n  utente               Utente?          @relation(fields: [utenteUuid], references: [uuid], name: "LeadsGestore")\n  utenteUuid           String?\n  negozio              Negozio?         @relation(fields: [negozioCodice], references: [codice])\n  negozioCodice        String?\n  agente               Utente?          @relation(fields: [agenteUuid], references: [uuid], name: "LeadsAgente")\n  agenteUuid           String?\n  appuntamenti         String?          @db.MediumText\n  form                 String?          @db.MediumText\n  dataInserimento      DateTime?\n  dataScadenza         DateTime?\n  dataAppuntamento     DateTime?\n  nota                 String?\n  ordine               Ordine[]\n  history              History[]\n\n  @@index([utenteUuid])\n  @@index([domicilioUuid])\n  @@index([opportunitaUuid])\n  @@index([soggettoUuid])\n  @@index([statoOpportunitaUuid])\n  @@index([agenteUuid])\n  @@index([negozioCodice])\n}\n\nmodel Opportunita {\n  uuid        String    @id @default(uuid())\n  nome        String\n  dataInizio  DateTime?\n  dataFine    DateTime?\n  leads       Lead[]\n  form        String?   @db.MediumText\n  gestoriLead Utente[]  @relation(name: "GestoriLead")\n  agenti      Utente[]  @relation(name: "Agenti")\n}\n\nmodel StatoOpportunita {\n  uuid            String     @id @default(uuid())\n  nome            String\n  tipoStato       TipoStato?\n  /// ordinamento del progresso degli stati\n  ordine          Int?\n  colore          String\n  opportunitaUuid String\n  leads           Lead[]\n\n  @@index([opportunitaUuid])\n  @@index([ordine])\n}\n\nmodel History {\n  uuid      String   @id @default(uuid())\n  timestamp DateTime\n\n  event String\n\n  // History types\n  comment    HistoryComment?\n  attachment HistoryAttachment?\n\n  // Semantic Tables\n  Utente     Utente @relation(fields: [utenteUuid], references: [uuid], onDelete: Cascade)\n  utenteUuid String\n\n  Lead     Lead?   @relation(fields: [leadUuid], references: [uuid], onDelete: Cascade)\n  leadUuid String?\n\n  @@index([utenteUuid])\n  @@index([leadUuid])\n}\n\nmodel HistoryComment {\n  comment String\n\n  History     History @relation(fields: [historyUuid], references: [uuid])\n  historyUuid String  @unique\n}\n\nmodel HistoryAttachment {\n  url  String\n  name String\n\n  History     History @relation(fields: [historyUuid], references: [uuid])\n  historyUuid String  @unique\n}\n\nenum TipoServizioEwo {\n  FORNITURA\n  DOMICILIO\n}\n\nenum TipoSoggetto {\n  CONSUMER\n  BUSINESS\n}\n\nenum Canale {\n  SEP\n  NEVE\n  CORPORATE\n}\n\nenum ServizioContrattoEnelFibra {\n  DATI\n  DATI_VOCE\n}\n\nenum TipoContrattoEnelFibra {\n  NUOVA_ATTIVAZIONE\n  MIGRAZIONE\n}\n\nenum TecnologiaContrattoEnelFibra {\n  FTTH\n  FTTC\n}\n\nenum RuoloUtente {\n  CONSULENTE\n  AGENTE\n  OPERATORE\n  RESPONSABILE\n  AMMINISTRATORE\n  DEVELOPER\n}\n\nenum TipoStato {\n  DA_FARE\n  IN_CORSO\n  COMPLETATO\n  CANCELLATO\n}\n',
      datasources: datasources,
    );
    final metrics = _i1.MetricsClient(engine);
    createClientWithTransaction(
            _i1.TransactionClient<PrismaClient> transaction) =>
        PrismaClient._(
          engine,
          transaction,
          metrics,
        );
    final transaction = _i1.TransactionClient<PrismaClient>(
      engine,
      createClientWithTransaction,
    );
    return createClientWithTransaction(transaction);
  }

  static final datamodel = _i5.DataModel.fromJson({
    'enums': [
      {
        'name': 'TipoServizioEwo',
        'values': [
          {
            'name': 'FORNITURA',
            'dbName': null,
          },
          {
            'name': 'DOMICILIO',
            'dbName': null,
          },
        ],
        'dbName': null,
      },
      {
        'name': 'TipoSoggetto',
        'values': [
          {
            'name': 'CONSUMER',
            'dbName': null,
          },
          {
            'name': 'BUSINESS',
            'dbName': null,
          },
        ],
        'dbName': null,
      },
      {
        'name': 'Canale',
        'values': [
          {
            'name': 'SEP',
            'dbName': null,
          },
          {
            'name': 'NEVE',
            'dbName': null,
          },
          {
            'name': 'CORPORATE',
            'dbName': null,
          },
        ],
        'dbName': null,
      },
      {
        'name': 'ServizioContrattoEnelFibra',
        'values': [
          {
            'name': 'DATI',
            'dbName': null,
          },
          {
            'name': 'DATI_VOCE',
            'dbName': null,
          },
        ],
        'dbName': null,
      },
      {
        'name': 'TipoContrattoEnelFibra',
        'values': [
          {
            'name': 'NUOVA_ATTIVAZIONE',
            'dbName': null,
          },
          {
            'name': 'MIGRAZIONE',
            'dbName': null,
          },
        ],
        'dbName': null,
      },
      {
        'name': 'TecnologiaContrattoEnelFibra',
        'values': [
          {
            'name': 'FTTH',
            'dbName': null,
          },
          {
            'name': 'FTTC',
            'dbName': null,
          },
        ],
        'dbName': null,
      },
      {
        'name': 'RuoloUtente',
        'values': [
          {
            'name': 'CONSULENTE',
            'dbName': null,
          },
          {
            'name': 'AGENTE',
            'dbName': null,
          },
          {
            'name': 'OPERATORE',
            'dbName': null,
          },
          {
            'name': 'RESPONSABILE',
            'dbName': null,
          },
          {
            'name': 'AMMINISTRATORE',
            'dbName': null,
          },
          {
            'name': 'DEVELOPER',
            'dbName': null,
          },
        ],
        'dbName': null,
      },
      {
        'name': 'TipoStato',
        'values': [
          {
            'name': 'DA_FARE',
            'dbName': null,
          },
          {
            'name': 'IN_CORSO',
            'dbName': null,
          },
          {
            'name': 'COMPLETATO',
            'dbName': null,
          },
          {
            'name': 'CANCELLATO',
            'dbName': null,
          },
        ],
        'dbName': null,
      },
    ],
    'models': [
      {
        'name': 'Soggetto',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'ragioneSociale',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'iban',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tipo',
            'kind': 'enum',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'TipoSoggetto',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozioPreferitoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'codiceFiscale',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'note',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggettoBusinessInfo',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'SoggettoBusinessInfo',
            'relationName': 'SoggettoToSoggettoBusinessInfo',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'domicili',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Domicilio',
            'relationName': 'DomicilioToSoggetto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'praticheIntestate',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Pratica',
            'relationName': 'PraticaToSoggetto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contratti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Contratto',
            'relationName': 'ContrattoToSoggetto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'indirizziEmail',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'IndirizzoEmail',
            'relationName': 'IndirizzoEmailToSoggetto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'numeriTelefono',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'NumeroTelefono',
            'relationName': 'NumeroTelefonoToSoggetto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozioPreferito',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Negozio',
            'relationName': 'NegozioToSoggetto',
            'relationFromFields': ['negozioPreferitoUuid'],
            'relationToFields': ['codice'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'prodottiOrdinati',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Ordine',
            'relationName': 'OrdineToSoggetto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'leads',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Lead',
            'relationName': 'LeadToSoggetto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'privacy',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Privacy',
            'relationName': 'PrivacyToSoggetto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Privacy',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'trattamento',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Boolean',
            'default': true,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'comunicazione',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Boolean',
            'default': false,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'profilazione',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Boolean',
            'default': false,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggetto',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Soggetto',
            'relationName': 'PrivacyToSoggetto',
            'relationFromFields': ['soggettoUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggettoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'SoggettoBusinessInfo',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'rea',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'partitaIVA',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'sdi',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggettoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'legaleRappresentante',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'LegaleRappresentante',
            'relationName': 'LegaleRappresentanteToSoggettoBusinessInfo',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'referente',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Referente',
            'relationName': 'ReferenteToSoggettoBusinessInfo',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggetto',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Soggetto',
            'relationName': 'SoggettoToSoggettoBusinessInfo',
            'relationFromFields': ['soggettoUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'LegaleRappresentante',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'cognome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggettoBusinessInfoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'numeroTelefono',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'NumeroTelefono',
            'relationName': 'LegaleRappresentanteToNumeroTelefono',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'indirizzoEmail',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'IndirizzoEmail',
            'relationName': 'IndirizzoEmailToLegaleRappresentante',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggettoBusinessInfo',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'SoggettoBusinessInfo',
            'relationName': 'LegaleRappresentanteToSoggettoBusinessInfo',
            'relationFromFields': ['soggettoBusinessInfoUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Referente',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'cognome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggettoBusinessInfoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'numeroTelefono',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'NumeroTelefono',
            'relationName': 'NumeroTelefonoToReferente',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'indirizzoEmail',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'IndirizzoEmail',
            'relationName': 'IndirizzoEmailToReferente',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggettoBusinessInfo',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'SoggettoBusinessInfo',
            'relationName': 'ReferenteToSoggettoBusinessInfo',
            'relationFromFields': ['soggettoBusinessInfoUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'IndirizzoEmail',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'indirizzo',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'etichetta',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggettoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'legaleRappresentanteUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'referenteUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggetto',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Soggetto',
            'relationName': 'IndirizzoEmailToSoggetto',
            'relationFromFields': ['soggettoUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'referente',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Referente',
            'relationName': 'IndirizzoEmailToReferente',
            'relationFromFields': ['referenteUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'legaleRappresentante',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'LegaleRappresentante',
            'relationName': 'IndirizzoEmailToLegaleRappresentante',
            'relationFromFields': ['legaleRappresentanteUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [
          [
            'indirizzo',
            'soggettoUuid',
          ]
        ],
        'uniqueIndexes': [
          {
            'name': null,
            'fields': [
              'indirizzo',
              'soggettoUuid',
            ],
          }
        ],
        'isGenerated': false,
      },
      {
        'name': 'NumeroTelefono',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'numero',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'etichetta',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggettoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'legaleRappresentateUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'referenteUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggetto',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Soggetto',
            'relationName': 'NumeroTelefonoToSoggetto',
            'relationFromFields': ['soggettoUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'legaleRappresentate',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'LegaleRappresentante',
            'relationName': 'LegaleRappresentanteToNumeroTelefono',
            'relationFromFields': ['legaleRappresentateUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'referente',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Referente',
            'relationName': 'NumeroTelefonoToReferente',
            'relationFromFields': ['referenteUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [
          [
            'numero',
            'soggettoUuid',
          ]
        ],
        'uniqueIndexes': [
          {
            'name': null,
            'fields': [
              'numero',
              'soggettoUuid',
            ],
          }
        ],
        'isGenerated': false,
      },
      {
        'name': 'Domicilio',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'etichetta',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'indirizzo',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'numeroCivico',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'citta',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'cap',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'provincia',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggettoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggetto',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Soggetto',
            'relationName': 'DomicilioToSoggetto',
            'relationFromFields': ['soggettoUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelXAssicurazione',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelXAssicurazione',
            'relationName': 'ContrattoEnelXAssicurazioneToDomicilio',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'forniture',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Fornitura',
            'relationName': 'DomicilioToFornitura',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelFibra',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelFibra',
            'relationName': 'ContrattoEnelFibraToDomicilio',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'prodottiOrdinati',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Ordine',
            'relationName': 'DomicilioToOrdine',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'leads',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Lead',
            'relationName': 'DomicilioToLead',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'ServizioEwo',
        'dbName': null,
        'fields': [
          {
            'name': 'id',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornitoreId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tipoServizioEwo',
            'kind': 'enum',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'TipoServizioEwo',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornitore',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Fornitore',
            'relationName': 'FornitoreToServizioEwo',
            'relationFromFields': ['fornitoreId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tipiPratiche',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'TipoPratica',
            'relationName': 'ServizioEwoToTipoPratica',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'colore',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'icona',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'forniture',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Fornitura',
            'relationName': 'FornituraToServizioEwo',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'statiPossibiliPratiche',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'StatoPratica',
            'relationName': 'ServizioEwoToStatoPratica',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'statiPossibiliContratti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'StatoContratto',
            'relationName': 'ServizioEwoToStatoContratto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'offerte',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Offerta',
            'relationName': 'OffertaToServizioEwo',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'moduliContratto',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ModuloContratto',
            'relationName': 'ModuloContrattoToServizioEwo',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Fornitura',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'etichetta',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'domicilioUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'servizioEwoId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'domicilio',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Domicilio',
            'relationName': 'DomicilioToFornitura',
            'relationFromFields': ['domicilioUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'servizioEwo',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ServizioEwo',
            'relationName': 'FornituraToServizioEwo',
            'relationFromFields': ['servizioEwoId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornituraLuce',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'FornituraLuce',
            'relationName': 'FornituraToFornituraLuce',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornituraGas',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'FornituraGas',
            'relationName': 'FornituraToFornituraGas',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'FornituraLuce',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'pod',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornituraUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'potenza',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Float',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tensione',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Float',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'consumoAnnuoLuce',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ConsumoAnnuoLuce',
            'relationName': 'ConsumoAnnuoLuceToFornituraLuce',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelLuce',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelLuce',
            'relationName': 'ContrattoEnelLuceToFornituraLuce',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornitura',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Fornitura',
            'relationName': 'FornituraToFornituraLuce',
            'relationFromFields': ['fornituraUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'ConsumoAnnuoLuce',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'consumo',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Float',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'meseRiferimentoConsumoAnnuo',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornituraLuceUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornituraLuce',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'FornituraLuce',
            'relationName': 'ConsumoAnnuoLuceToFornituraLuce',
            'relationFromFields': ['fornituraLuceUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'FornituraGas',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'pdr',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornituraUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'classeMisuratoreGasId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'matricolaContatore',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'remi',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'classeMisuratore',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ClasseMisuratoreGas',
            'relationName': 'ClasseMisuratoreGasToFornituraGas',
            'relationFromFields': ['classeMisuratoreGasId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'consumoAnnuoGas',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ConsumoAnnuoGas',
            'relationName': 'ConsumoAnnuoGasToFornituraGas',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelGas',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelGas',
            'relationName': 'ContrattoEnelGasToFornituraGas',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornitura',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Fornitura',
            'relationName': 'FornituraToFornituraGas',
            'relationFromFields': ['fornituraUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'ConsumoAnnuoGas',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'consumo',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Float',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'meseRiferimentoConsumoAnnuo',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornituraGasUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornituraGas',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'FornituraGas',
            'relationName': 'ConsumoAnnuoGasToFornituraGas',
            'relationFromFields': ['fornituraGasUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Contratto',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'codice',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'dataInserimento',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'DateTime',
            'default': {
              'name': 'now',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'dataAttivazione',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'ultimoAggiornamentoStato',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'trend',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Boolean',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nota',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'marketingEnelEnergia',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Boolean',
            'default': false,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'marketingGruppoEnel',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Boolean',
            'default': false,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'profilazioneEnelEnergia',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Boolean',
            'default': false,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'bollettaWeb',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Boolean',
            'default': false,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'rid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Boolean',
            'default': false,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'dataCessazione',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'mesiDurata',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Int',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'offertaUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelLuce',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelLuce',
            'relationName': 'ContrattoToContrattoEnelLuce',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelGas',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelGas',
            'relationName': 'ContrattoToContrattoEnelGas',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelFibra',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelFibra',
            'relationName': 'ContrattoToContrattoEnelFibra',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelXAssicurazione',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelXAssicurazione',
            'relationName': 'ContrattoToContrattoEnelXAssicurazione',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'stato',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'StatoContratto',
            'relationName': 'ContrattoToStatoContratto',
            'relationFromFields': ['statoContrattoId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'statoContrattoId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggetto',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Soggetto',
            'relationName': 'ContrattoToSoggetto',
            'relationFromFields': ['soggettoUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggettoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'utente',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Utente',
            'relationName': 'ContrattoToUtente',
            'relationFromFields': ['utenteUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'utenteUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozio',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Negozio',
            'relationName': 'ContrattoToNegozio',
            'relationFromFields': ['negozioCodice'],
            'relationToFields': ['codice'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozioCodice',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'pratica',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Pratica',
            'relationName': 'ContrattoToPratica',
            'relationFromFields': ['praticaUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'praticaUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'modulo',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ModuloContratto',
            'relationName': 'ContrattoToModuloContratto',
            'relationFromFields': ['moduloContrattoId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'moduloContrattoId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'ModuloContratto',
        'dbName': null,
        'fields': [
          {
            'name': 'id',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornitoreId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'clienteTarget',
            'kind': 'enum',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'TipoSoggetto',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'canale',
            'kind': 'enum',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Canale',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'serviziEwoCollegabili',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ServizioEwo',
            'relationName': 'ModuloContrattoToServizioEwo',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contratti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Contratto',
            'relationName': 'ContrattoToModuloContratto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornitore',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Fornitore',
            'relationName': 'FornitoreToModuloContratto',
            'relationFromFields': ['fornitoreId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tipoModulo',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'TipoModuloContratto',
            'relationName': 'ModuloContrattoToTipoModuloContratto',
            'relationFromFields': ['tipoModuloContrattoId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tipoModuloContrattoId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'TipoModuloContratto',
        'dbName': null,
        'fields': [
          {
            'name': 'id',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'numeroOfferteCollegabili',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Int',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'ModuloContratto',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ModuloContratto',
            'relationName': 'ModuloContrattoToTipoModuloContratto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'StatoContratto',
        'dbName': null,
        'fields': [
          {
            'name': 'id',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contratti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Contratto',
            'relationName': 'ContrattoToStatoContratto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'serviziEwo',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ServizioEwo',
            'relationName': 'ServizioEwoToStatoContratto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelLuce',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelLuce',
            'relationName': 'ContrattoEnelLuceToStatoContratto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelGas',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelGas',
            'relationName': 'ContrattoEnelGasToStatoContratto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelFibra',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelFibra',
            'relationName': 'ContrattoEnelFibraToStatoContratto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelXAssicurazione',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelXAssicurazione',
            'relationName': 'ContrattoEnelXAssicurazioneToStatoContratto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Offerta',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'dataFineOfferta',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'dataInizioOfferta',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'servizioEwoId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'servizioEwo',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ServizioEwo',
            'relationName': 'OffertaToServizioEwo',
            'relationFromFields': ['servizioEwoId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelLuce',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelLuce',
            'relationName': 'ContrattoEnelLuceToOfferta',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelGas',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelGas',
            'relationName': 'ContrattoEnelGasToOfferta',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelFibra',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelFibra',
            'relationName': 'ContrattoEnelFibraToOfferta',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattiEnelXAssicurazione',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ContrattoEnelXAssicurazione',
            'relationName': 'ContrattoEnelXAssicurazioneToOfferta',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'offerteIncluse',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Offerta',
            'relationName': 'OfferteIncluse',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'inclusaInOfferte',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Offerta',
            'relationName': 'OfferteIncluse',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Pratica',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'codice',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'dataInserimento',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'DateTime',
            'default': {
              'name': 'now',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tipoPraticaId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggettoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'utenteUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozioCodice',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'statoPraticaId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'ultimoAggiornamentoStato',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tipoPratica',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'TipoPratica',
            'relationName': 'PraticaToTipoPratica',
            'relationFromFields': ['tipoPraticaId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggetto',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Soggetto',
            'relationName': 'PraticaToSoggetto',
            'relationFromFields': ['soggettoUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'utente',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Utente',
            'relationName': 'PraticaToUtente',
            'relationFromFields': ['utenteUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozio',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Negozio',
            'relationName': 'NegozioToPratica',
            'relationFromFields': ['negozioCodice'],
            'relationToFields': ['codice'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'stato',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'StatoPratica',
            'relationName': 'PraticaToStatoPratica',
            'relationFromFields': ['statoPraticaId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contratto',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Contratto',
            'relationName': 'ContrattoToPratica',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [
          [
            'codice',
            'tipoPraticaId',
          ]
        ],
        'uniqueIndexes': [
          {
            'name': 'codicePratica_tipoPratica',
            'fields': [
              'codice',
              'tipoPraticaId',
            ],
          }
        ],
        'isGenerated': false,
      },
      {
        'name': 'TipoPratica',
        'dbName': null,
        'fields': [
          {
            'name': 'id',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'serviziEwo',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ServizioEwo',
            'relationName': 'ServizioEwoToTipoPratica',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'pratiche',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Pratica',
            'relationName': 'PraticaToTipoPratica',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'StatoPratica',
        'dbName': null,
        'fields': [
          {
            'name': 'id',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'pratiche',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Pratica',
            'relationName': 'PraticaToStatoPratica',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'serviziEwo',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ServizioEwo',
            'relationName': 'ServizioEwoToStatoPratica',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'ContrattoEnelLuce',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'statoContrattoId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornituraLuceUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'offertaUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'stato',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'StatoContratto',
            'relationName': 'ContrattoEnelLuceToStatoContratto',
            'relationFromFields': ['statoContrattoId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornituraLuce',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'FornituraLuce',
            'relationName': 'ContrattoEnelLuceToFornituraLuce',
            'relationFromFields': ['fornituraLuceUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contratto',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Contratto',
            'relationName': 'ContrattoToContrattoEnelLuce',
            'relationFromFields': ['contrattoUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'offerta',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Offerta',
            'relationName': 'ContrattoEnelLuceToOfferta',
            'relationFromFields': ['offertaUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'ContrattoEnelGas',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'statoContrattoId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornituraGasUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'offertaUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'stato',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'StatoContratto',
            'relationName': 'ContrattoEnelGasToStatoContratto',
            'relationFromFields': ['statoContrattoId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornituraGas',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'FornituraGas',
            'relationName': 'ContrattoEnelGasToFornituraGas',
            'relationFromFields': ['fornituraGasUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contratto',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Contratto',
            'relationName': 'ContrattoToContrattoEnelGas',
            'relationFromFields': ['contrattoUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'offerta',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Offerta',
            'relationName': 'ContrattoEnelGasToOfferta',
            'relationFromFields': ['offertaUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'ContrattoEnelXAssicurazione',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'statoContrattoId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'domicilioUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'offertaUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'stato',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'StatoContratto',
            'relationName': 'ContrattoEnelXAssicurazioneToStatoContratto',
            'relationFromFields': ['statoContrattoId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contratto',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Contratto',
            'relationName': 'ContrattoToContrattoEnelXAssicurazione',
            'relationFromFields': ['contrattoUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'domicilio',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Domicilio',
            'relationName': 'ContrattoEnelXAssicurazioneToDomicilio',
            'relationFromFields': ['domicilioUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'offerta',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Offerta',
            'relationName': 'ContrattoEnelXAssicurazioneToOfferta',
            'relationFromFields': ['offertaUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'ContrattoEnelFibra',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'statoContrattoId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contrattoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'servizioContrattoEnelFibra',
            'kind': 'enum',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ServizioContrattoEnelFibra',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tipoContrattoEnelFibra',
            'kind': 'enum',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'TipoContrattoEnelFibra',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tecnologiaContrattoEnelFibra',
            'kind': 'enum',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'TecnologiaContrattoEnelFibra',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'domicilioUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'offertaUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'stato',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'StatoContratto',
            'relationName': 'ContrattoEnelFibraToStatoContratto',
            'relationFromFields': ['statoContrattoId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contratto',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Contratto',
            'relationName': 'ContrattoToContrattoEnelFibra',
            'relationFromFields': ['contrattoUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'offerta',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Offerta',
            'relationName': 'ContrattoEnelFibraToOfferta',
            'relationFromFields': ['offertaUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'domicilio',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Domicilio',
            'relationName': 'ContrattoEnelFibraToDomicilio',
            'relationFromFields': ['domicilioUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'ClasseMisuratoreGas',
        'dbName': null,
        'fields': [
          {
            'name': 'portataMin',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Float',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'portataNominale',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Float',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'portataMax',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Float',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'id',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'classe',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'fornituraGas',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'FornituraGas',
            'relationName': 'ClasseMisuratoreGasToFornituraGas',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Fornitore',
        'dbName': null,
        'fields': [
          {
            'name': 'id',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'serviziEwo',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ServizioEwo',
            'relationName': 'FornitoreToServizioEwo',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'moduliContratto',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ModuloContratto',
            'relationName': 'FornitoreToModuloContratto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'prodotti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Prodotto',
            'relationName': 'FornitoreToProdotto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Ordine',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'Unique identifier',
          },
          {
            'name': 'codice',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'dataInserimento',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'DateTime',
            'default': {
              'name': 'now',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'Date when the "Prodotto" was sold',
          },
          {
            'name': 'valore',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Float',
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'Valore dell\'ordine preventivato dall\'agente',
          },
          {
            'name': 'prodotti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Prodotto',
            'relationName': 'OrdineToProdotto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'The "Prodotti" sold',
          },
          {
            'name': 'soggetto',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Soggetto',
            'relationName': 'OrdineToSoggetto',
            'relationFromFields': ['soggettoUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'The "Cliente" who bought the "Prodotto"',
          },
          {
            'name': 'soggettoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'domicilio',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Domicilio',
            'relationName': 'DomicilioToOrdine',
            'relationFromFields': ['domicilioUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation':
                'The "Domicilio" linked to this "Prodotto" (and usually used in)',
          },
          {
            'name': 'domicilioUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'statoOrdine',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'StatoOrdine',
            'relationName': 'OrdineToStatoOrdine',
            'relationFromFields': ['statoOrdineId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'statoOrdineId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'lead',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Lead',
            'relationName': 'LeadToOrdine',
            'relationFromFields': ['leadUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'leadUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'utente',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Utente',
            'relationName': 'OrdineToUtente',
            'relationFromFields': ['utenteUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'utenteUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozio',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Negozio',
            'relationName': 'NegozioToOrdine',
            'relationFromFields': ['negozioCodice'],
            'relationToFields': ['codice'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozioCodice',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
        'documentation': 'Model for "Prodotti" sold to "Clienti"',
      },
      {
        'name': 'StatoOrdine',
        'dbName': null,
        'fields': [
          {
            'name': 'id',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'ordini',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Ordine',
            'relationName': 'OrdineToStatoOrdine',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tipoStato',
            'kind': 'enum',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'TipoStato',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'ordine',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Int',
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'ordinamento del progresso degli stati',
          },
          {
            'name': 'colore',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Prodotto',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'modello',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'Name of the product',
          },
          {
            'name': 'prezzo',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Float',
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'Price of the product',
          },
          {
            'name': 'vendibileDal',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'Tells if the product is available for sale',
          },
          {
            'name': 'vendibileAl',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'Tells if the product is still available for sale',
          },
          {
            'name': 'produttore',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Produttore',
            'relationName': 'ProdottoToProduttore',
            'relationFromFields': ['produttoreId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'The "Produttore" of this "Prodotto"',
          },
          {
            'name': 'produttoreId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'prodottiOrdinati',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Ordine',
            'relationName': 'OrdineToProdotto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'The "Prodotti Rivenduti" of this prodotto',
          },
          {
            'name': 'fornitore',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Fornitore',
            'relationName': 'FornitoreToProdotto',
            'relationFromFields': ['fornitoreId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'The "Fornitore" of this "Prodotto"',
          },
          {
            'name': 'fornitoreId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tipoProdotto',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'TipoProdotto',
            'relationName': 'ProdottoToTipoProdotto',
            'relationFromFields': ['tipoProdottoId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tipoProdottoId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
        'documentation': 'Model of unique "Prodotti" sellable to the "Clienti"',
      },
      {
        'name': 'TipoProdotto',
        'dbName': null,
        'fields': [
          {
            'name': 'id',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'prodotti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Prodotto',
            'relationName': 'ProdottoToTipoProdotto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Produttore',
        'dbName': null,
        'fields': [
          {
            'name': 'id',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'Unique identifier',
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'Name of the "Produttore"',
          },
          {
            'name': 'prodotti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Prodotto',
            'relationName': 'ProdottoToProduttore',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'The "Prodotti" produced by this "Produttore"',
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
        'documentation': 'Model of unique "Produttori"',
      },
      {
        'name': 'Utente',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'firebaseUid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'email',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'ruolo',
            'kind': 'enum',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'RuoloUtente',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'photoUrl',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozioCodice',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nomeVisualizzato',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozio',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Negozio',
            'relationName': 'NegozioToUtente',
            'relationFromFields': ['negozioCodice'],
            'relationToFields': ['codice'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contratti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Contratto',
            'relationName': 'ContrattoToUtente',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'pratiche',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Pratica',
            'relationName': 'PraticaToUtente',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'ingressi',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Ingressi',
            'relationName': 'IngressiToUtente',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'leadsGestiti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Lead',
            'relationName': 'LeadsGestore',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'leadsAssegnati',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Lead',
            'relationName': 'LeadsAgente',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'opportunitaGestite',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Opportunita',
            'relationName': 'GestoriLead',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'opportunitaAssegnate',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Opportunita',
            'relationName': 'Agenti',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'ordini',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Ordine',
            'relationName': 'OrdineToUtente',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'history',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'History',
            'relationName': 'HistoryToUtente',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Negozio',
        'dbName': null,
        'fields': [
          {
            'name': 'codice',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'pratiche',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Pratica',
            'relationName': 'NegozioToPratica',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'utenti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Utente',
            'relationName': 'NegozioToUtente',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'contratti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Contratto',
            'relationName': 'ContrattoToNegozio',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggetti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Soggetto',
            'relationName': 'NegozioToSoggetto',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'zonaNegozio',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ZonaNegozio',
            'relationName': 'NegozioToZonaNegozio',
            'relationFromFields': ['zonaNegozioId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'zonaNegozioId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'ingressi',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Ingressi',
            'relationName': 'IngressiToNegozio',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'leads',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Lead',
            'relationName': 'LeadToNegozio',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'Ordine',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Ordine',
            'relationName': 'NegozioToOrdine',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Ingressi',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'data',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'clienti',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Int',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nonClienti',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Int',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'utenteUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozioCodice',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'utente',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Utente',
            'relationName': 'IngressiToUtente',
            'relationFromFields': ['utenteUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozio',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Negozio',
            'relationName': 'IngressiToNegozio',
            'relationFromFields': ['negozioCodice'],
            'relationToFields': ['codice'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'ZonaNegozio',
        'dbName': null,
        'fields': [
          {
            'name': 'id',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozi',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Negozio',
            'relationName': 'NegozioToZonaNegozio',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Lead',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'opportunita',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Opportunita',
            'relationName': 'LeadToOpportunita',
            'relationFromFields': ['opportunitaUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'opportunitaUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggetto',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Soggetto',
            'relationName': 'LeadToSoggetto',
            'relationFromFields': ['soggettoUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'soggettoUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'domicilio',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Domicilio',
            'relationName': 'DomicilioToLead',
            'relationFromFields': ['domicilioUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'domicilioUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'statoOpportunita',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'StatoOpportunita',
            'relationName': 'LeadToStatoOpportunita',
            'relationFromFields': ['statoOpportunitaUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'statoOpportunitaUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'utente',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Utente',
            'relationName': 'LeadsGestore',
            'relationFromFields': ['utenteUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'utenteUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozio',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Negozio',
            'relationName': 'LeadToNegozio',
            'relationFromFields': ['negozioCodice'],
            'relationToFields': ['codice'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'negozioCodice',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'agente',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Utente',
            'relationName': 'LeadsAgente',
            'relationFromFields': ['agenteUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'agenteUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'appuntamenti',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'form',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'dataInserimento',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'dataScadenza',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'dataAppuntamento',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nota',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'ordine',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Ordine',
            'relationName': 'LeadToOrdine',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'history',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'History',
            'relationName': 'HistoryToLead',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Opportunita',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'dataInizio',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'dataFine',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'leads',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Lead',
            'relationName': 'LeadToOpportunita',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'form',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'gestoriLead',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Utente',
            'relationName': 'GestoriLead',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'agenti',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Utente',
            'relationName': 'Agenti',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'StatoOpportunita',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'nome',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tipoStato',
            'kind': 'enum',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'TipoStato',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'ordine',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Int',
            'isGenerated': false,
            'isUpdatedAt': false,
            'documentation': 'ordinamento del progresso degli stati',
          },
          {
            'name': 'colore',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'opportunitaUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'leads',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Lead',
            'relationName': 'LeadToStatoOpportunita',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'History',
        'dbName': null,
        'fields': [
          {
            'name': 'uuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'default': {
              'name': 'uuid',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'timestamp',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'event',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'comment',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'HistoryComment',
            'relationName': 'HistoryToHistoryComment',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'attachment',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'HistoryAttachment',
            'relationName': 'HistoryToHistoryAttachment',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'Utente',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Utente',
            'relationName': 'HistoryToUtente',
            'relationFromFields': ['utenteUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'utenteUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'Lead',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Lead',
            'relationName': 'HistoryToLead',
            'relationFromFields': ['leadUuid'],
            'relationToFields': ['uuid'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'leadUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'HistoryComment',
        'dbName': null,
        'fields': [
          {
            'name': 'comment',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'History',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'History',
            'relationName': 'HistoryToHistoryComment',
            'relationFromFields': ['historyUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'historyUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'HistoryAttachment',
        'dbName': null,
        'fields': [
          {
            'name': 'url',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'name',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'History',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'History',
            'relationName': 'HistoryToHistoryAttachment',
            'relationFromFields': ['historyUuid'],
            'relationToFields': ['uuid'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'historyUuid',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'String',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
    ],
    'types': [],
  });

  final _i1.MetricsClient $metrics;

  final _i1.TransactionClient<PrismaClient> $transaction;

  final _i1.Engine _engine;

  Future<void> $connect() => _engine.start();

  Future<void> $disconnect() => _engine.stop();

  SoggettoDelegate get soggetto => SoggettoDelegate._(this);

  PrivacyDelegate get privacy => PrivacyDelegate._(this);

  SoggettoBusinessInfoDelegate get soggettoBusinessInfo =>
      SoggettoBusinessInfoDelegate._(this);

  LegaleRappresentanteDelegate get legaleRappresentante =>
      LegaleRappresentanteDelegate._(this);

  ReferenteDelegate get referente => ReferenteDelegate._(this);

  IndirizzoEmailDelegate get indirizzoEmail => IndirizzoEmailDelegate._(this);

  NumeroTelefonoDelegate get numeroTelefono => NumeroTelefonoDelegate._(this);

  DomicilioDelegate get domicilio => DomicilioDelegate._(this);

  ServizioEwoDelegate get servizioEwo => ServizioEwoDelegate._(this);

  FornituraDelegate get fornitura => FornituraDelegate._(this);

  FornituraLuceDelegate get fornituraLuce => FornituraLuceDelegate._(this);

  ConsumoAnnuoLuceDelegate get consumoAnnuoLuce =>
      ConsumoAnnuoLuceDelegate._(this);

  FornituraGasDelegate get fornituraGas => FornituraGasDelegate._(this);

  ConsumoAnnuoGasDelegate get consumoAnnuoGas =>
      ConsumoAnnuoGasDelegate._(this);

  ContrattoDelegate get contratto => ContrattoDelegate._(this);

  ModuloContrattoDelegate get moduloContratto =>
      ModuloContrattoDelegate._(this);

  TipoModuloContrattoDelegate get tipoModuloContratto =>
      TipoModuloContrattoDelegate._(this);

  StatoContrattoDelegate get statoContratto => StatoContrattoDelegate._(this);

  OffertaDelegate get offerta => OffertaDelegate._(this);

  PraticaDelegate get pratica => PraticaDelegate._(this);

  TipoPraticaDelegate get tipoPratica => TipoPraticaDelegate._(this);

  StatoPraticaDelegate get statoPratica => StatoPraticaDelegate._(this);

  ContrattoEnelLuceDelegate get contrattoEnelLuce =>
      ContrattoEnelLuceDelegate._(this);

  ContrattoEnelGasDelegate get contrattoEnelGas =>
      ContrattoEnelGasDelegate._(this);

  ContrattoEnelXAssicurazioneDelegate get contrattoEnelXAssicurazione =>
      ContrattoEnelXAssicurazioneDelegate._(this);

  ContrattoEnelFibraDelegate get contrattoEnelFibra =>
      ContrattoEnelFibraDelegate._(this);

  ClasseMisuratoreGasDelegate get classeMisuratoreGas =>
      ClasseMisuratoreGasDelegate._(this);

  FornitoreDelegate get fornitore => FornitoreDelegate._(this);

  OrdineDelegate get ordine => OrdineDelegate._(this);

  StatoOrdineDelegate get statoOrdine => StatoOrdineDelegate._(this);

  ProdottoDelegate get prodotto => ProdottoDelegate._(this);

  TipoProdottoDelegate get tipoProdotto => TipoProdottoDelegate._(this);

  ProduttoreDelegate get produttore => ProduttoreDelegate._(this);

  UtenteDelegate get utente => UtenteDelegate._(this);

  NegozioDelegate get negozio => NegozioDelegate._(this);

  IngressiDelegate get ingressi => IngressiDelegate._(this);

  ZonaNegozioDelegate get zonaNegozio => ZonaNegozioDelegate._(this);

  LeadDelegate get lead => LeadDelegate._(this);

  OpportunitaDelegate get opportunita => OpportunitaDelegate._(this);

  StatoOpportunitaDelegate get statoOpportunita =>
      StatoOpportunitaDelegate._(this);

  HistoryDelegate get history => HistoryDelegate._(this);

  HistoryCommentDelegate get historyComment => HistoryCommentDelegate._(this);

  HistoryAttachmentDelegate get historyAttachment =>
      HistoryAttachmentDelegate._(this);

  _i1.RawClient<PrismaClient> get $raw => _i1.RawClient<PrismaClient>(
        _engine,
        datamodel,
        $transaction,
      );
}
