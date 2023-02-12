import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/services/permission/permission.dart';
import 'package:shop_app/util/adaptive_dialog.dart';

import '../../bloc/login_bloc/bloc/login_bloc.dart';
import '../../util/size_config.dart';
import 'components/body.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  LoginBloc _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => _loginBloc,
      lazy: false,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            leading: SizedBox(),
            title: Text("Sign In"),
          ),
          body: Body(),
        ),
      ),
    );
  }
}
