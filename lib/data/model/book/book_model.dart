import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
class BookModel with _$BookModel {
  const factory BookModel({
    @JsonKey(name: 'book_id') required int bookId,
    @JsonKey(name: 'flight_id') required int flightId,
    @JsonKey(name: 'flight_date') required String flightDate,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'user_name') required String userName,
    @JsonKey(name: 'class_seat') required String classSeat,
    @JsonKey(name: 'book_status') required int bookStatus,
    @JsonKey(name: 'pay_status') required int payStatus,
    @JsonKey(name: 'pay_amount') required int payAmount,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _BookModel;

  factory BookModel.fromJson(Map<String, Object?> json) =>
      _$BookModelFromJson(json);
}
