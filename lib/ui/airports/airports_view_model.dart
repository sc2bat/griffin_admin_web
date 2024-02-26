import 'package:admin_web_app/data/model/airports/airports_model.dart';
import 'package:admin_web_app/data/repository/airports_repository_impl.dart';
import 'package:admin_web_app/ui/airports/airports_state.dart';
import 'package:flutter/cupertino.dart';

class AirportsViewModel extends ChangeNotifier {
  AirportsState _state = const AirportsState();

  AirportsState get state => _state;

  List<AirportsModel> airportsInfo = [];

  final repository = AirportsRepositoryImpl();

  Future<void> showAirportsInfo() async {
    airportsInfo = await repository.getAirportsList();
    _state = state.copyWith(filteredData: airportsInfo);
    notifyListeners();
  }

  void onChanged(value) {
    airportsInfo = state.filteredData
        .where((element) => element.airportName.contains(value))
        .toList();
    notifyListeners();
  }

  void onSort(int columnIndex, bool ascending) {
    _state = state.copyWith(sortColumnIndex: columnIndex);
    _state = state.copyWith(sort: ascending);
    notifyListeners();

    switch (columnIndex) {
      case 0:
        {
          if (ascending) {
            airportsInfo.sort((a, b) => a.airportId.compareTo(b.airportId));
          } else {
            airportsInfo.sort((a, b) => b.airportId.compareTo(a.airportId));
          }
        }
        break;
      case 1:
        {
          if (ascending) {
            airportsInfo.sort((a, b) => a.airportCode.compareTo(b.airportCode));
          } else {
            airportsInfo.sort((a, b) => b.airportCode.compareTo(a.airportCode));
          }
        }
        break;
      case 2:
        {
          if (ascending) {
            airportsInfo.sort((a, b) => a.airportName.compareTo(b.airportName));
          } else {
            airportsInfo.sort((a, b) => b.airportName.compareTo(a.airportName));
          }
        }
        break;
      case 3:
        {
          if (ascending) {
            airportsInfo.sort((a, b) => a.latitude.compareTo(b.latitude));
          } else {
            airportsInfo.sort((a, b) => b.latitude.compareTo(a.latitude));
          }
        }
        break;
      case 4:
        {
          if (ascending) {
            airportsInfo.sort((a, b) => a.longitude.compareTo(b.longitude));
          } else {
            airportsInfo.sort((a, b) => b.longitude.compareTo(a.longitude));
          }
        }
        break;
      case 5:
        {
          if (ascending) {
            airportsInfo.sort((a, b) => a.country.compareTo(b.country));
          } else {
            airportsInfo.sort((a, b) => b.country.compareTo(a.country));
          }
        }
        break;
      default:
        break;
    }
  }
}
