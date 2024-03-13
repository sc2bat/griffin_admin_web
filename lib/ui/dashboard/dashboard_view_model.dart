import 'dart:async';

import 'package:admin_web_app/data/model/account/account_model.dart';
import 'package:admin_web_app/data/model/book/book_model.dart';
import 'package:admin_web_app/domain/repository/book_repository.dart';
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
    required BookRepository bookRepository,
  })  : _signRepository = signRepository,
        _sessionRepository = sessionRepository,
        _bookRepository = bookRepository;

  final SignRepository _signRepository;
  final SessionRepository _sessionRepository;
  final BookRepository _bookRepository;

  final StreamController<SignStatus> _signStatus = StreamController();

  Stream<SignStatus> get signResult => _signStatus.stream;

  DashboardState _dashboardState = const DashboardState();

  DashboardState get dashboardState => _dashboardState;

  Future<void> init() async {
    // _updateLoading(true);
    await checkSession();
    // _updateLoading(false);
    await getBookList();
    initDate();
    getCashList();
    getBookCountList();
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

  // void _updateLoading(bool isLoading) {
  //   _dashboardState = dashboardState.copyWith(isLoading: isLoading);
  //   notifyListeners();
  // }

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

  Future<void> getBookList() async {
    Map<String, dynamic> jsonData = {'flight_id': null};
    _dashboardState = dashboardState.copyWith(isLoading: true);
    notifyListeners();

    _dashboardState = dashboardState.copyWith(
        bookList: await _bookRepository.getBookList(jsonData),
        isLoading: false);

    notifyListeners();
  }

  void initDate() {
    DateTime dateTime = DateTime.now();
    _dashboardState =
        dashboardState.copyWith(date: dateTime.toIso8601String().split('T')[0]);
  }

  void getCashList() {
    List<BookModel> originList =
        dashboardState.bookList.where((e) => e.payStatus == 1).toList();
    Map<String, int> amountMap = {};
    List<DateTime> dateList = [];
    List<Map<String, dynamic>> resultList = [];

    for (int i = 0; i < 7; i++) {
      DateTime date = DateTime.now().subtract(Duration(days: i));
      dateList.add(date);
    }

    for (var data in originList) {
      String date = data.createdAt.toString().split(' ')[0];
      int payAmount = int.parse('${data.payAmount}');
      amountMap[date] = (amountMap[date] ?? 0) + payAmount;
      logger.info(amountMap);
    }

    List<Map<String, dynamic>> amountList = amountMap.entries.map((entry) {
      return {'date': entry.key.split(' ')[0], 'pay_amount': entry.value};
    }).toList();
    logger.info(amountList);

    for (var date in dateList) {
      String formattedDate = date.toIso8601String().split('T')[0];
      Map<String, dynamic> result = {'date': formattedDate, 'pay_amount': 0};

      // 주어진 데이터에서 해당 날짜와 일치하는 값을 찾아 결과에 반영
      for (var data in amountList) {
        if (data['date'] == formattedDate) {
          result['pay_amount'] = data['pay_amount'];
          break;
        }
      }
      resultList.add(result);
    }
    _dashboardState =
        dashboardState.copyWith(cashList: resultList.reversed.toList());
    notifyListeners();
  }

  void getBookCountList() {
    List<BookModel> originList =
        dashboardState.bookList.where((e) => e.status == 1).toList();
    Map<String, int> amountMap = {};
    List<DateTime> dateList = [];
    List<Map<String, dynamic>> resultList = [];

    for (int i = 0; i < 7; i++) {
      DateTime date = DateTime.now().subtract(Duration(days: i));
      dateList.add(date);
    }

    for (var data in originList) {
      String date = data.createdAt.toString().split(' ')[0];
      amountMap[date] = (amountMap[date] ?? 0) + data.status;
    }
    List<Map<String, dynamic>> amountList = amountMap.entries.map((entry) {
      return {'date': entry.key.split(' ')[0], 'book_count': entry.value};
    }).toList();
    logger.info(amountList);

    for (var date in dateList) {
      String formattedDate = date.toIso8601String().split('T')[0];
      Map<String, dynamic> result = {'date': formattedDate, 'book_count': 0};

      // 주어진 데이터에서 해당 날짜와 일치하는 값을 찾아 결과에 반영
      for (var data in amountList) {
        if (data['date'] == formattedDate) {
          result['book_count'] = data['book_count'];
          break;
        }
      }
      resultList.add(result);
    }

    _dashboardState =
        dashboardState.copyWith(bookCountList: resultList.reversed.toList());
    notifyListeners();
    // logger.info(dashboardState.bookCountList);
  }
}
