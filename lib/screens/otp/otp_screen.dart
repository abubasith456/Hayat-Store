import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/otp_bloc/bloc/otp_bloc.dart';
import 'package:shop_app/util/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  OtpScreen({required this.email});
  String email;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => OtpBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("OTP Verification"),
        ),
        body: Body(email),
      ),
    );
  }
}
