import 'package:admin_web_app/data/model/airports/airports_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'flights_state.freezed.dart';

part 'flights_state.g.dart';

@freezed
class FlightsState with _$FlightsState {
  const factory FlightsState({
    @Default([]) List<AirportsModel> airportsInfo,
    @Default(true) bool sort,
    int? sortColumnIndex,
  }) = _FlightsState;

  factory FlightsState.fromJson(Map<String, Object?> json) =>
      _$FlightsStateFromJson(json);
}
