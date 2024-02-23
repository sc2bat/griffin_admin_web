import 'package:admin_web_app/data/model/airports_model.dart';
import 'package:admin_web_app/data/repository/airports_repository_impl.dart';
import 'package:flutter/cupertino.dart';

class AirportsViewModel extends ChangeNotifier {
  bool sort = true;
  int? sortColumnIndex;
  List<AirportsModel> airportsInfo = [];
  List<AirportsModel> filteredData = [];

  final repository = AirportsRepositoryImpl();

  void onChanged(value) {
    airportsInfo = filteredData
        .where((element) => element.airportName.contains(value))
        .toList();
    notifyListeners();
  }

  Future<void> showAirportsInfo() async {
    airportsInfo = await repository.getAirportsList();
    filteredData = airportsInfo;
    notifyListeners();
  }

  void onSort(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    sort = ascending;
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
