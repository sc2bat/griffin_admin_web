import 'package:admin_web_app/data/model/passport/passport_model.dart';
import 'package:admin_web_app/domain/repository/passport_repository.dart';

class PassportRepositoryImpl implements PassportRepository {
  @override
  Future<List<PassportModel>> getPassportList() async {
    // TODO: implement getPassportList
    throw UnimplementedError();
  }

  @override
  Future<PassportModel> getPassportOne(int passportId) async {
    // TODO: implement getPassportOne
    throw UnimplementedError();
  }

  @override
  Future<void> updatePassport(PassportModel passportModel) async {
    // TODO: implement updatePassport
    throw UnimplementedError();
  }

  @override
  Future<void> deletePassport(PassportModel passportModel) async {
    // TODO: implement deletePassport
    throw UnimplementedError();
  }
}
