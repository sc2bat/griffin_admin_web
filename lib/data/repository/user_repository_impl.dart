import 'dart:convert';

import 'package:admin_web_app/data/http.dart';
import 'package:admin_web_app/data/model/user_model.dart';
import 'package:admin_web_app/domain/repository/user_repository.dart';
import 'package:admin_web_app/env/env.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<List<UserModel>> getUserList() async {
    final response = await fetchHttp('${Env.adminHostUrl}users/');
    try {
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('getUserList Exception $e');
    }
  }
}
