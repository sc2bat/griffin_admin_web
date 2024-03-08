import 'dart:convert';

import 'package:admin_web_app/data/data_source/http.dart';
import 'package:admin_web_app/data/model/airplanes/airplanes_model.dart';
import 'package:admin_web_app/domain/repository/airplanes_repository.dart';
import 'package:admin_web_app/env/env.dart';

class AirplanesRepositoryImpl implements AirplanesRepository {
  @override
  Future<List<AirplanesModel>> getAirplanesList() async {
    const url = '${Env.adminHostUrl}/airplanes/?';
    final response = await fetchHttp(url);
    final List<dynamic> json = jsonDecode(response.body);
    return json.map((e) => AirplanesModel.fromJson(e)).toList();
  }

}