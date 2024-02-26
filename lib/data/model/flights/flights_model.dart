import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'flights_model.freezed.dart';

part 'flights_model.g.dart';

@freezed
class FlightsModel with _$FlightsModel {
  const factory FlightsModel({
    @JsonKey(name: 'flight_id') required int flightId,
    @JsonKey(name: 'airplane_id') required int airplaneId,
    @JsonKey(name: 'flight_date') required String flightDate,
    @JsonKey(name: 'departure_time') required String departureTime,
    @JsonKey(name: 'arrival_time') required String arrivalTime,
    @JsonKey(name: 'departure_name') required String departureName,
    @JsonKey(name: 'arrival_name') required String arrivalName,
  }) = _FlightsModel;

  factory FlightsModel.fromJson(Map<String, Object?> json) => _$FlightsModelFromJson(json);
}