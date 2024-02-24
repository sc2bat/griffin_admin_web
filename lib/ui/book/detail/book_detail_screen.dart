import 'package:admin_web_app/data/model/book/book_model.dart';
import 'package:admin_web_app/ui/book/detail/book_detail_view_model.dart';
import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatefulWidget {
  final int bookId;
  const BookDetailScreen({
    super.key,
    required this.bookId,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  late BookModel bookModel;

  @override
  void initState() {
    // get book data by bookId
    logger.info(widget.bookId);
    Future.microtask(() {
      final bookDetailViewModel = context.read<BookDetailViewModel>();
      // bookDetailViewModel.init(widget.bookId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('BOOK DETAIL PAGE'),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CommonMenuListWidget(context: context),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '예약 번호 : ${widget.bookId}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
