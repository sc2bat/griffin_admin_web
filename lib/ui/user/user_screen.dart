import 'package:admin_web_app/ui/common/common.dart';
import 'package:admin_web_app/ui/user/user_state.dart';
import 'package:admin_web_app/ui/user/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    Future.microtask(() {
      final UserViewModel userViewModel = context.read<UserViewModel>();

      // userViewModel.getUserList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserViewModel userViewModel = context.watch();
    final UserState userState = userViewModel.state;
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
            child: Column(
              children: [
                logoImage(context),
                ...menuWidgetList(menuList, context),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: 10,
                // itemCount: userState.userList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('$index'),
                    onTap: () {},
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
