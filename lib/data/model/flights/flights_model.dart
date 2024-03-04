// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'flights_model.freezed.dart';
part 'flights_model.g.dart';

@freezed
class FlightsModel with _$FlightsModel {
  const factory FlightsModel({
    @JsonKey(name: 'flight_id') required int flightId,
    @JsonKey(name: 'airplane_id') required int airplaneId,
    @JsonKey(name: 'departure_time') required String departureTime,
    @JsonKey(name: 'arrival_time') required String arrivalTime,
    @JsonKey(name: 'departure_loc') required int departureLoc,
    @JsonKey(name: 'arrival_loc') required int arrivalLoc,
    @JsonKey(name: 'is_deleted') required int isDeleted,
  }) = _FlightsModel;

  factory FlightsModel.fromJson(Map<String, Object?> json) =>
      _$FlightsModelFromJson(json);
}
