import 'package:admin_web_app/data/model/flights/flights_model.dart';
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

  List<String> first = [];
  List<String> businessClass = [];
  List<String> economyClass = [];

  Future<void> init(FlightsModel flightsModel) async {
    await getAirplanesList(flightsModel);
    await getClassSeats(flightsModel);

    for (int i = 0; i < state.classSeats.length; i++) {
      getRemainSeats(
          state.airplanesList
              .firstWhere((e) => e.airplaneId == flightsModel.airplaneId)
              .firstClassSeat,
          state.airplanesList
              .firstWhere((e) => e.airplaneId == flightsModel.airplaneId)
              .businessClassSeat,
          state.airplanesList
              .firstWhere((e) => e.airplaneId == flightsModel.airplaneId)
              .economyClassSeat,
          state.classSeats[i]);
    }

    _state = state.copyWith(
      firstClass: first,
      businessClass: businessClass,
      economyClass: economyClass,
    );
    notifyListeners();
  }

  Future<void> getAirplanesList(FlightsModel flightsModel) async {
    Map<String, dynamic> jsonData = {
      'flight_id': flightsModel.flightId,
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
    logger.info('index ==> $index');
    if (index <= a - 1) {
      // state.firstClass.add(seat);
      first.add(seat);
    } else if (index >= a && index <= (a + b - 1)) {
      businessClass.add(seat);
    } else {
      economyClass.add(seat);
    }
  }

  Future<void> getClassSeats(FlightsModel flightsModel) async {
    final List<String> classSeats =
        // state.bookList.map((e) => e.classSeat).toList();
        state.bookList
            .where((e) => e.flightId == flightsModel.flightId)
            .map((e) => e.classSeat)
            .toList();
    _state = state.copyWith(
        classSeats: classSeats.where((element) => element != 'none').toList());
    notifyListeners();
  }
}
