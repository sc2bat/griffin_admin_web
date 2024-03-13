import 'package:admin_web_app/data/model/book/book_model.dart';
import 'package:admin_web_app/ui/book/detail/book_detail_view_model.dart';
import 'package:admin_web_app/ui/common/common.dart';
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
    logger.info(widget.bookId);
    Future.microtask(() {
      final bookDetailViewModel = context.read<BookDetailViewModel>();
      bookDetailViewModel.init(widget.bookId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookDetailViewModel = context.watch<BookDetailViewModel>();
    final state = bookDetailViewModel.state;

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
                child: state.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: (state.bookResultModel != null &&
                                state.passportModel != null)
                            ? [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('예약 정보'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '예약 번호 : ${state.bookResultModel!.bookId}',
                                          ),
                                          Text(
                                            '예약자명 : ${state.bookResultModel!.userName}',
                                          ),
                                          Text(
                                            '비행일 :  ${state.bookResultModel!.flightDate}',
                                          ),
                                          Text(
                                            '좌석번호 : ${state.bookResultModel!.classSeat}',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '출발지 : ${state.bookResultModel!.departureCode}',
                                          ),
                                          Text(
                                            '출발시각 : ${state.bookResultModel!.departureTime}',
                                          ),
                                          Text(
                                            '도착지 :  ${state.bookResultModel!.arrivalCode}',
                                          ),
                                          Text(
                                            '도착시각 : ${state.bookResultModel!.arrivalTime}',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('여권 정보'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '성별 : ${state.passportModel!.gender}',
                                          ),
                                          Text(
                                            '이름 : ${state.passportModel!.firstName}',
                                          ),
                                          Text(
                                            '성 :  ${state.passportModel!.lastName}',
                                          ),
                                          Text(
                                            '생년월일 :  ${state.passportModel!.birthday}',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '이메일 : ${state.passportModel!.email}',
                                          ),
                                          Text(
                                            '전화번호 : ${state.passportModel!.phone}',
                                          ),
                                          Text(
                                            '등록일시 : ${formatDate(state.passportModel!.createdAt)}',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                            : [
                                const Text(
                                  '조회 결과가 없습니다. 관리자에게 문의하세요.',
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
