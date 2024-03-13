import 'package:admin_web_app/data/model/book/book_model.dart';
import 'package:admin_web_app/data/model/passport/passport_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_detail_state.freezed.dart';

@freezed
class BookDetailState with _$BookDetailState {
  factory BookDetailState({
    @Default(false) bool isLoading,
    BookModel? bookModel,
    PassportModel? passportModel,
  }) = _BookDetailState;
}
