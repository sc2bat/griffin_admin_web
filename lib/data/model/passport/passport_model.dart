// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'passport_model.freezed.dart';
part 'passport_model.g.dart';

@freezed
class PassportModel with _$PassportModel {
  const factory PassportModel({
    @JsonKey(name: 'passport_id') required int passportId,
    required int gender,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String email,
    required String phone,
    required String birthday,
    @JsonKey(name: 'book_id') required int bookId,
    @JsonKey(name: 'created_at') required int createdAt,
    @JsonKey(name: 'is_deleted') required String isDeleted,
  }) = _PassportModel;

  factory PassportModel.fromJson(Map<String, Object?> json) =>
      _$PassportModelFromJson(json);
}
