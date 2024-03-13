// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'passport_model.freezed.dart';
part 'passport_model.g.dart';

@freezed
class PassportModel with _$PassportModel {
  const factory PassportModel({
    required int passportId,
    required int gender,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String birthday,
    required int bookId,
    required DateTime createdAt,
    required int isDeleted,
  }) = _PassportModel;

  factory PassportModel.fromJson(Map<String, Object?> json) =>
      _$PassportModelFromJson(json);
}
