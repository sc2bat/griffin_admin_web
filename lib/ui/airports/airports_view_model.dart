import 'package:admin_web_app/data/model/airports/airports_model.dart';
import 'package:admin_web_app/data/repository/airports_repository_impl.dart';
import 'package:admin_web_app/ui/airports/airports_state.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
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

  void onChanged(String value) {
    airportsInfo = state.filteredData
        .where((element) =>
            element.airportName.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void filterOptionInit() {
    List<String> filterOptionList = ['공항코드', '공항명', '국가코드'];
    _state = state.copyWith(
        filterOptionList: filterOptionList,
        selectedFilterOption: filterOptionList[1]);

    notifyListeners();
  }

  void onFilterOption(String value) {
    _state = state.copyWith(selectedFilterOption: value);
    notifyListeners();
  }

  void onFilterChanged(String value) {
    logger.info('qwerasdf onFilterChanged $value');
    int selectedFilterOption =
        state.filterOptionList.indexOf(state.selectedFilterOption);
    logger.info('qwerasdf onFilterChanged $selectedFilterOption');
    switch (selectedFilterOption) {
      case 0:
        airportsInfo = state.filteredData
            .where((element) =>
                element.airportCode.toLowerCase().contains(value.toLowerCase()))
            .toList();
        break;
      case 1:
        airportsInfo = state.filteredData
            .where((element) =>
                element.airportName.toLowerCase().contains(value.toLowerCase()))
            .toList();
        break;
      case 2:
        airportsInfo = state.filteredData
            .where((element) =>
                element.country.toLowerCase().contains(value.toLowerCase()))
            .toList();
        break;
      default:
        break;
    }
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
