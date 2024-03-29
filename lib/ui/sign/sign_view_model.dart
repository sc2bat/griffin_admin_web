import 'dart:async';

import 'package:admin_web_app/data/mapper/user_account_mapper.dart';
import 'package:admin_web_app/data/model/account/account_model.dart';
import 'package:admin_web_app/domain/repository/session_repository.dart';
import 'package:admin_web_app/domain/repository/sign_repository.dart';
import 'package:admin_web_app/ui/common/enums.dart';
import 'package:admin_web_app/ui/sign/sign_state.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter/material.dart';

class SignViewModel with ChangeNotifier {
  SignViewModel({
    required SignRepository signRepository,
    required SessionRepository sessionRepository,
  })  : _signRepository = signRepository,
        _sessionRepository = sessionRepository;
  final SignRepository _signRepository;
  final SessionRepository _sessionRepository;

  SignState _signState = const SignState();
  SignState get signState => _signState;

  final StreamController<SignStatus> _signResult = StreamController();
  Stream<SignStatus> get signResult => _signResult.stream;

  void _updateLoading({required bool isLoading}) {
    _signState = signState.copyWith(isLoading: isLoading);
    notifyListeners();
  }

  Future<void> init() async {
    _updateLoading(isLoading: true);
    notifyListeners();

    try {
      // ignore: unused_local_variable
      final AccountModel accountModel = await _sessionRepository.getSession();
      _signResult.add(SignStatus.isSignedIn);
    } catch (e) {
      if (e.toString() == 'getSession none') {
        _signResult.add(SignStatus.isNotSignedIn);
      } else {
        logger.info(e);
      }
    }

    _updateLoading(isLoading: false);
  }

  Future<void> signIn(
      {required String userName, required String password}) async {
    _updateLoading(isLoading: true);
    try {
      final signInResult = await _signRepository.signIn(userName, password);
      await _sessionRepository
          .storeSession(UserAccountMapper.toDTO(signInResult));
      _signResult.add(SignStatus.signSuccess);
    } catch (e) {
      logger.info(e);
      _signResult.add(SignStatus.signFail);

      _updateLoading(isLoading: false);
    }
  }
}
