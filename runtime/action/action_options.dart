import '../input/input.dart';
import '../model_scalar.dart';

/// Action `where` api options structure.
///
/// If you need an automated 'where' API, please use the `ActionWhere`
/// interface.
abstract interface class ActionWhereOption<T extends Input> {}

/// Action `orderBy` api options structure.
abstract interface class ActionOrderByOption<T extends Input> {}

/// Action `cursor` api options structure.
abstract interface class ActionCursorOption<T extends Input> {}

/// Action `take` and `skip` (pagination) api options structure.
abstract interface class ActionPaginationOption {}

/// Action `distinct` api options structure.
abstract interface class ActionDistinctOption<T extends ModelScalar> {}

/// Action `having` and `by` api options structure.
abstract interface class ActionHavingOption<T extends Input,
    By extends ModelScalar> {}

/// Action `data` api options structure.
///
/// If [Many] is set to [bool], input data will be an replaceable array.
/// Otherwise, the input data will be an appendable data object.
abstract interface class ActionDataOption<T extends Input, Many> {}

/// Action `create` and `update` api options structure. (upsert)
abstract interface class ActionUpsertOptions<C extends Input,
    U extends Input> {}
