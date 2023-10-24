import '../../core/json_convertible.dart';
import '../action_client/find_unique.dart';
import 'delegate.dart';

mixin DelegateFindUnique<
    Where extends JsonConvertible<Map<String, dynamic>>,
    Select extends JsonConvertible<Map<String, dynamic>>,
    Include extends JsonConvertible<Map<String, dynamic>>> on Delegate {
  /// Find zero or one Post that matches the filter.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// // Get one Post with id 5
  /// final post = await client.post.findUnique()
  ///   .where(PostWhereInput.id(5));
  ///
  /// // Get one post with id 5 and include its author
  /// final postIncludeAuthor = await client.post.findUnique()
  ///   .where(PostWhereInput.id(5))
  ///   .include(PostInclude.author);
  /// ```
  FindUniqueActionClient<Map<String, dynamic>?, Where, Select, Include>
      findUnique() => FindUniqueActionClient(RUNTIME_CONTEXT);
}
