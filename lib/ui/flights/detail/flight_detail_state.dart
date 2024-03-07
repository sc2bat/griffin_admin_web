import 'package:admin_web_app/data/model/flights/flights_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'flight_detail_state.freezed.dart';

part 'flight_detail_state.g.dart';

@freezed
class FlightDetailState with _$FlightDetailState {
  const factory FlightDetailState({
    @Default(false) bool isLoading,
    FlightsModel? flightsModel,
  }) = _FlightDetailState;

  factory FlightDetailState.fromJson(Map<String, Object?> json) => _$FlightDetailStateFromJson(json);
}