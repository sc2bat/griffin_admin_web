import 'dart:async';

import 'package:admin_web_app/data/model/account/account_model.dart';
import 'package:admin_web_app/domain/repository/session_repository.dart';
import 'package:admin_web_app/ui/common/enums.dart';
import 'package:admin_web_app/ui/splash/splash_state.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter/material.dart';

class SplashViewModel with ChangeNotifier {
  SplashViewModel({
    required SessionRepository sessionRepository,
  }) : _sessionRepository = sessionRepository;
  final SessionRepository _sessionRepository;

  final StreamController<SignStatus> _signStatus = StreamController();
  Stream<SignStatus> get signResult => _signStatus.stream;

  SplashState _splashnState = const SplashState();
  SplashState get splashState => _splashnState;

  Future<void> init() async {
    _splashnState = splashState.copyWith(isLoading: true);
    notifyListeners();
    try {
      final AccountModel accountModel = await _sessionRepository.getSession();
      _signStatus.add(SignStatus.signIn);
      _splashnState =
          splashState.copyWith(isLoading: false, accountModel: accountModel);
      notifyListeners();
    } catch (e) {
      await _sessionRepository.deleteSession();
      logger.info(e);
      _signStatus.add(SignStatus.signOut);
    }
  }
}
