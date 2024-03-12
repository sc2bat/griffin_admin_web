import 'dart:async';

import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:admin_web_app/ui/common/enums.dart';
import 'package:admin_web_app/ui/dashboard/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  StreamSubscription? _stremSubscription;
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
    super.initState();
  }

  @override
  void dispose() {
    _stremSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardViewModel = context.watch<DashboardViewModel>();
    final dashboardState = dashboardViewModel.dashboardState;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GRIFFIN ADMIN WEB PAGE'),
        actions: [
          Text(dashboardState.accountModel?.email ?? ''),
          const SizedBox(
            width: 8.0,
          ),
          ElevatedButton(
            onPressed: () {
              dashboardViewModel.signOut();
            },
            child: const Text('SignOut'),
          ),
        ],
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
                                cardContext: dashboardState.bookList
                                    .where((e) => e.payStatus == 1)
                                    .map((e) => e.payAmount)
                                    .toList()
                                    .fold(0.0,
                                        (value, element) => value + element)
                                    .toString(),
                              )),
                          Card(
                              child: _SampleCard(
                                cardName: 'Total Book Count',
                                cardContext: dashboardState.bookList
                                    .where((e) => e.payStatus == 1)
                                    .length
                                    .toString(),
                              )),
                          Card(
                              child: _SampleCard(
                                cardName: 'Today Book',
                                cardContext: dashboardState.bookList
                                    .where((e) =>
                                e.createdAt.toString() ==
                                    dashboardState.date)
                                    .length
                                    .toString(),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(' - 일별 수익금 차트'),
                              Card(
                                  child:
                                  _SampleChart(chartName: 'chart 1')),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(' - 일별 예약현황 차트'),
                              Card(
                                  child:
                                  _SampleChart(chartName: 'chart 2')),
                            ],
                          ),
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
    return SizedBox(
      width: 320.0,
      height: 100,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [Text(cardName), Text(cardContext)],
          ),
        ),
      ),
    );
  }
}

class _SampleChart extends StatelessWidget {
  const _SampleChart({required this.chartName});

  final String chartName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.0,
      height: 100,
      child: Center(
        child: Text(chartName),
      ),
    );
  }
}

