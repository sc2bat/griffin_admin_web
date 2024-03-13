import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function() onTap;
  final String text;

  const ButtonWidget({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFF4C164B),
      )),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFFE8E1C9)),
      ),
    );
  }
}
