import 'dart:convert';
import 'package:admin_web_app/data/data_source/http.dart';
import 'package:admin_web_app/data/model/flights/flights_model.dart';
import 'package:admin_web_app/domain/repository/flights_repository.dart';
import 'package:admin_web_app/env/env.dart';

// class FlightsRepositoryImpl implements FlightsRepository {
//   @override
//   Future<List<FlightsModel>> getFlightsList() async {
//     const url = '${Env.adminHostUrl}/flights/?';
//     final response = await fetchHttp(url);
//     final List<dynamic> json = jsonDecode(response.body);
//     return json.map((e) => FlightsModel.fromJson(e)).toList();
//   }
// }

class FlightsRepositoryImpl extends FlightsRepository {
  @override
  Future<List<FlightsModel>> getFlightsList(
      {String? date,
      String? departureTime,
      String? arrivalTime,
      int? departureLoc,
      int? arrivalLoc}) async {
    Map<String, dynamic> jsonData = {
      'departure_date': date,
      'departure_time': departureTime,
      'arrival_time': arrivalTime,
      'departure_loc': departureLoc,
      'arrival_loc': arrivalLoc
    };
    final jsonResult =
        jsonData.map((key, value) => MapEntry(key, value.toString()));
    String url = 'http://${Env.griffinFlightUrl}/flights/';
    Uri uri = Uri.parse(url);
    final urlWithQuery = uri.replace(queryParameters: jsonResult).toString();
    final response = await fetchHttp(urlWithQuery);
    final List<dynamic> json = jsonDecode(response.body);
    return json.map((e) => FlightsModel.fromJson(e)).toList();
  }
}
