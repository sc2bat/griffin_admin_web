import 'package:admin_web_app/domain/repository/airplanes_repository.dart';
import 'package:admin_web_app/domain/repository/book_repository.dart';
import 'package:admin_web_app/ui/flights/detail/flight_detail_state.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter/material.dart';

class FlightDetailViewModel extends ChangeNotifier {
  final AirplanesRepository _airplanesRepository;
  final BookRepository _bookRepository;

  FlightDetailViewModel({
    required AirplanesRepository airplanesRepository,
    required BookRepository bookRepository,
  })  : _airplanesRepository = airplanesRepository,
        _bookRepository = bookRepository;

  FlightDetailState _state = const FlightDetailState();

  FlightDetailState get state => _state;

  Future<void> init() async {
    await getAirplanesList();
    await getClassSeats();
  }

  Future<void> getAirplanesList() async {
    Map<String, dynamic> jsonData = {
      'flight_date': null,
    };
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    _state = state.copyWith(
        airplanesList: await _airplanesRepository.getAirplanesList(),
        bookList: await _bookRepository.getBookList(jsonData),
        isLoading: false);
    notifyListeners();
  }

  void getRemainSeats(int a, int b, int c, String seat) {
    int index1 = 0;
    int index2 = (int.parse(seat.substring(1)) - 1) * 6;
    switch (seat[0]) {
      case 'a':
        index1 = 0;
        break;
      case 'b':
        index1 = 1;
        break;
      case 'c':
        index1 = 2;
        break;
      case 'd':
        index1 = 3;
        break;
      case 'e':
        index1 = 4;
        break;
      case 'f':
        index1 = 5;
        break;
    }
    int index = index1 + index2;
    if (index <= a - 1) {
      state.firstClass.add(seat);
    } else if (index >= a && index <= (a + b - 1)) {
      state.businessClass.add(seat);
    } else {
      state.economyClass.add(seat);
    }
    notifyListeners();
  }

  Future<void> getClassSeats() async {
    _state = state.copyWith(
        classSeats: state.bookList.map((e) => e.classSeat).toList());
    notifyListeners();
  }
}
