import 'package:admin_web_app/data/model/book/book_model.dart';
import 'package:admin_web_app/domain/repository/book_repository.dart';
import 'package:admin_web_app/ui/book/book_state.dart';
import 'package:flutter/material.dart';

class BookViewModel with ChangeNotifier {
  final BookRepository _bookRepository;
  BookViewModel({
    required BookRepository bookRepository,
  }) : _bookRepository = bookRepository;

  BookState _state = BookState();
  BookState get state => _state;

  Future<void> init() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final List<BookModel> bookList = await _bookRepository.getBookList();

    _state = state.copyWith(isLoading: false, bookList: bookList);
    notifyListeners();
  }
}
