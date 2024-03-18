import 'dart:async';

import 'package:admin_web_app/data/model/account/account_model.dart';
import 'package:admin_web_app/data/model/book/book_result_model.dart';
import 'package:admin_web_app/ui/book/book_state.dart';
import 'package:admin_web_app/ui/book/book_view_model.dart';
import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:admin_web_app/ui/common/enums.dart';
import 'package:admin_web_app/ui/common/widget/common_app_bar_widget.dart';
import 'package:admin_web_app/ui/widget/button_widget.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  StreamSubscription? _stremSubscription;
  late AccountModel accountModel;

  @override
  void initState() {
    Future.microtask(() {
      final BookViewModel bookViewModel = context.read<BookViewModel>();

      bookViewModel.init();

      _stremSubscription = bookViewModel.signResult.listen((event) {
        switch (event) {
          case SignStatus.signSuccess:
          case SignStatus.signFail:
          case SignStatus.isSignedIn:
            context.go('/book');
          case SignStatus.isNotSignedIn:
            context.go('/sign');
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _stremSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BookViewModel bookViewModel = context.watch<BookViewModel>();
    final BookState bookState = bookViewModel.bookState;

    return Scaffold(
      appBar: CommonAppBarWidget(
        title: 'BOOK',
        email: bookState.accountModel?.email ?? '',
        signOutFunction: () => bookViewModel.signOut(),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CommonMenuListWidget(context: context),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('비행일'),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: bookState.bookOptionYear
                                      .map((int item) =>
                                          DropdownMenuItem<String>(
                                            value: '$item',
                                            child: Text(
                                              '$item 년',
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: '${bookState.selectedYear}',
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      bookViewModel
                                          .selectYear(int.parse(value));
                                    } else {
                                      logger.info('year select error');
                                    }
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: bookState.bookOptionMonth
                                      .map((int item) =>
                                          DropdownMenuItem<String>(
                                            value: '$item',
                                            child: Text(
                                              '$item 월',
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: '${bookState.selectedMonth}',
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      bookViewModel
                                          .selectMonth(int.parse(value));
                                    } else {
                                      logger.info('year select error');
                                    }
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: bookState.bookOptionDay
                                      .map((int item) =>
                                          DropdownMenuItem<String>(
                                            value: '$item',
                                            child: Text(
                                              '$item 일',
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: '${bookState.selectedDay}',
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      bookViewModel.selectDay(int.parse(value));
                                    } else {
                                      logger.info('year select error');
                                    }
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('예약상태'),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Book Status',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: bookState.bookStatusOption
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: bookState.selectedBookStatus,
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      bookViewModel.selectBookStatus(value);
                                    } else {
                                      logger.info('year select error');
                                    }
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text('결제상태'),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select PayStatus',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: bookState.bookPayStatusOption
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: bookState.selectedPayStatus,
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      bookViewModel.selectPayStatus(value);
                                    } else {
                                      logger.info('year select error');
                                    }
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                              ButtonWidget(
                                  onTap: () {
                                    bookViewModel.getBookList();
                                  },
                                  text: '조회'),
                            ],
                          ),
                        ),
                      ),
                      PaginatedDataTable(
                        columns: [
                          DataColumn(
                            label: const Text('예약 ID'),
                            onSort: (columnIndex, ascending) {},
                          ),
                          const DataColumn(
                            label: Text('예약자 명'),
                          ),
                          const DataColumn(
                            label: Text('비행일'),
                          ),
                          const DataColumn(
                            label: Text('출발지'),
                          ),
                          const DataColumn(
                            label: Text('출발시각'),
                          ),
                          const DataColumn(
                            label: Text('도착지'),
                          ),
                          const DataColumn(
                            label: Text('도착시각'),
                          ),
                          const DataColumn(
                            label: Text('예약상태'),
                          ),
                          const DataColumn(
                            label: Text('결제상태'),
                          ),
                          const DataColumn(
                            label: Text('예약일'),
                          ),
                          const DataColumn(
                            label: Text('보기'),
                          ),
                        ],
                        source: _BookData(
                          context,
                          // userState.userList,
                          bookState.bookList,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookData extends DataTableSource {
  final BuildContext context;
  final List<BookResultModel> _bookList;

  _BookData(
    this.context,
    this._bookList,
  );

  @override
  DataRow getRow(int index) {
    final item = _bookList[index];
    return DataRow(cells: [
      DataCell(
        SelectableText(
          '${item.bookId}',
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
        SelectableText(
          item.flightDate,
          showCursor: true,
          onTap: () {},
        ),
      ),
      DataCell(
        SelectableText(
          item.departureCode,
          showCursor: true,
          onTap: () {},
        ),
      ),
      DataCell(
        SelectableText(
          item.departureTime,
          showCursor: true,
          onTap: () {},
        ),
      ),
      DataCell(
        SelectableText(
          item.arrivalCode,
          showCursor: true,
          onTap: () {},
        ),
      ),
      DataCell(
        SelectableText(
          item.arrivalTime,
          showCursor: true,
          onTap: () {},
        ),
      ),
      DataCell(
        Text(
          item.status == -1
              ? '미예약'
              : item.status == 0
                  ? '예약중'
                  : item.status == 1
                      ? '예약완료'
                      : item.status == 2
                          ? '예약취소'
                          : '오류',
        ),
      ),
      DataCell(
        Text(
          item.payStatus == -1
              ? '미결제'
              : item.payStatus == 0
                  ? '결제전'
                  : item.payStatus == 1
                      ? '결제완료'
                      : item.status == 2
                          ? '결제취소'
                          : '오류',
        ),
      ),
      DataCell(
        SelectableText(
          '${item.createdAt.year}-${item.createdAt.month.toString().padLeft(2, '0')}-${item.createdAt.day.toString().padLeft(2, '0')}',
          showCursor: true,
          onTap: () {},
        ),
      ),
      DataCell(
        IconButton(
          onPressed: () {
            context.push('/book/detail', extra: {'bookId': item.bookId});
          },
          icon: const Icon(
            Icons.remove_red_eye_rounded,
          ),
          tooltip: 'detail',
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
