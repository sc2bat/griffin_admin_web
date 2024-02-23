import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../data/model/airports_model.dart';

part 'airports_state.freezed.dart';

part 'airports_state.g.dart';

@freezed
class AirportsState with _$AirportsState {
  const factory AirportsState({
    @Default(true) bool sort,
    int? sortColumnIndex,
    @Default([]) List<AirportsModel> filteredData,
  }) = _AirportsState;

  factory AirportsState.fromJson(Map<String, Object?> json) =>
      _$AirportsStateFromJson(json);
}
