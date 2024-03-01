import 'package:admin_web_app/data/model/flights/flights_model.dart';

abstract class FlightsRepository {
  // Future<List<FlightsModel>> getFlightsList();
  Future<List<FlightsModel>> getFlightsList(
      {String? date,
      String? departureTime,
      String? arrivalTime,
      int? departureLoc,
      int? arrivalLoc});

}
