import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('GRIFFIN ADMIN WEB PAGE'),
        ),
      ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CommonMenuListWidget(context: context),
          ),
          Expanded(
            child: Container(
              child: const Column(
                children: [
                  Center(
                    child: Text('center'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
