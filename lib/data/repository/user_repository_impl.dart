import 'dart:convert';

import 'package:admin_web_app/data/dto/users_dto.dart';
import 'package:admin_web_app/data/http.dart';
import 'package:admin_web_app/data/model/user/user_model.dart';
import 'package:admin_web_app/domain/repository/user_repository.dart';
import 'package:admin_web_app/env/env.dart';
import 'package:admin_web_app/utils/simple_logger.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<List<UserModel>> getUserList(UserDTO? searchOptionUserDTO) async {
    try {
      final paramData = searchOptionUserDTO?.toJson();

      logger.info('paramData $paramData');

      final response = await fetchHttpWithParam(
        url: '${Env.adminHostUrl}/users/',
        paramData: paramData ?? {},
      );

      final List<dynamic> json = jsonDecode(response.body);

      return json.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('getUserList Exception $e');
    }
  }
}
