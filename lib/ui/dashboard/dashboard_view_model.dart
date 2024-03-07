import 'dart:async';

import 'package:admin_web_app/data/model/account/account_model.dart';
import 'package:admin_web_app/domain/repository/session_repository.dart';
import 'package:admin_web_app/domain/repository/sign_repository.dart';
import 'package:admin_web_app/ui/common/enums.dart';
import 'package:admin_web_app/ui/dashboard/dashboard_state.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter/material.dart';

class DashboardViewModel with ChangeNotifier {
  DashboardViewModel({
    required SignRepository signRepository,
    required SessionRepository sessionRepository,
  })  : _signRepository = signRepository,
        _sessionRepository = sessionRepository;
  final SignRepository _signRepository;
  final SessionRepository _sessionRepository;

  final StreamController<SignStatus> _signStatus = StreamController();
  Stream<SignStatus> get signResult => _signStatus.stream;

  DashboardState _dashboardState = const DashboardState();
  DashboardState get dashboardState => _dashboardState;

  Future<void> init() async {
    _updateLoading(true);

    await checkSession();

    _updateLoading(false);
  }

  Future<void> checkSession() async {
    try {
      final AccountModel accountModel = await _sessionRepository.getSession();
      _signStatus.add(SignStatus.isSignedIn);
      _dashboardState = dashboardState.copyWith(accountModel: accountModel);
    } catch (e) {
      await _sessionRepository.deleteSession();
      logger.info(e);
      _signStatus.add(SignStatus.isNotSignedIn);
    }
  }

  void _updateLoading(bool isLoading) {
    _dashboardState = dashboardState.copyWith(isLoading: isLoading);
    notifyListeners();
  }

  Future<void> signOut() async {
    try {
      _dashboardState = dashboardState.copyWith(accountModel: null);
      notifyListeners();
      await _sessionRepository.deleteSession();
      await _signRepository.signOut();
      _signStatus.add(SignStatus.isNotSignedIn);
    } catch (e) {
      logger.info(e);
      _signStatus.add(SignStatus.isNotSignedIn);
    }
  }
}
