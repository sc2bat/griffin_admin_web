import 'dart:convert';

import 'package:admin_web_app/env/env.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('sign out test', () async {
    String url = '${Env.adminSignUrl}/logout/';
    try {
      final response = await http.post(Uri.parse(url));

      logger.info(response.statusCode);
      logger.info(jsonDecode(response.body));
    } catch (e) {
      logger.info('SignRepositoryImpl signOut error => $e');
      throw Exception(e);
    }
  });
}
