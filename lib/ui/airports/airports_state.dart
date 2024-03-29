import 'package:admin_web_app/data/model/account/account_model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/airports/airports_model.dart';

part 'airports_state.freezed.dart';
part 'airports_state.g.dart';

@freezed
class AirportsState with _$AirportsState {
  const factory AirportsState({
    @Default(true) bool sort,
    @Default(0) int sortColumnIndex,
    @Default([]) List<String> filterOptionList,
    @Default('공항명') String selectedFilterOption,
    @Default([]) List<AirportsModel> filteredData,
    @Default([]) List<AirportsModel> airportInfo,
    @Default(false) bool isLoading,
    AccountModel? accountModel,
  }) = _AirportsState;

  factory AirportsState.fromJson(Map<String, Object?> json) =>
      _$AirportsStateFromJson(json);
}
