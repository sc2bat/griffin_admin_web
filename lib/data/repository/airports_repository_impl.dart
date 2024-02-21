import 'dart:convert';

import 'package:admin_web_app/data/model/airports_model.dart';
import 'package:admin_web_app/domain/repository/airports_repository.dart';
import 'package:admin_web_app/env/env.dart';

import '../data_source/http.dart';

class AirportsRepositoryImpl implements AirportsRepository {
  @override
  Future<List<AirportsModel>> getAirportsList() async {
    final response = await fetchHttp(Env.mockAirportUrl);
    final List<dynamic> json = jsonDecode(response.body);
    return json.map((e) => AirportsModel.fromJson(e)).toList();
  }
}
