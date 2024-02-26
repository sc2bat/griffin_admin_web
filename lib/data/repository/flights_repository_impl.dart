import 'dart:convert';
import 'package:admin_web_app/data/data_source/http.dart';
import 'package:admin_web_app/data/model/flights/flights_model.dart';
import 'package:admin_web_app/domain/repository/flights_repository.dart';
import 'package:admin_web_app/env/env.dart';

class FlightsRepositoryImpl extends FlightsRepository {
  @override
  Future<List<FlightsModel>> getFlightsList() async {
    final response = await fetchHttp(Env.mockFlightsUrl);
    final List<dynamic> json = jsonDecode(response.body);
    return json.map((e) => FlightsModel.fromJson(e)).toList();
  }
}

