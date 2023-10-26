import '../../core/json_convertible.dart';
import '../../protocol/model_action.dart';
import 'action_client.dart';

class FindUniqueActionClient<
        Where extends JsonConvertible<Map<String, dynamic>>,
        Select extends JsonConvertible<Map<String, dynamic>>,
        Include extends JsonConvertible<Map<String, dynamic>>>
    extends ActionClient<Map<String, dynamic>> {
  const FindUniqueActionClient({required super.context, super.args})
      : super(action: ModelAction.findUnique, isWrite: false);

  FindUniqueActionClient<Where, Select, Include> where(Where where) =>
      FindUniqueActionClient(
          context: context, args: toJsonWithMerge('where', where));

  FindUniqueActionClient<Where, Select, Include> select(Select select) =>
      FindUniqueActionClient(
          context: context, args: toJsonWithMerge('select', select));

  FindUniqueActionClient<Where, Select, Include> include(Include include) =>
      FindUniqueActionClient(
          context: context, args: toJsonWithMerge('include', include));
}
