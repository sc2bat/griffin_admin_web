import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env', useConstantCase: true)
abstract class Env {
  // ADMIN_HOST_URL
  @EnviedField()
  static const String adminHostUrl = _Env.adminHostUrl;

  // ADMIN_SIGN_URL
  @EnviedField()
  static const String adminSignUrl = _Env.adminSignUrl;

  // GRIFFIN_FLIGHT_URL
  @EnviedField()
  static const String griffinFlightUrl = _Env.griffinFlightUrl;

// MOCK_AIRPORT_URL
  @EnviedField()
  static const String mockAirportUrl = _Env.mockAirportUrl;

  // MOCK_BOOK_URL
  @EnviedField()
  static const String mockBookUrl = _Env.mockBookUrl;

  // SAMPLE_ADMIN_ACCOUNT_INFO
  @EnviedField()
  static const String sampleAccountUserid = _Env.sampleAccountUserid;
  @EnviedField()
  static const String sampleAccountUsername = _Env.sampleAccountUsername;
  @EnviedField()
  static const String sampleAccountEmail = _Env.sampleAccountEmail;
  @EnviedField()
  static const String sampleAccountPassword = _Env.sampleAccountPassword;
}
