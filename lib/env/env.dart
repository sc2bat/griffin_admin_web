import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env', useConstantCase: true)
abstract class Env {
  // ADMIN_HOST_URL
  @EnviedField()
  static const String adminHostUrl = _Env.adminHostUrl;

// MOCK_AIRPORT_URL
  @EnviedField()
  static const String mockAirportUrl = _Env.mockAirportUrl;

  // MOCK_BOOK_URL
  @EnviedField()
  static const String mockBookUrl = _Env.mockBookUrl;
}
