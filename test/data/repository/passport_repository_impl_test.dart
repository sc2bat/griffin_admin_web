import 'package:admin_web_app/data/model/passport/passport_model.dart';
import 'package:admin_web_app/data/repository/passport_repository_impl.dart';
import 'package:admin_web_app/domain/repository/passport_repository.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  PassportRepository passportRepository = PassportRepositoryImpl();
  test('getPassportByBookId test', () async {
    final PassportModel result =
        await passportRepository.getPassportByBookId(90);
    logger.info('${result.passportId}');
  });
}
