import 'dart:convert';

import 'package:admin_web_app/data/http.dart';
import 'package:admin_web_app/data/model/book/book_model.dart';
import 'package:admin_web_app/env/env.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('BookRepository getBookList', () async {
    final response = await fetchHttp(Env.mockBookUrl);

    final List<dynamic> jsonData = jsonDecode(response.body);
    logger.info(jsonData);

    final List<BookModel> bookModel =
        jsonData.map((e) => BookModel.fromJson(e)).toList();

    logger.info(bookModel.length);
  });
}
