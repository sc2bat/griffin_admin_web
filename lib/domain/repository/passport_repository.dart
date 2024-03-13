import 'package:admin_web_app/data/model/passport/passport_model.dart';

abstract interface class PassportRepository {
  Future<List<PassportModel>> getPassportList();
  Future<PassportModel> getPassportOne(int passportId);
  Future<void> updatePassport(PassportModel passportModel);
  Future<void> deletePassport(PassportModel passportModel);
}
