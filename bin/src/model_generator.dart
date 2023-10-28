import 'context.dart';
import 'model_scalar_generator.dart';

class ModelGenerator {
  final Context context;

  const ModelGenerator(this.context);

  Future<void> handle(String model) async {
    await ModelScalarGenerator(context).handle(model);
  }
}
