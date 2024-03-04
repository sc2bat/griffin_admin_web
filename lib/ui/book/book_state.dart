import 'package:admin_web_app/data/model/book/book_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_state.freezed.dart';

@freezed
class BookState with _$BookState {
  factory BookState({
    @Default(false) bool isLoading,
    @Default([]) List<BookModel> bookList,
    @Default([]) List<int> bookOptionYear,
    @Default([]) List<int> bookOptionMonth,
    @Default([]) List<int> bookOptionDay,
    @Default([]) List<String> bookStatusOption,
    @Default([]) List<String> bookPayStatusOption,
    @Default(2024) int selectedYear,
    @Default(1) int selectedMonth,
    @Default(1) int selectedDay,
    @Default(0) int selectedBookStatus,
    @Default(0) int selectedPayStatus,
  }) = _BookState;
}
