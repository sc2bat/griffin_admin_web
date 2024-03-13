// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'airports_model.freezed.dart';
part 'airports_model.g.dart';

@freezed
class AirportsModel with _$AirportsModel {
  const factory AirportsModel({
    @JsonKey(name: 'airport_id') required int airportId,
    @JsonKey(name: 'airport_code') required String airportCode,
    @JsonKey(name: 'airport_name') required String airportName,
    required double latitude,
    required double longitude,
    required String country,
    @JsonKey(name: 'is_deleted') required int isDeleted,
  }) = _AirportsModel;

  factory AirportsModel.fromJson(Map<String, Object?> json) =>
      _$AirportsModelFromJson(json);
}
