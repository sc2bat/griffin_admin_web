// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_web_app/data/model/user_model.dart';
import 'package:admin_web_app/ui/user/user_state.dart';
import 'package:admin_web_app/ui/user/user_view_model.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/common_menu_list_widget.dart';
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late int showingTooltip;
  @override
  void initState() {
    Future.microtask(() {
      final UserViewModel userViewModel = context.read<UserViewModel>();

      // userViewModel.getUserList();
    });
    showingTooltip = -1;
    super.initState();
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(
          toY: y.toDouble(),
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    DateTime now = DateTime.now();
    switch (value.toInt()) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
        text =
            '[ ${now.subtract(Duration(days: 6 - value.toInt())).month} - ${now.subtract(Duration(days: 6 - value.toInt())).day} ]';
        break;
      default:
        text = 'none';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final UserViewModel userViewModel = context.watch();
    final UserState userState = userViewModel.state;

    List<UserModel> dumpUserList = List.generate(
      60,
      (index) => UserModel(
        userId: index,
        email: '$index@test.com',
        userName: 'name_$index',
        isDeleted: 0,
      ),
    );

    List<Map<String, dynamic>> userCountByDate = [
      {
        'date': '20240212',
        'dayOfWeek': 'Mon.',
        'cnt': 3,
      },
      {
        'date': '20240212',
        'dayOfWeek': 'Tue.',
        'cnt': 2,
      },
      {
        'date': '20240212',
        'dayOfWeek': 'Wed.',
        'cnt': 3,
      },
      {
        'date': '20240212',
        'dayOfWeek': 'Thu.',
        'cnt': 6,
      },
      {
        'date': '20240212',
        'dayOfWeek': 'Fri.',
        'cnt': 10,
      },
      {
        'date': '20240212',
        'dayOfWeek': 'Sat.',
        'cnt': 2,
      },
      {
        'date': '20240212',
        'dayOfWeek': 'Sun.',
        'cnt': 1,
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('GRIFFIN ADMIN WEB PAGE'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CommonMenuListWidget(context: context),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 320.0,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('총 사용자 계정 수'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                // Text('${userState.userList.length}'),
                                Text('${dumpUserList.length}'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                children: [
                                  const Text('일별 신규 사용자 수'),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  SizedBox(
                                    height: 224.0,
                                    child: AspectRatio(
                                      aspectRatio: 2.0,
                                      child: BarChart(
                                        BarChartData(
                                          barGroups: List.generate(
                                            userCountByDate.length,
                                            (index) => generateGroupData(
                                              index,
                                              userCountByDate[index]['cnt'],
                                            ),
                                          ),
                                          titlesData: FlTitlesData(
                                            show: true,
                                            topTitles: const AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            rightTitles: const AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            bottomTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                getTitlesWidget: bottomTitles,
                                              ),
                                            ),
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                getTitlesWidget: leftTitles,
                                              ),
                                            ),
                                          ),
                                          barTouchData: BarTouchData(
                                            enabled: true,
                                            handleBuiltInTouches: false,
                                            touchCallback: (event, response) {
                                              if (response != null &&
                                                  response.spot != null &&
                                                  event is FlTapUpEvent) {
                                                setState(
                                                  () {
                                                    final x = response.spot!
                                                        .touchedBarGroup.x;
                                                    final isShowing =
                                                        showingTooltip == x;
                                                    if (isShowing) {
                                                      showingTooltip = -1;
                                                    } else {
                                                      showingTooltip = x;
                                                    }
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PaginatedDataTable(
                      columns: [
                        const DataColumn(
                          label: Text('No.'),
                        ),
                        DataColumn(
                          label: const Text('사용자 아이디'),
                          onSort: (columnIndex, ascending) {},
                        ),
                        const DataColumn(
                          label: Text('이메일'),
                        ),
                        const DataColumn(
                          label: Text('사용자명'),
                        ),
                        const DataColumn(
                          label: Text('계정상태'),
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
                      source: _UserData(
                        context,
                        // userState.userList,
                        dumpUserList,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserData extends DataTableSource {
  final BuildContext context;
  final List<UserModel> _users;
  _UserData(
    this.context,
    this._users,
  );

  @override
  DataRow getRow(int index) {
    final item = _users[index];
    return DataRow(cells: [
      DataCell(
        Text(
          '$index',
        ),
      ),
      DataCell(
        Text(
          item.userId.toString(),
        ),
      ),
      DataCell(
        Text(
          item.email.toString(),
        ),
      ),
      DataCell(
        Text(
          item.userName.toString(),
        ),
      ),
      DataCell(
        Text(
          item.isDeleted == 0 ? '활성계정' : '휴면계정',
          style: TextStyle(
            color: item.isDeleted == 0 ? Colors.blueAccent : Colors.redAccent,
          ),
        ),
      ),
      DataCell(
        IconButton(
          onPressed: () {
            logger.info('press edit button ${item.userId}');
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
            logger.info('press edit button ${item.userId}');
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
            logger.info('press delete button ${item.userId}');
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete Confirm'),
                  content: Text('아이디 ${item.userId} 를 휴면상태로 변경합니다.'),
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
  int get rowCount => _users.length;

  @override
  int get selectedRowCount => 0;
}
