import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/forgotPassword_bloc/bloc/forgot_password_bloc.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/components/no_account_text.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/util/size_config.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a OTP to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordLoaded) {
          showOkAlertDialog(
            title: "Alert",
            message: state.forgotPasswordModel.message!,
            context: context,
            onWillPop: () async => false,
            barrierDismissible: false,
            builder: (context, child) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpScreen(),
                  ));
            },
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => email = newValue,
                onChanged: (value) {
                  if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                    setState(() {
                      errors.remove(kEmailNullError);
                    });
                  } else if (emailValidatorRegExp.hasMatch(value) &&
                      errors.contains(kInvalidEmailError)) {
                    setState(() {
                      errors.remove(kInvalidEmailError);
                    });
                  }
                  return null;
                },
                validator: (value) {
                  if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                    setState(() {
                      errors.add(kEmailNullError);
                    });
                  } else if (!emailValidatorRegExp.hasMatch(value) &&
                      !errors.contains(kInvalidEmailError)) {
                    setState(() {
                      errors.add(kInvalidEmailError);
                    });
                  } else {
                    setState(() {
                      email = value;
                    });
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon:
                      CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              FormError(errors: errors),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              DefaultButton(
                text: "Continue",
                isLoading: state is ForgotPasswordLoaded ? false : true,
                press: () {
                  if (_formKey.currentState!.validate()) {
                    // Do what you want to do
                    BlocProvider.of<ForgotPasswordBloc>(context).add(
                      ForgotPasswordButtonPressed(
                          context: context, email: email!),
                    );
                  }
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              NoAccountText(),
            ],
          ),
        );
      },
    );
  }
}
