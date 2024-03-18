import 'package:admin_web_app/data/repository/airplanes_repository_impl.dart';
import 'package:admin_web_app/data/repository/airports_repository_impl.dart';
import 'package:admin_web_app/data/repository/book_repository_impl.dart';
import 'package:admin_web_app/data/repository/flights_repository_impl.dart';
import 'package:admin_web_app/data/repository/passport_repository_impl.dart';
import 'package:admin_web_app/data/repository/session_repository_impl.dart';
import 'package:admin_web_app/data/repository/sign_repository_impl.dart';
import 'package:admin_web_app/data/repository/user_repository_impl.dart';
import 'package:admin_web_app/domain/repository/airplanes_repository.dart';
import 'package:admin_web_app/domain/repository/airports_repository.dart';
import 'package:admin_web_app/domain/repository/book_repository.dart';
import 'package:admin_web_app/domain/repository/flights_repository.dart';
import 'package:admin_web_app/domain/repository/passport_repository.dart';
import 'package:admin_web_app/domain/repository/session_repository.dart';
import 'package:admin_web_app/domain/repository/sign_repository.dart';
import 'package:admin_web_app/domain/repository/user_repository.dart';
import 'package:admin_web_app/ui/airports/airports_view_model.dart';
import 'package:admin_web_app/ui/book/book_view_model.dart';
import 'package:admin_web_app/ui/book/detail/book_detail_view_model.dart';
import 'package:admin_web_app/ui/dashboard/dashboard_view_model.dart';
import 'package:admin_web_app/ui/flights/detail/flight_detail_view_model.dart';
import 'package:admin_web_app/ui/flights/flights_view_model.dart';
import 'package:admin_web_app/ui/sign/sign_view_model.dart';
import 'package:admin_web_app/ui/splash/splash_view_model.dart';
import 'package:admin_web_app/ui/user/user_view_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt
    ..registerSingleton<SignRepository>(
      SignRepositoryImpl(),
    )
    ..registerSingleton<SessionRepository>(
      SessionRepositoryImpl(),
    )
    ..registerSingleton<UserRepository>(
      UserRepositoryImpl(),
    )
    ..registerSingleton<BookRepository>(
      BookRepositoryImpl(),
    )
    ..registerSingleton<PassportRepository>(
      PassportRepositoryImpl(),
    )
    ..registerSingleton<AirportsRepository>(
      AirportsRepositoryImpl(),
    )
    ..registerSingleton<FlightsRepository>(
      FlightsRepositoryImpl(),
    )
    ..registerSingleton<AirplanesRepository>(
      AirplanesRepositoryImpl(),
    );

  getIt
    ..registerFactory<SignViewModel>(
      () => SignViewModel(
        signRepository: getIt<SignRepository>(),
        sessionRepository: getIt<SessionRepository>(),
      ),
    )
    ..registerFactory<SplashViewModel>(
      () => SplashViewModel(
        sessionRepository: getIt<SessionRepository>(),
      ),
    )
    ..registerFactory<DashboardViewModel>(
      () => DashboardViewModel(
        signRepository: getIt<SignRepository>(),
        sessionRepository: getIt<SessionRepository>(),
        bookRepository: getIt<BookRepository>(),
      ),
    )
    ..registerFactory<UserViewModel>(
      () => UserViewModel(
        userRepository: getIt<UserRepository>(),
      ),
    )
    ..registerFactory<BookViewModel>(
      () => BookViewModel(
        bookRepository: getIt<BookRepository>(),
        signRepository: getIt<SignRepository>(),
        sessionRepository: getIt<SessionRepository>(),
      ),
    )
    ..registerFactory<BookDetailViewModel>(
      () => BookDetailViewModel(
        bookRepository: getIt<BookRepository>(),
        passportRepository: getIt<PassportRepository>(),
      ),
    )
    ..registerFactory<AirportsViewModel>(
      () => AirportsViewModel(
        airportsRepository: getIt<AirportsRepository>(),
        signRepository: getIt<SignRepository>(),
        sessionRepository: getIt<SessionRepository>(),
      ),
    )
    ..registerFactory<FlightsViewModel>(
      () => FlightsViewModel(
        flightRepository: getIt<FlightsRepository>(),
        airportsRepository: getIt<AirportsRepository>(),
        signRepository: getIt<SignRepository>(),
        sessionRepository: getIt<SessionRepository>(),
      ),
    )
    ..registerFactory<FlightDetailViewModel>(
      () => FlightDetailViewModel(
        airplanesRepository: getIt<AirplanesRepository>(),
        bookRepository: getIt<BookRepository>(),
      ),
    );
}
