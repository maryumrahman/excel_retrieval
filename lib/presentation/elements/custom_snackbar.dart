import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message,
    {int seconds = 2, Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      hitTestBehavior: HitTestBehavior.translucent,
      content: Text(message),
      duration: Duration(seconds: seconds),
      backgroundColor: color ?? Theme.of(context).primaryColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Customize border radius
      ),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}
