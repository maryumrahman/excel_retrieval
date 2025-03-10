import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationHelper {
  static final bool _isIOS = Platform.isIOS;

  static Route _buildRoute(Widget targetClass) {
    return _isIOS
        ? CupertinoPageRoute(builder: (context) => targetClass)
        : MaterialPageRoute(builder: (context) => targetClass);
  }

  static Future push(BuildContext context, Widget targetClass) {
    return Navigator.of(context).push(_buildRoute(targetClass));
  }

  static pushReplacement(BuildContext context, Widget targetClass) {
    return Navigator.of(context).pushReplacement(_buildRoute(targetClass));
  }

  static pop(BuildContext context) => Navigator.pop(context);
}
