import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      width: MediaQuery.of(context).size.width,
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
  TextEditingController emailController = TextEditingController();
  String? email;
  String emailError = "";
  bool isEnabled = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordLoaded) {
          print(state.forgotPasswordModel.status);
          isLoading = false;
          if (state.forgotPasswordModel.status == 200) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtpScreen(
                    email: emailController.text,
                  ),
                ));
          } else {
            showOkAlertDialog(
              title: "Alert",
              message: state.forgotPasswordModel.message,
              context: context,
              onWillPop: () async => false,
              barrierDismissible: false,
            );
          }
        } else if (state is ForgotPasswordLoading) {
          isLoading = true;
        } else if (state is ForgotPasswordError) {
          isLoading = false;
          showOkAlertDialog(
            title: "Alert",
            message: state.error,
            context: context,
            onWillPop: () async => false,
            barrierDismissible: false,
          );
        }
        if (state is EmailFieldValidateState) {
          emailError = state.emailError;
          isEnabled = state.emailValidated;
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                onSaved: (newValue) => email = newValue,
                onChanged: (value) {
                  BlocProvider.of<ForgotPasswordBloc>(context)
                      .add(EmailChangedEvent(value));
                  // if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                  //   setState(() {
                  //     errors.remove(kEmailNullError);
                  //   });
                  // } else if (emailValidatorRegExp.hasMatch(value) &&
                  //     errors.contains(kInvalidEmailError)) {
                  //   setState(() {
                  //     errors.remove(kInvalidEmailError);
                  //   });
                  // }
                  // return null;
                },
                // validator: (value) {
                //   if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                //     setState(() {
                //       errors.add(kEmailNullError);
                //     });
                //   } else if (!emailValidatorRegExp.hasMatch(value) &&
                //       !errors.contains(kInvalidEmailError)) {
                //     setState(() {
                //       errors.add(kInvalidEmailError);
                //     });
                //   } else {
                //     setState(() {
                //       email = value;
                //     });
                //   }
                //   return null;
                // },
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
              SizedBox(height: getProportionateScreenHeight(5)),
              emailError != "" ? formErrorText(error: emailError) : SizedBox(),
              SizedBox(height: getProportionateScreenHeight(30)),
              // FormError(errors: errors),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              DefaultButton(
                isEnabled: isEnabled,
                text: "Continue",
                isLoading: isLoading,
                press: () {
                  if (_formKey.currentState!.validate()) {
                    // Do what you want to do
                    print("Button Clicked");
                    BlocProvider.of<ForgotPasswordBloc>(context).add(
                      ForgotPasswordButtonPressedEvent(
                          context: context, email: emailController.text),
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

  Padding formErrorText({required String error}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/Error.svg",
            height: getProportionateScreenWidth(14),
            width: getProportionateScreenWidth(14),
          ),
          SizedBox(
            width: getProportionateScreenWidth(10),
          ),
          Text(
            error,
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
