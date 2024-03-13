import 'package:admin_web_app/data/dto/book_dto.dart';
import 'package:admin_web_app/data/model/book/book_result_model.dart';

class BookResultMapper {
  static BookResultModel fromDTO(BookResultDTO dto) {
    return BookResultModel(
      bookId: dto.bookId ?? 0,
      userId: dto.userId ?? 0,
      flightId: dto.flightId ?? 0,
      flightDate: dto.flightDate ?? "",
      classSeat: dto.classSeat ?? "",
      status: dto.status ?? 0,
      payStatus: dto.payStatus ?? 0,
      payAmount: dto.payAmount ?? 0,
      createdAt: dto.createdAt ?? DateTime.now(),
      userName: dto.userName ?? "",
      departureTime: dto.departureTime ?? "",
      departureCode: dto.departureCode ?? "",
      arrivalTime: dto.arrivalTime ?? "",
      arrivalCode: dto.arrivalCode ?? "",
    );
  }

  static BookResultDTO toDTO(BookResultModel model) {
    return BookResultDTO(
      bookId: model.bookId,
      userId: model.userId,
      flightId: model.flightId,
      flightDate: model.flightDate,
      classSeat: model.classSeat,
      status: model.status,
      payStatus: model.payStatus,
      payAmount: model.payAmount,
      createdAt: model.createdAt,
      userName: model.userName,
      departureTime: model.departureTime,
      departureCode: model.departureCode,
      arrivalTime: model.arrivalTime,
      arrivalCode: model.arrivalCode,
    );
  }
}
