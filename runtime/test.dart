import 'action.dart';
import 'args/where.dart';
import 'delegate.dart';
import 'model_field_refercence.dart';
import 'prisma_client.dart';

enum UserScalar<T> implements ModelFieldRefercence<T> {
  id<String>('User', 'id');

  @override
  final String model;

  @override
  final String field;

  const UserScalar(this.model, this.field);
}

class User {
  final String? id;

  const User({this.id});
}

class UserUniqueWhereInput {}

class UserFindUniqueArgs with Where<UserUniqueWhereInput> {}

extension UserDelegate on Delegate<User> {
  Action<User?, UserFindUniqueArgs> findUnique() =>
      Action('User', 'findUniqueUser');
}

extension PrismaClientExtension on PrismaClient {
  Delegate<User> get user => Delegate();
}

void main() {
  final client = PrismaClient();
  client.user.findUnique();
}
