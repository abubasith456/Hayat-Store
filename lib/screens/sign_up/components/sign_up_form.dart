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
  String? email;
  String? usernmae;
  String? password;
  String? conform_password;
  String? mobileNumber;
  String? username;
  // String? lastName;
  String? phoneNumber;
  String? address;
  String? dateOfBirth;
  bool remember = false;
  var emailConroller = TextEditingController();
  var passwordController = TextEditingController();
  var cnfrmPassController = TextEditingController();
  var DOBcontroller = TextEditingController();
  var sharedPref = SharedPref();
  bool isLoading = false;
  final List<String?> errors = [];

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formattedDate = formatter.format(now);

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
                SizedBox(height: getProportionateScreenHeight(20)),
                buildUserNameFormField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                // buildLastNameFormField(),
                // SizedBox(height: getProportionateScreenHeight(30)),
                buildPhoneNumberFormField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildDateOfBirthFormField(context),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildAddressFormField(),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) async {
                    if (state is RegsiterError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                        ),
                      );
                      setState(() {
                        isLoading = false;
                      });
                    } else if (state is RegisterLoading) {
                      print('Loading.....');
                    } else if (state is RegisterLoaded) {
                      if (state.registerModel.status == 200) {
                        //For loogged state
                        sharedPref.setBoolValue(loggedKey, true);
                        //Store local DB
                        var user = User(
                            userId: state.registerModel.userData!.userId!
                                .toString(),
                            password: password!,
                            email: email!,
                            name: username!);
                        UserDb.instance.create(user);
                        //Home naviogator
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      } else if (state.registerModel.status == 400) {
                        setState(() {
                          isLoading = false;
                        });
                        showDialog(
                            context, 'Failed', state.registerModel.message!);
                        setState(() {
                          isLoading = false;
                        });
                      }
                    } else if (state is RegsiterError) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  builder: (context, state) {
                    return DefaultButton(
                      text: "Register",
                      isLoading: isLoading,
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                            errors.clear();
                          });

                          //Bloc called
                          String username = this.username!;
                          BlocProvider.of<RegisterBloc>(context).add(
                              RegisterButtonPressed(
                                  email: email!,
                                  password: passwordController.text,
                                  cnfrmPassword: cnfrmPassController.text,
                                  username: username,
                                  dateOfBirth: dateOfBirth!,
                                  mobileNumber: phoneNumber!));
                        }
                      },
                    );
                  },
                ),
                // DefaultButton(
                //   text: "Continue",
                //   isLoading: false,
                //   press: () {
                //     if (_formKey.currentState!.validate()) {
                //       _formKey.currentState!.save();
                //       // if all are valid then go to success screen
                //       setValue('email', email!);
                //       setValue('password', password!);
                //       setValue('cnfrmPassword', conform_password!);

                //       clearField();
                //       Navigator.pushNamed(
                //           context, CompleteProfileScreen.routeName);
                //     }
                //   },
                // ),
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
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        } else {
          conform_password = value;
          return null;
        }
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
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        } else {
          password = value;
          return null;
        }
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
      textInputAction: TextInputAction.next,
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

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        } else {
          address = value;
        }
        return null;
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

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        } else if (value.isNotEmpty && phoneNumber?.length.toInt() == 10) {
          removeError(error: mobileNumberErrorLength);
        } else if (value.length != 10) {
          addError(error: mobileNumberErrorLength);
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        } else if (value.length != 10) {
          addError(error: mobileNumberErrorLength);
          return "";
        } else {
          phoneNumber = value;
        }
        return null;
      },
      maxLength: 10,
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
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
        setState(() {
          if (newDate != null) {
            DOBcontroller.text = DateFormat('yyyy-MM-dd').format(newDate);
          }
        });
      },
      showCursor: false,
      enabled: true,
      controller: DOBcontroller,
      onSaved: (newValue) => dateOfBirth = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: dateOfError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: dateOfError);
          return "";
        } else {
          dateOfBirth = value;
        }
        return null;
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

  // TextFormField buildLastNameFormField() {
  //   return TextFormField(
  //     onSaved: (newValue) => lastName = newValue,
  //     decoration: InputDecoration(
  //       labelText: "Last Name",
  //       hintText: "Enter your last name (optional)",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
  //     ),
  //   );
  // }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: usernameError);
        }
        username = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: usernameError);
          return "";
        } else {
          username = value;
        }

        return null;
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
