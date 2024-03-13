import 'package:admin_web_app/data/dto/book_dto.dart';
import 'package:admin_web_app/data/model/book/book_result_model.dart';
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

    initSelectOption();
    updateSelectDayOption();
    updateSelectStatusOption();

    // 예약 데이터 불러오기
    await getBookList();
  }

  void initSelectOption() {
    DateTime dateTime = DateTime.now();
    _bookState = bookState.copyWith(
      selectedYear: dateTime.year,
      selectedMonth: dateTime.month,
      selectedDay: dateTime.day,
      selectedBookStatus: '예약중',
      selectedPayStatus: '결제전',
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
      bookOptionDay: calcDayList,
    );
    notifyListeners();
  }

  void updateSelectStatusOption() {
    _bookState = bookState.copyWith(
      bookStatusOption: bookStatusList,
      bookPayStatusOption: payStatusList,
    );
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

  void selectBookStatus(String bookStatus) {
    _bookState = bookState.copyWith(selectedBookStatus: bookStatus);
    notifyListeners();
  }

  void selectPayStatus(String payStatus) {
    _bookState = bookState.copyWith(selectedPayStatus: payStatus);
    notifyListeners();
  }

  Future<void> getBookList() async {
    String searchDate =
        '${bookState.selectedYear}${bookState.selectedMonth.toString().padLeft(2, '0')}${bookState.selectedDay.toString().padLeft(2, '0')}';

    BookResultDTO bookResultDTO = BookResultDTO(
      flightDate: searchDate,
      status: bookStatusConvert(bookState.selectedBookStatus),
      payStatus: payStatusConvert(bookState.selectedPayStatus),
    );

    final List<BookResultModel> bookList =
        await _bookRepository.getBookResultList(bookResultDTO);

    _bookState = bookState.copyWith(isLoading: false, bookList: bookList);
    notifyListeners();
  }

  int bookStatusConvert(String bookStatus) {
    switch (bookStatus) {
      case '미예약':
        return -1;
      case '예약중':
        return 0;
      case '예약완료':
        return 1;
      case '예약취소':
        return 2;
      default:
        return 4;
    }
  }

  int payStatusConvert(String payStatus) {
    switch (payStatus) {
      case '미결제':
        return -1;
      case '결제전':
        return 0;
      case '결제완료':
        return 1;
      case '결제취소':
        return 2;
      default:
        return 4;
    }
  }
}
