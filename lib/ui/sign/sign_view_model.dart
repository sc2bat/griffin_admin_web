import 'package:admin_web_app/domain/repository/session_repository.dart';
import 'package:admin_web_app/domain/repository/sign_repository.dart';
import 'package:flutter/material.dart';

class SignViewModel with ChangeNotifier {
  SignViewModel({
    required SignRepository signRepository,
    required SessionRepository sessionRepository,
  })  : _signRepository = signRepository,
        _sessionRepository = sessionRepository;
  final SignRepository _signRepository;
  final SessionRepository _sessionRepository;
}
