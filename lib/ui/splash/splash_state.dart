import 'package:admin_web_app/data/model/account/account_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    @Default(false) bool isLoading,
    AccountModel? accountModel,
  }) = _SplashState;
}
