import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env', useConstantCase: true)
abstract class Env {
  // ADMIN_HOST_URL
  @EnviedField()
  static const String adminHostUrl = _Env.adminHostUrl;

  // GRIFFIN_FLIGHT_URL
  @EnviedField()
  static const String griffinFlightUrl = _Env.griffinFlightUrl;

// MOCK_AIRPORT_URL
  @EnviedField()
  static const String mockAirportUrl = _Env.mockAirportUrl;

  // MOCK_BOOK_URL
  @EnviedField()
  static const String mockBookUrl = _Env.mockBookUrl;

  @EnviedField()
  static const String mockFlightsUrl = _Env.mockFlightsUrl;
}


