// ignore_for_file: file_names

import '../input/input.dart';
import '_internal/action_helpers.dart';
import 'action.dart';
import 'action_options.dart';

extension Action$Upsert<Create extends Input, Update extends Input, U, T,
    O extends ActionUpsertOptions<Create, Update>> on Action<U, T, O> {
  Action<U, T, O> create(Create input) => fromWith('create', input);
  Action<U, T, O> update(Update input) => fromWith('update', input);
}
