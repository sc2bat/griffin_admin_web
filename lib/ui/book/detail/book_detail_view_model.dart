import 'package:admin_web_app/data/model/book/book_model.dart';
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

    BookModel bookModel = await getBookData(bookId);
    _state = state.copyWith(isLoading: false, bookModel: bookModel);
    notifyListeners();
  }

  Future<BookModel> getBookData(int bookId) async {
    return await _bookRepository.getBookOne(bookId);
  }
}
