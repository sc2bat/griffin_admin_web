import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../data/model/airports/airports_model.dart';

part 'airports_state.freezed.dart';

part 'airports_state.g.dart';

@freezed
class AirportsState with _$AirportsState {
  const factory AirportsState({
    @Default(true) bool sort,
    @Default([]) List<AirportsModel> filteredData,
    @Default([]) List<AirportsModel> airportInfo,
    @Default(false) bool isLoading,
    int? sortColumnIndex,
  }) = _AirportsState;

  factory AirportsState.fromJson(Map<String, Object?> json) =>
      _$AirportsStateFromJson(json);
}
