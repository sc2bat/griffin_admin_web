import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showCustomDialog(
  BuildContext context, {
  required String title,
  required String content,
  bool cancelable = true,
  bool isVisibleCancelButton = true,
  VoidCallback? confirmAction,
}) {
  showDialog(
      context: context,
      barrierDismissible: cancelable,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            if (isVisibleCancelButton)
              TextButton(onPressed: context.pop, child: const Text('취소')),
            TextButton(
                onPressed: () {
                  context.pop();
                  confirmAction?.call();
                },
                child: const Text('확인'))
          ],
        );
      });
}

String formatDate(DateTime dateTime) {
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  String day = dateTime.day.toString();
  String hour = dateTime.hour.toString();
  String minute = dateTime.minute.toString();

  return '$year년 $month월 $day일 $hour시 $minute분';
}
