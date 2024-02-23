import 'package:admin_web_app/data/model/book/book_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_state.freezed.dart';

@freezed
class BookState with _$BookState {
  factory BookState({
    @Default(false) bool isLoading,
    @Default([]) List<BookModel> bookList,
  }) = _BookState;
}
