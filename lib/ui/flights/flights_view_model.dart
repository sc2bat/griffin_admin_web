import 'dart:async';

import 'package:admin_web_app/data/model/account/account_model.dart';
import 'package:admin_web_app/data/model/flights/flights_model.dart';
import 'package:admin_web_app/domain/repository/airports_repository.dart';
import 'package:admin_web_app/domain/repository/flights_repository.dart';
import 'package:admin_web_app/domain/repository/session_repository.dart';
import 'package:admin_web_app/domain/repository/sign_repository.dart';
import 'package:admin_web_app/ui/common/constants.dart';
import 'package:admin_web_app/ui/common/enums.dart';
import 'package:admin_web_app/ui/flights/flights_state.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter/material.dart';

class FlightsViewModel extends ChangeNotifier {
  final FlightsRepository _flightRepository;
  final AirportsRepository _airportsRepository;
  final SignRepository _signRepository;
  final SessionRepository _sessionRepository;

  FlightsViewModel({
    required FlightsRepository flightRepository,
    required AirportsRepository airportsRepository,
    required SignRepository signRepository,
    required SessionRepository sessionRepository,
  })  : _flightRepository = flightRepository,
        _airportsRepository = airportsRepository,
        _signRepository = signRepository,
        _sessionRepository = sessionRepository;

  FlightsState _state = const FlightsState();

  FlightsState get state => _state;

  final StreamController<SignStatus> _signStatus = StreamController();

  Stream<SignStatus> get signResult => _signStatus.stream;

  Future<void> init() async {
    // _updateLoading(true);

    await checkSession();

    // _updateLoading(false);
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
    _state = state.copyWith(isLoading: true);
    notifyListeners();

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
    _state = state.copyWith(
        flightInfo: await _flightRepository.getFlightsList(
            date:
                '${state.selectedYear}${state.selectedMonth.toString().padLeft(2, '0')}${state.selectedDay.toString().padLeft(2, '0')}',
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            departureLoc: departureLoc,
            arrivalLoc: arrivalLoc));
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> resetFlightsInfo() async {
    _state = state.copyWith(selectedDepartureLoc: null);
    _state = state.copyWith(selectedArrivalLoc: null);
    init();
    notifyListeners();
  }

  Future<void> showAirportsInfo() async {
    _state = state.copyWith(
        airportsInfo: await _airportsRepository.getAirportsList());
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
    notifyListeners();
  }

  void onSort(int columnIndex, bool ascending) {
    List<FlightsModel> flightsInfo = List.from(state.flightInfo);
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

    _state = state.copyWith(flightInfo: flightsInfo);
    notifyListeners();
  }

  void onChangeDepartureLoc(String? value) {
    _state = state.copyWith(selectedDepartureLoc: value);
    notifyListeners();
  }

  void onChangeArrivalLoc(String? value) {
    _state = state.copyWith(selectedArrivalLoc: value);
    notifyListeners();
  }

  Future<void> checkSession() async {
    try {
      final AccountModel accountModel = await _sessionRepository.getSession();
      _signStatus.add(SignStatus.isSignedIn);
      _state = state.copyWith(accountModel: accountModel);
    } catch (e) {
      await _sessionRepository.deleteSession();
      logger.info(e);
      _signStatus.add(SignStatus.isNotSignedIn);
    }
  }

  // void _updateLoading(bool isLoading) {
  //   _state = state.copyWith(isLoading: isLoading);
  //   notifyListeners();
  // }

  Future<void> signOut() async {
    try {
      _state = state.copyWith(accountModel: null);
      notifyListeners();
      await _sessionRepository.deleteSession();
      await _signRepository.signOut();
      _signStatus.add(SignStatus.isNotSignedIn);
    } catch (e) {
      logger.info(e);
      _signStatus.add(SignStatus.isNotSignedIn);
    }
  }
}
