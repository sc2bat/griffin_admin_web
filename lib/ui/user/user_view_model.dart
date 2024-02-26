import 'package:admin_web_app/data/model/user_model.dart';
import 'package:admin_web_app/domain/repository/user_repository.dart';
import 'package:admin_web_app/ui/user/user_state.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  UserViewModel({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  UserState _state = UserState();

  UserState get state => _state;

  List<UserModel> userList = [];

  Future<void> getUserList() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    userList = await _userRepository.getUserList();

    _state = state.copyWith(isLoading: false, userList: userList);
    notifyListeners();
  }
}
