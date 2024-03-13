import 'package:admin_web_app/domain/repository/user_repository.dart';
import 'package:admin_web_app/ui/user/user_state.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  UserViewModel({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  UserState _userState = UserState();

  UserState get userState => _userState;

  Future<void> init() async {
    _userState = userState.copyWith(isLoading: true);
    notifyListeners();

    await getUserList();

    _userState = userState.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> getUserList() async {
    final result =
        await _userRepository.getUserList(userState.searchOptionUserDTO);

    _userState = userState.copyWith(userList: result);
    notifyListeners();
  }

  Future<void> getUserCountData() async {
    List<Map<String, dynamic>> userCountWeek = [
      {
        'date': '20240212',
        'dayOfWeek': 'Mon.',
        'cnt': 3,
      },
      {
        'date': '20240212',
        'dayOfWeek': 'Tue.',
        'cnt': 2,
      },
      {
        'date': '20240212',
        'dayOfWeek': 'Wed.',
        'cnt': 3,
      },
      {
        'date': '20240212',
        'dayOfWeek': 'Thu.',
        'cnt': 6,
      },
      {
        'date': '20240212',
        'dayOfWeek': 'Fri.',
        'cnt': 10,
      },
      {
        'date': '20240212',
        'dayOfWeek': 'Sat.',
        'cnt': 2,
      },
      {
        'date': '20240212',
        'dayOfWeek': 'Sun.',
        'cnt': 1,
      },
    ];

    _userState = userState.copyWith(userCountWeek: userCountWeek);
    notifyListeners();
  }
}
