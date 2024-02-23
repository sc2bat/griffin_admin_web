import 'package:admin_web_app/data/model/book/book_model.dart';

abstract interface class BookRepository {
  Future<List<BookModel>> getBookList();
  Future<BookModel> getBookOne(int bookId);
  Future<BookModel> updateBook(BookModel bookModel);
  Future<BookModel> deleteBook(int bookId);
}
