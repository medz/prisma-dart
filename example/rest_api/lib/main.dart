import 'package:spry/spry.dart';
import 'package:spry_interceptor/spry_interceptor.dart';
import 'package:spry_json/spry_json.dart';

import 'api.dart';
import 'prisma_inject.dart';

Future<void> main() async {
  final Spry spry = Spry();
  final SpryJson json = SpryJson();

  // Spry Interceptor.
  spry.use(Interceptor(
    handler: ExceptionHandler.json(),
  ));

  // Inject Prisma client and set json middleware.
  spry.use(prisma);
  spry.use(json);

  // Run the server.
  await spry.listen(api, port: 3000);
  print('Server running on http://localhost:3000');
}
