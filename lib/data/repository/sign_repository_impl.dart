import 'dart:convert';

import 'package:admin_web_app/data/dto/user_account_dto.dart';
import 'package:admin_web_app/data/mapper/user_account_mapper.dart';
import 'package:admin_web_app/data/model/account/account_model.dart';
import 'package:admin_web_app/domain/repository/sign_repository.dart';
import 'package:admin_web_app/env/env.dart';
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
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)[0];
        if (!jsonData.containsKey('status')) {
          final UserAccountDTO userAccountDTO =
              UserAccountDTO.fromJson(jsonData);
          final AccountModel accountModel =
              UserAccountMapper.fromDTO(userAccountDTO);
          return accountModel;
        } else {
          return Future.error('signin failed: ${jsonData['status']}');
        }
      } else {
        return Future.error('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      return Future.error('signIn error $e');
    }
  }

  @override
  Future<Map<String, dynamic>> signOut() async {
    String url = '${Env.adminSignUrl}/logout/';
    try {
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return Future.error('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      return Future.error('signOut error $e');
    }
  }
}
