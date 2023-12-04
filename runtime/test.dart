import 'action.dart';
import 'args/where.dart';
import 'builder.dart';
import 'delegate.dart';
import 'json_convertible.dart';
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

  factory User.fromJson(Map json) {
    return User(id: json['id'] as String?);
  }
}

class UserUniqueWhereInput implements JsonConvertible<Map<String, dynamic>> {
  static Builder<String, UserUniqueWhereInput, Null> get id =>
      Builder('id', UserUniqueWhereInput._);

  const UserUniqueWhereInput._(this._where);

  final Map<String, dynamic> _where;

  @override
  Map<String, dynamic> toJson() => _where;
}

class UserFindUniqueArgs implements Where<UserUniqueWhereInput> {}

extension UserDelegate on Delegate<User> {
  Action<User?, UserFindUniqueArgs> findUnique() =>
      const Action('User', 'findUniqueUser', deserialize: User.fromJson);
}

extension PrismaClientExtension on PrismaClient {
  Delegate<User> get user => Delegate();
}

void main() {
  final client = PrismaClient();
  client.user.findUnique().where(UserUniqueWhereInput.id('1'));
}
