import 'package:admin_web_app/data/model/user_model.dart';
import 'package:admin_web_app/data/repository/user_repository_impl.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('user repository testing', () async {
    final userRepositoryImpl = UserRepositoryImpl();
    List<UserModel> userList = await userRepositoryImpl.getUserList();

    if (userList.isNotEmpty) {
      logger.info(userList[0]);
    }

    expect(userList.length, 1);
  });
}
