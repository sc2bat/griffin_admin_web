import 'package:admin_web_app/env/env.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('env testing', () {
    String adminHostUrl = Env.adminHostUrl;

    logger.info(adminHostUrl);

    logger.info(Env.mockAirportUrl);
  });
}
