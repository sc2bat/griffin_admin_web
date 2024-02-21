import 'package:admin_web_app/data/repository/user_repository_impl.dart';
import 'package:admin_web_app/domain/repository/user_repository.dart';
import 'package:admin_web_app/ui/user/user_view_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<UserRepository>(
    UserRepositoryImpl(),
  );

  getIt.registerFactory<UserViewModel>(
    () => UserViewModel(userRepository: getIt<UserRepository>()),
  );
}
