import 'package:spry_router/spry_router.dart';

import 'handlers.dart';

Router _createRouter() {
  final Router router = Router();

  router.get('/users', getAllUsers);
  router.post('/users', createUser);
  router.get('/users/:id', getUser);
  router.put('/users/:id', updateUser);
  router.delete('/users/:id', deleteUser);

  return router;
}

final Router api = _createRouter();
