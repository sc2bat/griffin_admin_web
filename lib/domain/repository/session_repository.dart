import 'package:admin_web_app/data/dto/user_account_dto.dart';
import 'package:admin_web_app/data/model/account/account_model.dart';

abstract interface class SessionRepository {
  Future<AccountModel> getSession();
  Future<void> storeSession(UserAccountDTO userAccountDTO);
  Future<void> deleteSession();
}
