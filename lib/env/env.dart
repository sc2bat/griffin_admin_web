import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env', useConstantCase: true)
abstract class Env {
  // ADMIN_HOST_URL
  @EnviedField()
  static const String adminHostUrl = _Env.adminHostUrl;
}