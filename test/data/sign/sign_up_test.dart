import 'package:admin_web_app/env/env.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('sign up test', () async {
    logger.info('sign up test ');

    const url = '${Env.adminSignUrl}/signup/';
    final formData = {
      'email': 'test001@naver.com',
      'username': 'test001',
      'password1': 'dqB1hFMLzz9he87PBQH2',
      'password2': 'dqB1hFMLzz9he87PBQH2',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: formData,
      );
      logger.info('${response.statusCode}');
      logger.info(response.body);
    } catch (e) {
      logger.info('$e');
    }
  });
  test('login test', () async {
    logger.info('login test ');

    // const url = '${Env.adminSignUrl}/login/';
    const url = '${Env.adminSignUrl}/login/';
    final formData = {
      'username': 'test001',
      'password': 'dqB1hFMLzz9he87PBQH2',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: formData,
      );
      logger.info('${response.statusCode}');
      logger.info(response.body);
    } catch (e) {
      logger.info('$e');
    }
  });
}
