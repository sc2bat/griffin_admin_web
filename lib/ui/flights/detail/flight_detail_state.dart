import 'package:admin_web_app/data/model/airplanes/airplanes_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'flight_detail_state.freezed.dart';

part 'flight_detail_state.g.dart';

@freezed
class FlightDetailState with _$FlightDetailState {
  const factory FlightDetailState({
    @Default(true) bool isLoading,
    @Default([]) List<AirplanesModel> airplanesList,
  }) = _FlightDetailState;

  factory FlightDetailState.fromJson(Map<String, Object?> json) => _$FlightDetailStateFromJson(json);
}