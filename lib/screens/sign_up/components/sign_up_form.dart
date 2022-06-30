import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/bloc/register_bloc/register_bloc.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/models/temp_model.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';

import '../../../constants.dart';
import '../../../cubit/cubit/register_cubit.dart';
import '../../../util/size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? usernmae;
  String? password;
  String? conform_password;
  String? mobileNumber;
  String? dateOfBirth;
  bool remember = false;
  var emailConroller = TextEditingController();
  var passwordController = TextEditingController();
  var cnfrmPassController = TextEditingController();

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void dispose() {
    super.dispose();
    clearField();
  }

  clearField() {
    setState(() {
      cnfrmPassController.text = '';
      passwordController.text = '';
      emailConroller.text = '';
      email = '';
      password = '';
      conform_password = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<RegisterCubit, RegisterCubitState>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) => RegisterBloc(context),
            child: Column(
              children: [
                buildEmailFormField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                // builPhoneNumberFormField(),
                // SizedBox(height: getProportionateScreenHeight(20)),
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildConformPassFormField(),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                DefaultButton(
                  text: "Continue",
                  isLoading: false,
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      setValue('email', email!);
                      setValue('password', password!);
                      setValue('cnfrmPassword', conform_password!);

                      clearField();
                      Navigator.pushNamed(
                          context, CompleteProfileScreen.routeName);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void setValue(String key, String value) async {
    try {
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
      print(prefs.get('cnfrmPassword'));
    } catch (e) {
      print(e.toString());
    }
  }

  // TextFormField builPhoneNumberFormField() {
  //   return TextFormField(
  //     obscureText: false,
  //     keyboardType: TextInputType.number,
  //     onSaved: (newValue) => mobileNumber = newValue,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: mobileNumberError);
  //       } else if (value.isNotEmpty && mobileNumber?.length.toInt() == 10) {
  //         removeError(error: mobileNumberErrorLength);
  //       } else {
  //         mobileNumber = value;
  //       }
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: mobileNumberError);
  //         return "";
  //       } else if (value.isNotEmpty && mobileNumber?.length != 10) {
  //         addError(error: mobileNumberErrorLength);
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "Mobile Number",
  //       hintText: "Enter your mobile number",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Call.svg"),
  //     ),
  //   );
  // }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      controller: cnfrmPassController,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        } else {
          conform_password = value;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: passwordController,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        } else {
          password = value;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailConroller,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        } else {
          email = value;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
