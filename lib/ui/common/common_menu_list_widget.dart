// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:admin_web_app/ui/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonMenuListWidget extends StatelessWidget {
  final BuildContext context;
  const CommonMenuListWidget({
    super.key,
    required this.context,
  });

  @override
  Widget build(_) {
    return SingleChildScrollView(
      child: Column(
        children: [
          logoImage(context),
          ...menuWidgetList(menuList, context),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> menuList = [
  {
    'menuid': '1',
    'name': 'dashboard',
    'icon': const Icon(Icons.home),
  },
  {
    'menuid': '2',
    'name': 'flights',
    'icon': const Icon(Icons.flight),
  },
  {
    'menuid': '3',
    'name': 'airports',
    'icon': const Icon(Icons.home),
  },
  {
    'menuid': '4',
    'name': 'reservation',
    'icon': const Icon(Icons.airplane_ticket_rounded),
  },
  {
    'menuid': '5',
    'name': 'usermanage',
    'icon': const Icon(Icons.supervised_user_circle),
  },
  {
    'menuid': '6',
    'name': 'payment',
    'icon': const Icon(Icons.payment),
  },
];

Widget logoImage(context) {
  double width = MediaQuery.of(context).size.width;
  return GestureDetector(
    onTap: () => context.go('/dashboard'),
    child: Container(
      constraints: BoxConstraints(
        minWidth: width > 500 ? 160.0 : 40,
        minHeight: width > 500 ? 160.0 : 40,
        maxWidth: 200.0,
        maxHeight: 200.0,
      ),
      width: width > 500 ? width * 0.2 : 56,
      height: width > 500 ? width * 0.2 : 56,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.black54,
        ),
      ),
      child: Image.asset(logoSampleImage),
    ),
  );
}

List<Widget> menuWidgetList(
    List<Map<String, dynamic>> menuList, BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return List.generate(
    menuList.length,
    (index) {
      return GestureDetector(
        onTap: () => context.go('/${menuList[index]['name']}'),
        child: Container(
          constraints: BoxConstraints(
            minWidth: width > 500 ? 160.0 : 40,
            maxWidth: 200.0,
          ),
          width: width > 500 ? width * 0.2 : 56.0,
          height: 50.0,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Colors.black54,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: menuList[index]['icon'],
              ),
              width > 500
                  ? Text(menuList[index]['name'].toUpperCase())
                  : const SizedBox(),
            ],
          ),
        ),
      );
    },
  );
}
