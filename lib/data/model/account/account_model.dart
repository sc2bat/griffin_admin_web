// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
class AccountModel with _$AccountModel {
  const factory AccountModel({
    required int userId,
    required String userName,
    required String email,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, Object?> json) =>
      _$AccountModelFromJson(json);
}
