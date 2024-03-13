import 'package:admin_web_app/data/dto/book_dto.dart';
import 'package:admin_web_app/data/model/book/book_model.dart';
import 'package:admin_web_app/data/model/book/book_result_model.dart';

abstract interface class BookRepository {
  Future<List<BookModel>> getBookList(Map<String, dynamic> paramData);
  Future<List<BookResultModel>> getBookResultList(BookResultDTO bookResultDTO);
  Future<BookResultModel> getBookOne(int bookId);
  Future<BookModel> updateBook(BookModel bookModel);
  Future<BookModel> deleteBook(int bookId);
}
