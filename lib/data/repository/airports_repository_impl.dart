import 'dart:convert';
import 'package:admin_web_app/data/data_source/http.dart';
import 'package:admin_web_app/data/model/airports/airports_model.dart';
import 'package:admin_web_app/domain/repository/airports_repository.dart';
import 'package:admin_web_app/env/env.dart';

class AirportsRepositoryImpl implements AirportsRepository {
  @override
  Future<List<AirportsModel>> getAirportsList() async {
    const url = '${Env.adminHostUrl}/airports/?';
    final response = await fetchHttp(url);
    final List<dynamic> json = jsonDecode(response.body);
    return json.map((e) => AirportsModel.fromJson(e)).toList();
  }
}
