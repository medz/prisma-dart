bool isSchemaMissing(Map<String, dynamic> result) {
  return result['EngineNotStarted']?['reason'] == 'SchemaMissing';
}
