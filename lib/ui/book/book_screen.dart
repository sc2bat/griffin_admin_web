import 'package:admin_web_app/ui/book/book_state.dart';
import 'package:admin_web_app/ui/book/book_view_model.dart';
import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  void initState() {
    Future.microtask(() {
      final BookViewModel bookViewModel = context.read<BookViewModel>();

      bookViewModel.init();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BookViewModel bookViewModel = context.watch<BookViewModel>();
    final BookState bookState = bookViewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('GRIFFIN ADMIN WEB PAGE'),
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
                  children: List.generate(bookState.bookList.length, (index) {
                    return Container(
                      child: Column(
                        children: [
                          Text('id ${bookState.bookList[index].bookId}'),
                          Text('예약일시 ${bookState.bookList[index].createdAt}'),
                          Text('비행일 ${bookState.bookList[index].flightDate}'),
                          Text('비행편id ${bookState.bookList[index].flightId}'),
                          Text('예약자명 ${bookState.bookList[index].userName}'),
                          Text('예약상태 ${bookState.bookList[index].bookStatus}'),
                          Text('결제상태 ${bookState.bookList[index].payStatus}'),
                          Text('결제금액 ${bookState.bookList[index].payAmount}'),
                          Text('좌석번호 ${bookState.bookList[index].classSeat}'),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
