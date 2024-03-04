import 'package:admin_web_app/data/model/flights/flights_model.dart';
import 'package:admin_web_app/data/repository/airports_repository_impl.dart';
import 'package:admin_web_app/data/repository/flights_repository_impl.dart';
import 'package:admin_web_app/ui/flights/flights_state.dart';
import 'package:flutter/material.dart';

class FlightsViewModel extends ChangeNotifier {
  FlightsState _state = const FlightsState();

  FlightsState get state => _state;

  final flightRepository = FlightsRepositoryImpl();
  final airportsRepository = AirportsRepositoryImpl();

  List<FlightsModel> flightsInfo = [];

  Future<void> showFlightsInfo(
      {String? date,
      String? departureTime,
      String? arrivalTime,
      int? departureLoc,
      int? arrivalLoc}) async {
    flightsInfo = await flightRepository.getFlightsList(
        date: date,
        departureTime: departureTime,
        arrivalTime: arrivalTime,
        departureLoc: departureLoc,
        arrivalLoc: arrivalLoc);
    notifyListeners();
  }

  Future<void> showAirportsInfo() async {
    _state = state.copyWith(
        airportsInfo: await airportsRepository.getAirportsList());
    notifyListeners();
  }

  void onSort(int columnIndex, bool ascending) {
    _state = state.copyWith(sortColumnIndex: columnIndex);
    _state = state.copyWith(sort: ascending);
    notifyListeners();

    switch (columnIndex) {
      case 2:
        {
          if (ascending) {
            flightsInfo.sort((a, b) => a.flightDate.compareTo(b.flightDate));
          } else {
            flightsInfo.sort((a, b) => b.flightDate.compareTo(a.flightDate));
          }
        }
        break;
      case 3:
        {
          if (ascending) {
            flightsInfo
                .sort((a, b) => a.departureTime.compareTo(b.departureTime));
          } else {
            flightsInfo
                .sort((a, b) => b.departureTime.compareTo(a.departureTime));
          }
        }
        break;
      case 4:
        {
          if (ascending) {
            flightsInfo.sort((a, b) => a.arrivalTime.compareTo(b.arrivalTime));
          } else {
            flightsInfo.sort((a, b) => b.arrivalTime.compareTo(a.arrivalTime));
          }
        }
        break;
      default:
        break;
    }
  }
}
