// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_web_app/data/model/user_model.dart';
import 'package:admin_web_app/ui/user/user_state.dart';
import 'package:admin_web_app/ui/user/user_view_model.dart';
import 'package:admin_web_app/utils/simple_logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/common_menu_list_widget.dart';

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

    final List<UserModel> dumpUsers = List.generate(
      40,
      (index) => UserModel(
          userId: index,
          email: '$index@naver.com',
          userName: 'name_$index',
          isDeleted: 0),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('GRIFFIN ADMIN WEB PAGE'),
        ),
      ),
      body: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CommonMenuListWidget(),
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: PaginatedDataTable(
                  columns: [
                    const DataColumn(
                      label: Text('No.'),
                    ),
                    DataColumn(
                      label: const Text('userId'),
                      onSort: (columnIndex, ascending) {},
                    ),
                    const DataColumn(
                      label: Text('email'),
                    ),
                    const DataColumn(
                      label: Text('name'),
                    ),
                    const DataColumn(
                      label: Text('활성화'),
                    ),
                    const DataColumn(
                      label: Text('수정'),
                    ),
                    const DataColumn(
                      label: Text('삭제'),
                    ),
                  ],
                  source: _UserData(context, dumpUsers),
                ),
              ),
            ),
          ),
        ],
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
        ),
      ),
      DataCell(
        IconButton(
          onPressed: () {
            logger.info('press delete button ${item.userId}');
          },
          icon: const Icon(
            Icons.delete,
          ),
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
