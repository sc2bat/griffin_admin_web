import 'package:admin_web_app/data/model/user_model.dart';

abstract interface class UserRepository {
  Future<List<UserModel>> getUserList();
}
