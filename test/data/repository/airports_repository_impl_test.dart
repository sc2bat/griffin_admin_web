import 'dart:convert';

import 'package:admin_web_app/data/data_source/http.dart';
import 'package:admin_web_app/data/model/airports/airports_model.dart';
import 'package:admin_web_app/env/env.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AirportsRepositoryImpl getAirportsList test', () async {
    const url = '${Env.adminHostUrl}/airports/?';

    logger.info(url);

    final response = await fetchHttp(url);

    final List<dynamic> json = jsonDecode(response.body);

    logger.info(json[0]);

    final result = json.map((e) => AirportsModel.fromJson(e)).toList();

    logger.info(result[0]);
  });
}