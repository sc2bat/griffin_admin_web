import 'package:admin_web_app/data/repository/book_repository_impl.dart';
import 'package:admin_web_app/data/repository/user_repository_impl.dart';
import 'package:admin_web_app/domain/repository/book_repository.dart';
import 'package:admin_web_app/domain/repository/user_repository.dart';
import 'package:admin_web_app/ui/book/book_view_model.dart';
import 'package:admin_web_app/ui/user/user_view_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt
    ..registerSingleton<UserRepository>(
      UserRepositoryImpl(),
    )
    ..registerSingleton<BookRepository>(
      BookRepositoryImpl(),
    );

  getIt
    ..registerFactory<UserViewModel>(
      () => UserViewModel(userRepository: getIt<UserRepository>()),
    )
    ..registerFactory<BookViewModel>(
      () => BookViewModel(bookRepository: getIt<BookRepository>()),
    );
}
