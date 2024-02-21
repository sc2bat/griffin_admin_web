import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final List<String> menuList = [
  'dashboard',
  'flights',
  'airports',
  'reservation',
  'usermanage',
  'payment',
];

Widget logoImage(context) {
  return GestureDetector(
    onTap: () => context.push('/dashboard'),
    child: Container(
      constraints: const BoxConstraints(
        minWidth: 160.0,
        minHeight: 160.0,
        maxWidth: 200.0,
        maxHeight: 200.0,
      ),
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.black54,
        ),
      ),
      child: Image.asset('assets/images/common/logo_sample.png'),
    ),
  );
}

List<Widget> menuWidgetList(List<String> menuList, BuildContext context) {
  return List.generate(
    menuList.length,
    (index) {
      return GestureDetector(
        onTap: () => context.push('/${menuList[index]}'),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 160.0,
            maxWidth: 200.0,
          ),
          width: MediaQuery.of(context).size.width * 0.2,
          height: 50.0,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Colors.black54,
            ),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.home,
                ),
              ),
              Text(menuList[index]),
            ],
          ),
        ),
      );
    },
  );
}
