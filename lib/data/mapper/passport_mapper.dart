import 'package:admin_web_app/data/dto/passport_dto.dart';
import 'package:admin_web_app/data/model/passport/passport_model.dart';

class PassportMapper {
  static PassportModel fromDTO(PassportDTO dto) {
    return PassportModel(
      passportId: dto.passportId ?? 0,
      gender: dto.gender ?? 0,
      firstName: dto.firstName ?? "",
      lastName: dto.lastName ?? "",
      email: dto.email ?? "",
      phone: dto.phone ?? "",
      birthday: dto.birthday ?? "",
      createdAt: dto.createdAt ?? DateTime.now(),
      isDeleted: dto.isDeleted ?? 0,
      bookId: dto.bookId ?? 0,
    );
  }

  static PassportDTO toDTO(PassportModel model) {
    return PassportDTO(
      passportId: model.passportId,
      gender: model.gender,
      firstName: model.firstName,
      lastName: model.lastName,
      email: model.email,
      phone: model.phone,
      birthday: model.birthday,
      createdAt: model.createdAt,
      isDeleted: model.isDeleted,
      bookId: model.bookId,
    );
  }
}
