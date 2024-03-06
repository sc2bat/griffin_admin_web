import 'package:admin_web_app/data/model/flights/flights_model.dart';
import 'package:admin_web_app/data/repository/airports_repository_impl.dart';
import 'package:admin_web_app/data/repository/flights_repository_impl.dart';
import 'package:admin_web_app/ui/common/constants.dart';
import 'package:admin_web_app/ui/flights/flights_state.dart';
import 'package:flutter/material.dart';

class FlightsViewModel extends ChangeNotifier {
  FlightsState _state = const FlightsState();

  FlightsState get state => _state;

  final flightRepository = FlightsRepositoryImpl();
  final airportsRepository = AirportsRepositoryImpl();

  List<FlightsModel> flightsInfo = [];

  Future<void> init() async {
    // 오늘 날짜 설정
    initSelectDateOption();
    // 날짜 선택 옵션
    updateSelectDayOption();
    // 예약 데이터 불러오기

    await showAirportsInfo();
    await showFlightsInfo();
    await getAirportsName();
  }

  Future<void> showFlightsInfo(
      {String? date,
      String? departureTime,
      String? arrivalTime,
      int? departureLoc,
      int? arrivalLoc}) async {
    if (state.selectedDepartureLoc != null) {
      departureLoc = state.airportsInfo
          .firstWhere((e) => e.airportName == state.selectedDepartureLoc)
          .airportId;
    }
    if (state.selectedArrivalLoc != null) {
      arrivalLoc = state.airportsInfo
          .firstWhere((e) => e.airportName == state.selectedArrivalLoc)
          .airportId;
    }
    flightsInfo = await flightRepository.getFlightsList(
        date:
            '${state.selectedYear}${state.selectedMonth.toString().padLeft(2, '0')}${state.selectedDay.toString().padLeft(2, '0')}',
        departureTime: departureTime,
        arrivalTime: arrivalTime,
        departureLoc: departureLoc ,
        arrivalLoc: arrivalLoc);
    notifyListeners();
  }

  Future<void> showAirportsInfo() async {
    _state = state.copyWith(
        airportsInfo: await airportsRepository.getAirportsList());
    notifyListeners();
  }

  void initSelectDateOption() {
    DateTime dateTime = DateTime.now();
    _state = state.copyWith(
      selectedYear: dateTime.year,
      selectedMonth: dateTime.month,
      selectedDay: dateTime.day,
    );
    notifyListeners();
  }

  void updateSelectDayOption() {
    int daysInMonth =
        DateTime(state.selectedYear, state.selectedMonth + 1, 0).day;
    List<int> calcDayList = List.generate(daysInMonth, (index) => index + 1);
    if (state.selectedDay > calcDayList.last) {
      _state = state.copyWith(selectedDay: calcDayList.last);
    }
    _state = state.copyWith(
        flightOptionYear: dateFixedYearList,
        flightOptionMonth: dateFixedMonthList,
        flightOptionDay: calcDayList);
    notifyListeners();
  }

  void selectYear(int year) {
    _state = state.copyWith(selectedYear: year);
    notifyListeners();
    updateSelectDayOption();
  }

  void selectMonth(int month) {
    _state = state.copyWith(selectedMonth: month);
    notifyListeners();
    updateSelectDayOption();
  }

  void selectDay(int day) {
    _state = state.copyWith(selectedDay: day);
    notifyListeners();
    updateSelectDayOption();
  }

  Future<void> getAirportsName() async {
    _state = state.copyWith(
        airportsName:
            state.airportsInfo.map((e) => e.airportName).toSet().toList());
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

  void onChangeDepartureLoc(String? value) {
    _state = state.copyWith(selectedDepartureLoc: value);
    notifyListeners();
  }

  void onChangeArrivalLoc(String? value) {
    _state = state.copyWith(selectedArrivalLoc: value);
    notifyListeners();
  }
}
