// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'airports_model.freezed.dart';
part 'airports_model.g.dart';

@freezed
class AirportsModel with _$AirportsModel {
  const factory AirportsModel({
    @JsonKey(name: 'airport_id') required String airportId,
    @JsonKey(name: 'airport_code') required String airportCode,
    @JsonKey(name: 'airport_name') required String airportName,
    @JsonKey(name: 'latitude') required String latitude,
    @JsonKey(name: 'longitude') required String longitude,
    @JsonKey(name: 'country') required String country,
  }) = _AirportsModel;

  factory AirportsModel.fromJson(Map<String, Object?> json) =>
      _$AirportsModelFromJson(json);
}
