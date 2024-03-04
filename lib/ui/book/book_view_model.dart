import 'package:admin_web_app/data/model/book/book_model.dart';
import 'package:admin_web_app/domain/repository/book_repository.dart';
import 'package:admin_web_app/ui/book/book_state.dart';
import 'package:admin_web_app/ui/common/constants.dart';
import 'package:flutter/material.dart';

class BookViewModel with ChangeNotifier {
  final BookRepository _bookRepository;
  BookViewModel({
    required BookRepository bookRepository,
  }) : _bookRepository = bookRepository;

  BookState _bookState = BookState();
  BookState get bookState => _bookState;

  Future<void> init() async {
    _bookState = bookState.copyWith(isLoading: true);
    notifyListeners();

    // 오늘 날짜 설정
    initSelectDateOption();
    // 날짜 선택 옵션
    updateSelectDayOption();
    // 예약 데이터 불러오기
    await getBookList();
  }

  void initSelectDateOption() {
    DateTime dateTime = DateTime.now();
    _bookState = bookState.copyWith(
      selectedYear: dateTime.year,
      selectedMonth: dateTime.month,
      selectedDay: dateTime.day,
    );
    notifyListeners();
  }

  void updateSelectDayOption() {
    int daysInMonth =
        DateTime(bookState.selectedYear, bookState.selectedMonth + 1, 0).day;
    List<int> calcDayList = List.generate(daysInMonth, (index) => index + 1);
    if (bookState.selectedDay > calcDayList.last) {
      _bookState = bookState.copyWith(selectedDay: calcDayList.last);
    }
    _bookState = bookState.copyWith(
        bookOptionYear: dateFixedYearList,
        bookOptionMonth: dateFixedMonthList,
        bookOptionDay: calcDayList);
    notifyListeners();
  }

  void selectYear(int year) {
    _bookState = bookState.copyWith(selectedYear: year);
    notifyListeners();
    updateSelectDayOption();
  }

  void selectMonth(int month) {
    _bookState = bookState.copyWith(selectedMonth: month);
    notifyListeners();
    updateSelectDayOption();
  }

  void selectDay(int day) {
    _bookState = bookState.copyWith(selectedDay: day);
    notifyListeners();
    updateSelectDayOption();
  }

  void selectBookStatus(int bookStatus) {
    _bookState = bookState.copyWith(selectedBookStatus: bookStatus);
    notifyListeners();
  }

  void selectPayStatus(int payStatus) {
    _bookState = bookState.copyWith(selectedPayStatus: payStatus);
    notifyListeners();
  }

  Future<void> getBookList() async {
    String searchDate =
        '${bookState.selectedYear}${bookState.selectedMonth.toString().padLeft(2, '0')}${bookState.selectedDay.toString().padLeft(2, '0')}';

    Map<String, dynamic> jsonData = {
      'flight_date': searchDate,
      'book_status': bookState.selectedBookStatus != 9
          ? bookState.selectedBookStatus
          : null,
      'pay_status':
          bookState.selectedPayStatus != 9 ? bookState.selectedPayStatus : null,
    };

    final List<BookModel> bookList =
        await _bookRepository.getBookList(jsonData);

    _bookState = bookState.copyWith(isLoading: false, bookList: bookList);
    notifyListeners();
  }
}
