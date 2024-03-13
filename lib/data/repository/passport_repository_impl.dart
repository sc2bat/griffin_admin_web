import 'dart:convert';

import 'package:admin_web_app/data/dto/passport_dto.dart';
import 'package:admin_web_app/data/http.dart';
import 'package:admin_web_app/data/mapper/passport_mapper.dart';
import 'package:admin_web_app/data/model/passport/passport_model.dart';
import 'package:admin_web_app/domain/repository/passport_repository.dart';
import 'package:admin_web_app/env/env.dart';
import 'package:admin_web_app/utils/simple_logger.dart';

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

  @override
  Future<PassportModel> getPassportByBookId(int bookId) async {
    try {
      final response = await fetchHttpWithParam(
        url: '${Env.adminHostUrl}/passports/',
        paramData: {'book_id': bookId},
      );

      final List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData
          .map((e) => PassportMapper.fromDTO(PassportDTO.fromJson(e)))
          .toList()[0];
    } catch (e) {
      logger.info('getPassportByBookId => $e');
      throw Exception(e);
    }
  }
}
