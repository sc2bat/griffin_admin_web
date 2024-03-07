import 'dart:convert';

import 'package:admin_web_app/data/dto/user_account_dto.dart';
import 'package:admin_web_app/data/mapper/user_account_mapper.dart';
import 'package:admin_web_app/data/model/account/account_model.dart';
import 'package:admin_web_app/domain/repository/sign_repository.dart';
import 'package:admin_web_app/env/env.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:http/http.dart' as http;

class SignRepositoryImpl implements SignRepository {
  @override
  Future<AccountModel> signIn(String userName, String password) async {
    String url = '${Env.adminSignUrl}/login/';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'username': userName,
          'password': password,
        },
      );

      final jsonData = jsonDecode(response.body)[0];
      final UserAccountDTO userAccountDTO = UserAccountDTO.fromJson(jsonData);
      final AccountModel accountModel =
          UserAccountMapper.fromDTO(userAccountDTO);
      return accountModel;
    } catch (e) {
      logger.info('SignRepositoryImpl signIn error => $e');
      throw Exception(e);
    }
  }

  @override
  Future<Map<String, dynamic>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
