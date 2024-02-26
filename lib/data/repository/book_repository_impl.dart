import 'dart:convert';

import 'package:admin_web_app/data/http.dart';
import 'package:admin_web_app/data/model/book/book_model.dart';
import 'package:admin_web_app/domain/repository/book_repository.dart';
import 'package:admin_web_app/env/env.dart';
import 'package:admin_web_app/utils/simple_logger.dart';

class BookRepositoryImpl implements BookRepository {
  @override
  Future<List<BookModel>> getBookList() async {
    try {
      final response = await fetchHttp(Env.mockBookUrl);

      final List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData.map((e) => BookModel.fromJson(e)).toList();
    } catch (e) {
      logger.info('BookRepository getBookList => $e');
      throw Exception(e);
    }
  }

  @override
  Future<BookModel> getBookOne(int bookId) async {
    try {
      final response = await fetchHttp('${Env.mockBookUrl}?bookId=$bookId');

      final jsonData = jsonDecode(response.body);

      return jsonData.map((e) => BookModel.fromJson(e));
    } catch (e) {
      logger.info('BookRepository getBookList => $e');
      throw Exception(e);
    }
  }

  @override
  Future<BookModel> updateBook(BookModel bookModel) async {
    // TODO: implement updateBook
    throw UnimplementedError();
  }

  @override
  Future<BookModel> deleteBook(int bookId) async {
    // TODO: implement deleteBook
    throw UnimplementedError();
  }
}
