import 'package:admin_web_app/data/model/account/account_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(false) bool isLoading,
    AccountModel? accountModel,
  }) = _DashboardState;
}
