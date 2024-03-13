// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'airplanes_model.freezed.dart';
part 'airplanes_model.g.dart';

@freezed
class AirplanesModel with _$AirplanesModel {
  const factory AirplanesModel({
    @JsonKey(name: 'airplane_id') required int airplaneId,
    @JsonKey(name: 'first_class_seat') required int firstClassSeat,
    @JsonKey(name: 'business_class_seat') required int businessClassSeat,
    @JsonKey(name: 'economy_class_seat') required int economyClassSeat,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'is_deleted') required int isDeleted,
  }) = _AirplanesModel;

  factory AirplanesModel.fromJson(Map<String, Object?> json) =>
      _$AirplanesModelFromJson(json);
}
