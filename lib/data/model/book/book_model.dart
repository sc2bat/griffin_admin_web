// ignore_for_file: invalid_annotation_target

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
    required int status,
    @JsonKey(name: 'pay_status') required int payStatus,
    @JsonKey(name: 'pay_amount') required double payAmount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _BookModel;

  factory BookModel.fromJson(Map<String, Object?> json) =>
      _$BookModelFromJson(json);
}
