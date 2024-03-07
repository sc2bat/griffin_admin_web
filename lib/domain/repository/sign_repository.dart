import 'package:admin_web_app/data/model/account/account_model.dart';

abstract interface class SignRepository {
  Future<AccountModel> signIn(String userName, String password);
  Future<Map<String, dynamic>> signOut();
}
