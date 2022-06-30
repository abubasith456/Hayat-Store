import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() async {
    // await _loginBloc.close().then((value) => print('Login page disposed'));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => _loginBloc,
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          title: Text("Sign In"),
        ),
        body: Body(),
      ),
    );
  }
}
