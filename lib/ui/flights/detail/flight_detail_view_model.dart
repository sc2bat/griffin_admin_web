import 'package:admin_web_app/data/repository/airplanes_repository_impl.dart';
import 'package:admin_web_app/ui/flights/detail/flight_detail_state.dart';
import 'package:flutter/material.dart';

class FlightDetailViewModel extends ChangeNotifier {
  final airplanesRepository = AirplanesRepositoryImpl();

  FlightDetailState _state = const FlightDetailState();

  FlightDetailState get state => _state;

  Future<void> init() async {
    await getAirplanesList();
  }

  Future<void> getAirplanesList() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    _state = state.copyWith(
        airplanesList: await airplanesRepository.getAirplanesList(),
        isLoading: false);
    notifyListeners();
  }
}
