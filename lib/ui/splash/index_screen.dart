import 'package:admin_web_app/ui/common/common_menu_list_widget.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
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
              child: const Center(
                child: Text('center'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
