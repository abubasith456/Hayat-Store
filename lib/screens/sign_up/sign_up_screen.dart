import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/register_bloc/register_bloc.dart';
import 'package:shop_app/cubit/cubit/register_cubit.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  var _registerBloc = RegisterCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: Body(),
      ),
    );
  }
}
