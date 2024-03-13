import 'package:admin_web_app/data/dto/users_dto.dart';
import 'package:admin_web_app/data/model/user/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  factory UserState({
    @Default(false) bool isLoading,
    @Default([]) List<UserModel> userList,
    @Default([]) List<Map<String, dynamic>> userCountWeek,
    UserDTO? searchOptionUserDTO,
  }) = _UserState;
}
