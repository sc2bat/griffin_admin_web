import 'dart:convert';

import 'package:admin_web_app/data/dto/book_dto.dart';
import 'package:admin_web_app/data/http.dart';
import 'package:admin_web_app/data/mapper/book_result_mapper.dart';
import 'package:admin_web_app/data/model/book/book_model.dart';
import 'package:admin_web_app/data/model/book/book_result_model.dart';
import 'package:admin_web_app/domain/repository/book_repository.dart';
import 'package:admin_web_app/env/env.dart';
import 'package:admin_web_app/utils/simple_logger.dart';

class BookRepositoryImpl implements BookRepository {
  @override
  Future<List<BookModel>> getBookList(Map<String, dynamic> paramData) async {
    try {
      final response = await fetchHttpWithParam(
        url: '${Env.adminHostUrl}/payment/',
        paramData: paramData,
      );

      final jsonData = jsonDecode(response.body);

      final List<dynamic> result = jsonData['result'];

      return result.map((e) => BookModel.fromJson(e)).toList();
    } catch (e) {
      logger.info('BookRepository getBookList => $e');
      throw Exception(e);
    }
  }

  @override
  Future<BookResultModel> getBookOne(int bookId) async {
    try {
      final response = await fetchHttpWithParam(
        url: '${Env.adminHostUrl}/payment/',
        paramData: {'book_id': bookId},
      );

      final jsonData = jsonDecode(response.body);

      final List<dynamic> result = jsonData['result'];

      final List<BookResultDTO> bookResultDTOList =
          result.map((e) => BookResultDTO.fromJson(e)).toList();

      return BookResultMapper.fromDTO(
          bookResultDTOList.firstWhere((element) => element.bookId == bookId));
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

  @override
  Future<List<BookResultModel>> getBookResultList(
      BookResultDTO bookResultDTO) async {
    try {
      final response = await fetchHttpWithParam(
        url: '${Env.adminHostUrl}/payment/',
        paramData: bookResultDTO.toJson(),
      );

      final jsonData = jsonDecode(response.body);

      final List<dynamic> result = jsonData['result'];

      return result
          .map((e) => BookResultMapper.fromDTO(BookResultDTO.fromJson(e)))
          .toList();
    } catch (e) {
      logger.info('BookRepository getBookList => $e');
      throw Exception(e);
    }
  }
}
