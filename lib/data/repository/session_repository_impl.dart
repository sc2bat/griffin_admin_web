import 'dart:convert';

import 'package:admin_web_app/data/dto/user_account_dto.dart';
import 'package:admin_web_app/data/mapper/user_account_mapper.dart';
import 'package:admin_web_app/data/model/account/account_model.dart';
import 'package:admin_web_app/domain/repository/session_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionRepositoryImpl implements SessionRepository {
  @override
  Future<AccountModel> getSession() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? session = prefs.getString('session');
      if (session != null) {
        UserAccountDTO userAccountDTO =
            UserAccountDTO.fromJson(jsonDecode(session));
        return UserAccountMapper.fromDTO(userAccountDTO);
      } else {
        return Future.error('getSession none');
      }
    } catch (e) {
      return Future.error('getSession error => $e');
    }
  }

  @override
  Future<void> storeSession(UserAccountDTO userAccountDTO) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String session = jsonEncode(userAccountDTO.toJson());

      await prefs.setString('session', session);
      return;
    } catch (e) {
      return Future.error('storeSession error => $e');
    }
  }

  @override
  Future<void> deleteSession() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.clear();
      return;
    } catch (e) {
      return Future.error('deleteSession error => $e');
    }
  }
}
