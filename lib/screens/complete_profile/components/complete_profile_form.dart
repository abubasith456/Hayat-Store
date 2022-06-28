import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/register_bloc/register_bloc.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/cubit/cubit/register_cubit.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';

import '../../../bloc/login_bloc/bloc/login_bloc.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../util/shared_pref.dart';
import '../../home/home_screen.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  String? dateOfBirth;
  var sharedPref = SharedPref();

  bool isLoading = false;

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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<RegisterCubit, RegisterCubitState>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) => RegisterBloc(context),
            child: Column(
              children: [
                buildFirstNameFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildLastNameFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPhoneNumberFormField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildDateOfBirthFormField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildAddressFormField(),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(40)),
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
                        sharedPref.setBoolValue(loggedKey, true);
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
                      text: "continue",
                      isLoading: isLoading,
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          String username = firstName!;
                          BlocProvider.of<RegisterBloc>(context).add(
                              RegisterButtonPressed(
                                  username: username,
                                  dateOfBirth: dateOfBirth!,
                                  mobileNumber: phoneNumber!));
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
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
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        } else if (value.isEmpty && phoneNumber?.length.toInt() != 10) {
          addError(error: mobileNumberErrorLength);
        } else {
          phoneNumber = value;
        }
        return null;
      },
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

  TextFormField buildDateOfBirthFormField() {
    return TextFormField(
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

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name (optional)",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        firstName = value;
        print("Abu " + value);
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        } else {
          firstName = value;
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
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
