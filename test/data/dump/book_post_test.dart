import 'dart:convert';

import 'package:admin_web_app/env/env.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('book post testing', () async {
    logger.info('qwerasdf');

    String url = 'http://${Env.griffinFlightUrl}/books/';

    Map<String, dynamic> data = {
      "user_id": 7,
      "flight_id": 1,
      "class_seat": "none",
      "status": 0,
      "pay_status": 0,
      "pay_amount": 0.0
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        logger.info(response.body);
      } else if (response.statusCode == 201) {
        logger.info(response.body);
      } else {
        logger.info('${response.statusCode}');
      }
    } catch (e) {
      logger.info('error => $e');
    }
  });
}
