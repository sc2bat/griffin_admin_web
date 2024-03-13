import 'package:admin_web_app/data/dto/users_dto.dart';
import 'package:admin_web_app/data/model/user/user_model.dart';

abstract interface class UserRepository {
  Future<List<UserModel>> getUserList(UserDTO? searchOptionUserDTO);
}
