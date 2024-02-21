import 'package:admin_web_app/data/model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  factory UserState({
    @Default(false) bool isLoading,
    @Default([]) List<UserModel> userList,
  }) = _UserState;
}
