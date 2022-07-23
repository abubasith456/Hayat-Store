import 'package:flutter/material.dart';
import 'package:shop_app/screens/change_password_screen/components/change_pswd_form.dart';

import '../../../util/size_config.dart';

class Body extends StatefulWidget {
  Body(this.email);
  String email;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            Text(
              "Change Password",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(28),
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Please enter your new password",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.1),
            ChangePasswordForm(widget.email),
          ]),
        ),
      ),
    );
  }
}
