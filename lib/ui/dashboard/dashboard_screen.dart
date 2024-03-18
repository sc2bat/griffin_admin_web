import 'dart:async';

import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:admin_web_app/ui/common/enums.dart';
import 'package:admin_web_app/ui/dashboard/dashboard_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../common/widget/common_app_bar_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  StreamSubscription? _stremSubscription;
  late int showingAmountTooltip;
  late int showingBookTooltip;

  @override
  void initState() {
    Future.microtask(() {
      final splashViewModel = context.read<DashboardViewModel>();
      splashViewModel.init();
      _stremSubscription = splashViewModel.signResult.listen((event) {
        switch (event) {
          case SignStatus.signSuccess:
          case SignStatus.signFail:
          case SignStatus.isSignedIn:
            context.go('/dashboard');
          case SignStatus.isNotSignedIn:
            context.go('/sign');
        }
      });
    });
    showingAmountTooltip = -1;
    showingBookTooltip = -1;
    super.initState();
  }

  @override
  void dispose() {
    _stremSubscription?.cancel();
    super.dispose();
  }

  BarChartGroupData generateAmountGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingAmountTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(toY: y.toDouble(), color: const Color(0xFFDAA520)),
      ],
    );
  }

  BarChartGroupData generateBookGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingBookTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(toY: y.toDouble(), color: const Color(0xFFDAA520)),
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
            '[ ${now.subtract(Duration(days: 6 - value.toInt())).month} / ${now.subtract(Duration(days: 6 - value.toInt())).day} ]';
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
    final dashboardViewModel = context.watch<DashboardViewModel>();
    final dashboardState = dashboardViewModel.dashboardState;

    return Scaffold(
      appBar: CommonAppBarWidget(
        title: 'DASHBOARD',
        email: dashboardState.accountModel?.email ?? '',
        signOutFunction: () => dashboardViewModel.signOut(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * 0.6,
            minHeight: MediaQuery.of(context).size.height * 0.5,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CommonMenuListWidget(context: context),
                ),
                dashboardState.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Card(
                                    child: _SampleCard(
                                  cardName: 'Cash Deposit',
                                  cardContext:
                                      '\$ ${dashboardState.bookList.where((e) => e.payStatus == 1).map((e) => e.payAmount).toList().fold(0.0, (value, element) => value + element).toString()}',
                                )),
                                Card(
                                    child: _SampleCard(
                                  cardName: 'Total Book Count',
                                  cardContext: dashboardState.bookList
                                      .where((e) => e.status == 1)
                                      .length
                                      .toString(),
                                )),
                                Card(
                                    child: _SampleCard(
                                  cardName: 'Today Book',
                                  cardContext: dashboardState.bookList
                                      .where((e) =>
                                          e.createdAt
                                                  .toString()
                                                  .split(' ')[0] ==
                                              dashboardState.date &&
                                          e.status == 1)
                                      .length
                                      .toString(),
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF4C164B),
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          '  Daily Profit Chart  ',
                                          style: TextStyle(
                                            color: Color(0xFFE8E1C9),
                                          ),
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: const Color(0xFF4C164B),
                                              width: 3)),
                                      height: 224.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AspectRatio(
                                          aspectRatio: 2.0,
                                          child: BarChart(BarChartData(
                                              barGroups: List.generate(
                                                dashboardState.cashList.length,
                                                (index) =>
                                                    generateAmountGroupData(
                                                  index,
                                                  dashboardState.cashList[index]
                                                      ['pay_amount'],
                                                ),
                                              ),
                                              titlesData: FlTitlesData(
                                                show: true,
                                                topTitles: const AxisTitles(
                                                  sideTitles: SideTitles(
                                                      showTitles: false),
                                                ),
                                                rightTitles: const AxisTitles(
                                                  sideTitles: SideTitles(
                                                      showTitles: false),
                                                ),
                                                bottomTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: true,
                                                    getTitlesWidget:
                                                        bottomTitles,
                                                  ),
                                                ),
                                                leftTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    reservedSize: 60,
                                                    showTitles: true,
                                                    getTitlesWidget: leftTitles,
                                                  ),
                                                ),
                                              ),
                                              barTouchData: BarTouchData(
                                                  enabled: true,
                                                  handleBuiltInTouches: false,
                                                  touchCallback:
                                                      (event, response) {
                                                    if (response != null &&
                                                        event is FlTapUpEvent) {
                                                      setState(() {
                                                        final x = response.spot!
                                                            .touchedBarGroup.x;
                                                        final isShowing =
                                                            showingAmountTooltip ==
                                                                x;
                                                        if (isShowing) {
                                                          showingAmountTooltip =
                                                              -1;
                                                        } else {
                                                          showingAmountTooltip =
                                                              x;
                                                        }
                                                      });
                                                    }
                                                  }))),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // BarChart(BarChartData())
                                ]),
                                Column(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF4C164B),
                                        borderRadius: BorderRadius.circular(2)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        '  Daily Book Status Chart  ',
                                        style: TextStyle(
                                          color: Color(0xFFE8E1C9),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: const Color(0xFF4C164B),
                                              width: 3)),
                                      height: 224.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AspectRatio(
                                          aspectRatio: 2.0,
                                          child: BarChart(BarChartData(
                                              barGroups: List.generate(
                                                dashboardState
                                                    .bookCountList.length,
                                                (index) =>
                                                    generateBookGroupData(
                                                  index,
                                                  dashboardState
                                                          .bookCountList[index]
                                                      ['book_count'],
                                                ),
                                              ),
                                              titlesData: FlTitlesData(
                                                show: true,
                                                topTitles: const AxisTitles(
                                                  sideTitles: SideTitles(
                                                      showTitles: false),
                                                ),
                                                rightTitles: const AxisTitles(
                                                  sideTitles: SideTitles(
                                                      showTitles: false),
                                                ),
                                                bottomTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: true,
                                                    getTitlesWidget:
                                                        bottomTitles,
                                                  ),
                                                ),
                                                leftTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    reservedSize: 60,
                                                    showTitles: true,
                                                    getTitlesWidget: leftTitles,
                                                  ),
                                                ),
                                              ),
                                              barTouchData: BarTouchData(
                                                  enabled: true,
                                                  handleBuiltInTouches: false,
                                                  touchCallback:
                                                      (event, response) {
                                                    if (response != null &&
                                                        event is FlTapUpEvent) {
                                                      setState(() {
                                                        final x = response.spot!
                                                            .touchedBarGroup.x;
                                                        final isShowing =
                                                            showingBookTooltip ==
                                                                x;
                                                        if (isShowing) {
                                                          showingBookTooltip =
                                                              -1;
                                                        } else {
                                                          showingBookTooltip =
                                                              x;
                                                        }
                                                      });
                                                    }
                                                  }))),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // BarChart(BarChartData())
                                ])
                              ],
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SampleCard extends StatelessWidget {
  _SampleCard({required this.cardName, required this.cardContext});

  String cardName;
  String cardContext;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF4C164B)),
      width: 320.0,
      height: 100,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                cardName,
                style: const TextStyle(color: Color(0xFFE8E1C9)),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  cardContext,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFFE8E1C9)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
