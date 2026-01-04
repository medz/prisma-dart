import 'package:analysis_server_plugin/edit/dart/correction_producer.dart';
import 'package:orm/src/analyzer/fixes/config_required_fix.dart';
import 'package:orm/src/analyzer/fixes/config_required_replace_fix.dart';
import 'package:test/test.dart';

void main() {
  test('fix kind ids', () {
    final context = StubCorrectionProducerContext.instance;
    final fix = ConfigRequiredFix(context: context);
    final replaceFix = ConfigRequiredReplaceFix(context: context);

    expect(fix.fixKind.id, 'orm.fix.config_required');
    expect(replaceFix.fixKind.id, 'orm.fix.config_required_replace');
  });
}
