// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_result_model.freezed.dart';
part 'book_result_model.g.dart';

@freezed
class BookResultModel with _$BookResultModel {
  const factory BookResultModel({
    required int bookId,
    required int userId,
    required String userName,
    required int flightId,
    required String flightDate,
    required String classSeat,
    required String departureTime,
    required String departureCode,
    required String arrivalTime,
    required String arrivalCode,
    required int status,
    required int payStatus,
    required double payAmount,
    required DateTime createdAt,
  }) = _BookResultModel;

  factory BookResultModel.fromJson(Map<String, Object?> json) =>
      _$BookResultModelFromJson(json);
}
