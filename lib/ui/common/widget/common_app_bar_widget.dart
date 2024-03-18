import 'package:admin_web_app/ui/widget/button_widget.dart';
import 'package:flutter/material.dart';

class CommonAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CommonAppBarWidget({
    super.key,
    required this.title,
    required this.email,
    required this.signOutFunction,
  });

  final String title;
  final String email;
  final Function() signOutFunction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1E082E),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Color(0xFFE8E1C9)),
      ),
      actions: [
        Text(
          email,
        ),
        const SizedBox(
          width: 8.0,
        ),
        ButtonWidget(
          onTap: () {
            signOutFunction();
          },
          text: 'SignOut',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
