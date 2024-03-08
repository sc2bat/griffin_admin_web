import 'package:admin_web_app/data/dto/user_account_dto.dart';
import 'package:admin_web_app/data/model/account/account_model.dart';

class UserAccountMapper {
  static AccountModel fromDTO(UserAccountDTO dto) {
    return AccountModel(
      userId: dto.userId ?? 0,
      userName: dto.userName ?? '',
      email: dto.email ?? '',
    );
  }

  static UserAccountDTO toDTO(AccountModel model) {
    return UserAccountDTO(
      userId: model.userId,
      userName: model.userName,
      email: model.email,
      createdAt: null,
      isDeleted: 0,
    );
  }
}
