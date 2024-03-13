import 'package:admin_web_app/domain/repository/book_repository.dart';
import 'package:admin_web_app/domain/repository/passport_repository.dart';
import 'package:admin_web_app/ui/book/detail/book_detail_state.dart';
import 'package:flutter/material.dart';

class BookDetailViewModel extends ChangeNotifier {
  final BookRepository _bookRepository;
  final PassportRepository _passportRepository;
  BookDetailViewModel({
    required BookRepository bookRepository,
    required PassportRepository passportRepository,
  })  : _bookRepository = bookRepository,
        _passportRepository = passportRepository;

  BookDetailState _state = BookDetailState();

  BookDetailState get state => _state;

  Future<void> init(int bookId) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    await getBookData(bookId);

    await getPassportData(bookId);

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> getBookData(int bookId) async {
    final result = await _bookRepository.getBookOne(bookId);

    _state = state.copyWith(bookResultModel: result);
    notifyListeners();
  }

  Future<void> getPassportData(int bookId) async {
    final result = await _passportRepository.getPassportByBookId(bookId);

    _state = state.copyWith(passportModel: result);
    notifyListeners();
  }
}
