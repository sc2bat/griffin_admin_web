import 'package:admin_web_app/data/model/account/account_model.dart';
import 'package:admin_web_app/data/model/airports/airports_model.dart';
import 'package:admin_web_app/data/model/flights/flights_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'flights_state.freezed.dart';

part 'flights_state.g.dart';

@freezed
class FlightsState with _$FlightsState {
  const factory FlightsState({
    @Default([]) List<AirportsModel> airportsInfo,
    @Default([]) List<FlightsModel> flightInfo,
    @Default(true) bool sort,
    @Default(true) bool isLoading,
    @Default([]) List<int> flightOptionYear,
    @Default([]) List<int> flightOptionMonth,
    @Default([]) List<int> flightOptionDay,
    @Default(2024) int selectedYear,
    @Default(1) int selectedMonth,
    @Default(1) int selectedDay,
    @Default([]) List<String> airportsName,
    String? selectedDepartureLoc,
    String? selectedArrivalLoc,
    int? sortColumnIndex,
    AccountModel? accountModel,
  }) = _FlightsState;

  factory FlightsState.fromJson(Map<String, Object?> json) =>
      _$FlightsStateFromJson(json);
}
