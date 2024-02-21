// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'user_name') String? userName,
    required String email,
    required String password,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'is_deleted') int? isDeleted,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}
