import 'package:flutter/material.dart';

class MyBehaviour extends ScrollBehavior {
  @override
  Widget viewPortChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
