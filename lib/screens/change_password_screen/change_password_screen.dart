import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/change_pswd_bloc/bloc/change_password_bloc.dart';
import 'package:shop_app/screens/change_password_screen/components/body.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/util/size_config.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen(this.email, this.isFromOTP);

  String email;
  bool isFromOTP;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: ((context) => ChangePasswordBloc()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              if (isFromOTP) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => SignInScreen())),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          title: Text("Forgot Password"),
        ),
        body: Body(email),
      ),
    );
  }
}
