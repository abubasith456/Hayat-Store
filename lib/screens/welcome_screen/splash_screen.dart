import 'package:flutter/material.dart';
import 'package:shop_app/screens/welcome_screen/components/body.dart';
import 'package:shop_app/util/size_config.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
