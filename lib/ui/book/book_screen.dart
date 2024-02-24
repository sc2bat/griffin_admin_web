import 'dart:math';

import 'package:admin_web_app/data/model/book/book_model.dart';
import 'package:admin_web_app/ui/book/book_state.dart';
import 'package:admin_web_app/ui/book/book_view_model.dart';
import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                  children: [
                    PaginatedDataTable(
                      columns: [
                        const DataColumn(
                          label: Text('No.'),
                        ),
                        DataColumn(
                          label: const Text('예약 ID'),
                          onSort: (columnIndex, ascending) {},
                        ),
                        const DataColumn(
                          label: Text('비행일'),
                        ),
                        const DataColumn(
                          label: Text('비행편 ID'),
                        ),
                        const DataColumn(
                          label: Text('예약자 ID'),
                        ),
                        const DataColumn(
                          label: Text('예약자 명'),
                        ),
                        const DataColumn(
                          label: Text('예약상태'),
                        ),
                        const DataColumn(
                          label: Text('결제상태'),
                        ),
                        const DataColumn(
                          label: Text('보기'),
                        ),
                        const DataColumn(
                          label: Text('수정'),
                        ),
                        const DataColumn(
                          label: Text('삭제'),
                        ),
                      ],
                      source: _BookData(
                        context,
                        // userState.userList,
                        dumpBookList,
                      ),
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

List<BookModel> dumpBookList = List.generate(
  100,
  (index) => BookModel(
    bookId: index + 1,
    flightId: Random().nextInt(10000),
    flightDate: '20240220',
    userId: Random().nextInt(10),
    userName: 'user$index',
    classSeat: 'C$index',
    bookStatus: Random().nextInt(3),
    payStatus: Random().nextInt(3),
    payAmount: Random().nextInt(1000000),
    createdAt: '2024011${Random().nextInt(10)}',
  ),
);

class _BookData extends DataTableSource {
  final BuildContext context;
  final List<BookModel> _bookList;
  _BookData(
    this.context,
    this._bookList,
  );

  @override
  DataRow getRow(int index) {
    final item = _bookList[index];
    return DataRow(cells: [
      DataCell(
        Text(
          '${index + 1}',
        ),
      ),
      DataCell(
        SelectableText(
          '${item.bookId}',
          showCursor: true,
          onTap: () {},
        ),
      ),
      DataCell(
        SelectableText(
          item.flightDate,
          showCursor: true,
          onTap: () {},
        ),
      ),
      DataCell(
        SelectableText(
          '${item.flightId}',
          showCursor: true,
          onTap: () {},
        ),
      ),
      DataCell(
        SelectableText(
          '${item.userId}',
          showCursor: true,
          onTap: () {},
        ),
      ),
      DataCell(
        SelectableText(
          item.userName,
          showCursor: true,
          onTap: () {},
        ),
      ),
      DataCell(
        Text(
          item.bookStatus == 0
              ? '예약 중'
              : item.bookStatus == 1
                  ? '예약완료'
                  : item.bookStatus == 4
                      ? '예약취소'
                      : '오류',
        ),
      ),
      DataCell(
        Text(
          item.payStatus == 0
              ? '미결제'
              : item.payStatus == 1
                  ? '결제 중'
                  : item.payStatus == 2
                      ? '결제 완료'
                      : '오류',
        ),
      ),
      DataCell(
        IconButton(
          onPressed: () {
            logger.info('press edit button ${item.bookId}');
            context.push('/book/detail', extra: {'bookId': item.bookId});
          },
          icon: const Icon(
            Icons.remove_red_eye_rounded,
          ),
          tooltip: 'detail',
        ),
      ),
      DataCell(
        IconButton(
          onPressed: () {
            logger.info('press edit button ${item.bookId}');
          },
          icon: const Icon(
            Icons.edit,
          ),
          tooltip: 'update',
        ),
      ),
      DataCell(
        IconButton(
          onPressed: () {
            logger.info('press delete button ${item.bookId}');
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete Confirm'),
                  content: Text('예약 ${item.bookId} 를 취소합니다.'),
                );
              },
            );
          },
          icon: const Icon(
            Icons.delete,
          ),
          tooltip: 'delete',
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _bookList.length;

  @override
  int get selectedRowCount => 0;
}
