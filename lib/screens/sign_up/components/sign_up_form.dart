import 'dart:math';
import 'package:intl/intl.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/bloc/register_bloc/register_bloc.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/db/userDB.dart';
import 'package:shop_app/helper/keyboard.dart';
import 'package:shop_app/models/temp_model.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/util/error_show_field.dart';

import '../../../constants.dart';
import '../../../cubit/cubit/register_cubit.dart';
import '../../../models/user_db_model.dart';
import '../../../util/shared_pref.dart';
import '../../../util/size_config.dart';
import '../../home/home_screen.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  bool remember = false;
  var usernameController = TextEditingController();
  var emailConroller = TextEditingController();
  var passwordController = TextEditingController();
  var cnfrmPassController = TextEditingController();
  var mobilenumberController = TextEditingController();
  var dOBcontroller = TextEditingController();
  var addressController = TextEditingController();
  var sharedPref = SharedPref();

  String emailError = "";
  String usernmaeError = "";
  String passwordError = "";
  String conform_passwordError = "";
  String mobileNumberError = "";
  String usernameError = "";
  String phoneNumberError = "";
  String addressError = "";
  String dateOfBirthError = "";

  bool emailValidated = false;
  bool usernameValidated = false;
  bool passwordValidated = false;
  bool cnfrmPasswordValidated = false;
  bool mobileNumberValidated = false;
  bool dateOfBirthValidated = false;
  bool addressValidated = false;

  bool isLoading = false;
  final List<String?> errors = [];

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formattedDate = formatter.format(now);

  @override
  void dispose() {
    super.dispose();
    clearField();
  }

  clearField() {
    passwordController.text = '';
    emailConroller.text = '';
    cnfrmPassController.text = '';
    usernameController.text = '';
    mobilenumberController.text = '';
    addressController.text = '';
    dOBcontroller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocProvider(
        create: (context) => RegisterBloc(context),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) async {
            if (state is RegsiterError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
              isLoading = false;
            } else if (state is RegisterLoading) {
              print('Loading.....');
              isLoading = true;
            } else if (state is RegisterLoaded) {
              if (state.registerModel.status == 200) {
                isLoading = false;
                //For loogged state
                sharedPref.setBoolValue(loggedKey, true);
                //Store local DB
                var user = User(
                    userId: state.registerModel.userData!.userId!.toString(),
                    password: passwordController.text,
                    email: emailConroller.text,
                    name: usernameController.text);
                UserDb.instance.create(user);
                //Home naviogator
                Navigator.pushNamed(context, HomeScreen.routeName);
              } else if (state.registerModel.status == 400) {
                isLoading = false;
                showDialog(context, 'Failed', state.registerModel.message!);
              }
            }
            if (state is EmailFieldState) {
              emailError = state.emailError;
              emailValidated = state.emailValidated;
            } else if (state is UsernameFieldState) {
              usernameError = state.usernameError;
              usernameValidated = state.usernameValidated;
            } else if (state is PasswordFieldState) {
              passwordError = state.passwordError;
              passwordValidated = state.passwordValidated;
              if (!passwordValidated) {
                cnfrmPassController.text = '';
                conform_passwordError = "";
              }
            } else if (state is ConfrmPasswordFieldState) {
              conform_passwordError = state.cnfrmPasswordError;
              cnfrmPasswordValidated = state.cnfrmPasswordValidated;
            } else if (state is MobileNumberFieldState) {
              mobileNumberError = state.mobileNumberError;
              mobileNumberValidated = state.mobileNumberValidated;
            } else if (state is DOBFieldState) {
              dateOfBirthError = state.dobError;
              dateOfBirthValidated = state.dobValidated;
            } else if (state is AddressFieldState) {
              addressError = state.addressError;
              addressValidated = state.addressValidated;
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                buildUserNameFormField(context),
                SizedBox(
                  height: 5,
                ),
                usernameError != ""
                    ? formErrorText(error: usernameError)
                    : SizedBox(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildEmailFormField(context),
                SizedBox(
                  height: 5,
                ),
                emailError != ""
                    ? formErrorText(error: emailError)
                    : SizedBox(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildPasswordFormField(context),
                SizedBox(
                  height: 5,
                ),
                passwordError != ""
                    ? formErrorText(error: passwordError)
                    : SizedBox(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildConformPassFormField(context, passwordValidated),
                SizedBox(
                  height: 5,
                ),
                conform_passwordError != ""
                    ? formErrorText(error: conform_passwordError)
                    : SizedBox(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildMobileNumberFormField(context),
                SizedBox(
                  height: 5,
                ),
                mobileNumberError != ""
                    ? formErrorText(error: mobileNumberError)
                    : SizedBox(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildDateOfBirthFormField(context),
                SizedBox(
                  height: 5,
                ),
                dateOfBirthError != ""
                    ? formErrorText(error: dateOfBirthError)
                    : SizedBox(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildAddressFormField(context),
                SizedBox(
                  height: 5,
                ),
                addressError != ""
                    ? formErrorText(error: addressError)
                    : SizedBox(),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                DefaultButton(
                  isEnabled: (usernameValidated &&
                          emailValidated &&
                          passwordValidated &&
                          cnfrmPasswordValidated &&
                          mobileNumberValidated &&
                          dateOfBirthValidated &&
                          addressValidated)
                      ? true
                      : false,
                  text: "Register",
                  isLoading: isLoading,
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      //Bloc called
                      BlocProvider.of<RegisterBloc>(context).add(
                          RegisterButtonPressed(
                              email: emailConroller.text,
                              password: passwordController.text,
                              cnfrmPassword: cnfrmPassController.text,
                              username: usernameController.text,
                              dateOfBirth: dOBcontroller.text,
                              mobileNumber: passwordController.text));
                    }
                  },
                ),
              ],
            );
          },
        ),
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

  TextFormField buildConformPassFormField(BuildContext context, bool enbled) {
    return TextFormField(
      obscureText: true,
      enabled: enbled,
      controller: cnfrmPassController,
      onChanged: (value) {
        BlocProvider.of<RegisterBloc>(context).add(
            RegisterCnfrmPasswordOnChangedEvent(
                value, passwordController.text));
      },
      textInputAction: TextInputAction.next,
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

  TextFormField buildPasswordFormField(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: passwordController,
      onChanged: (value) {
        BlocProvider.of<RegisterBloc>(context)
            .add(RegisterPasswordOnChangedEvent(value));
      },
      textInputAction: TextInputAction.next,
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

  TextFormField buildEmailFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailConroller,
      onChanged: (value) {
        BlocProvider.of<RegisterBloc>(context)
            .add(RegisterEmailOnChangedEvent(value));
      },
      textInputAction: TextInputAction.next,
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

  TextFormField buildAddressFormField(BuildContext context) {
    return TextFormField(
      controller: addressController,
      onChanged: (value) {
        BlocProvider.of<RegisterBloc>(context)
            .add(RegisterAddressOnChangedEvent(value));
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your phone address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildMobileNumberFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: mobilenumberController,
      onChanged: (value) {
        BlocProvider.of<RegisterBloc>(context)
            .add(RegisterMobileNumOnChangedEvent(value));
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Mobile Number",
        hintText: "Enter your Mobile number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildDateOfBirthFormField(BuildContext context) {
    return TextFormField(
      onTap: () async {
        FocusScope.of(context).unfocus();
        KeyboardUtil.hideKeyboard(context);
        DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(1900),
          lastDate: DateTime(2030),
        );

        if (newDate != null) {
          dOBcontroller.text = DateFormat('yyyy-MM-dd').format(newDate);
          BlocProvider.of<RegisterBloc>(context).add(RegisterDOBOnChangedEvent(
              DateFormat('yyyy-MM-dd').format(newDate)));
        }
      },
      showCursor: false,
      enabled: true,
      controller: dOBcontroller,
      onChanged: (value) {
        BlocProvider.of<RegisterBloc>(context)
            .add(RegisterDOBOnChangedEvent(value));
      },
      decoration: InputDecoration(
        labelText: "Date Of Birth",
        hintText: "Enter Your Date Of Birth",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/calendar.svg"),
      ),
    );
  }

  TextFormField buildUserNameFormField(BuildContext context) {
    return TextFormField(
      controller: usernameController,
      onChanged: (value) {
        BlocProvider.of<RegisterBloc>(context)
            .add(RegisterUsernameOnChangedEvent(value));
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "User Name",
        hintText: "Enter your username",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Future<OkCancelResult> showDialog(
      BuildContext context, String title, String message) {
    return showOkAlertDialog(
      context: context,
      title: title,
      message: message,
    );
  }
}
