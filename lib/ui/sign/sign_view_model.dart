import 'dart:async';

import 'package:admin_web_app/data/mapper/user_account_mapper.dart';
import 'package:admin_web_app/domain/repository/session_repository.dart';
import 'package:admin_web_app/domain/repository/sign_repository.dart';
import 'package:admin_web_app/ui/sign/sign_result.dart';
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

  final StreamController<SignResult> _signResult = StreamController();
  Stream<SignResult> get signResult => _signResult.stream;

  Future<void> signIn(
      {required String userName, required String password}) async {
    _signState = signState.copyWith(isLoading: true);
    notifyListeners();
    try {
      final signInResult = await _signRepository.signIn(userName, password);
      await _sessionRepository
          .storeSession(UserAccountMapper.toDTO(signInResult));
      _signResult.add(SignResult.signSuccess);
    } catch (e) {
      logger.info(e);
      _signResult.add(SignResult.signFail);
    }
    _signState = signState.copyWith(isLoading: false);
    notifyListeners();
  }
}
