import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/change_pswd_bloc/bloc/change_password_bloc.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/util/custom_snackbar.dart';
import 'package:shop_app/util/error_show_field.dart';
import 'package:shop_app/util/size_config.dart';

import '../../../components/custom_surfix_icon.dart';

class ChangePasswordForm extends StatefulWidget {
  ChangePasswordForm(this.email);

  String email;

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();

  var newPasswordController = TextEditingController();
  var newConfirmPasswordController = TextEditingController();

  String newPasswordError = "";
  String cnfrmNewPasswordError = "";

  bool newPasswordValidated = false;
  bool cnfrmNewPasswordValidated = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordLoadingState) {
          isLoading = true;
        } else if (state is ChangePasswordLoadedState) {
          isLoading = false;
          showSnackBar(
              context: context,
              text: state.changePasswordRes.message!,
              type: TopSnackBarType.success);
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => SignInScreen())),
          );
        } else if (state is ChangePasswordErrorState) {
          isLoading = false;
          showSnackBar(
              context: context,
              text: state.error,
              type: TopSnackBarType.success);
        }

        if (state is NewPasswordFieldState) {
          newPasswordError = state.newPasswordError;
          newPasswordValidated = state.newPasswordValidated;
          if (!newPasswordValidated) {
            newConfirmPasswordController.text = '';
            cnfrmNewPasswordError = "";
          }
        } else if (state is ConfirmNewPasswordFieldState) {
          cnfrmNewPasswordError = state.cnfrmNewPasswordError;
          cnfrmNewPasswordValidated = state.cnfrmNewPasswordValidated;
        }
      },
      builder: ((context, state) {
        return Column(
          children: [
            buildnewPassFormField(context),
            SizedBox(
              height: 5,
            ),
            newPasswordError != ""
                ? formErrorText(error: newPasswordError)
                : SizedBox(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildcnfrmNewPassFormField(context, newPasswordValidated),
            SizedBox(
              height: 5,
            ),
            cnfrmNewPasswordError != ""
                ? formErrorText(error: cnfrmNewPasswordError)
                : SizedBox(),
            SizedBox(height: getProportionateScreenHeight(20)),
            DefaultButton(
              isLoading: isLoading,
              isEnabled: (newPasswordValidated && cnfrmNewPasswordValidated),
              text: "Change password",
              press: () {
                print(widget.email);
                BlocProvider.of<ChangePasswordBloc>(context).add(
                    ChangepasswordButtonPressedEvent(
                        widget.email,
                        newPasswordController.text,
                        newConfirmPasswordController.text));
              },
            )
          ],
        );
      }),
    );
  }

  TextFormField buildnewPassFormField(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: newPasswordController,
      onChanged: (value) {
        BlocProvider.of<ChangePasswordBloc>(context)
            .add(NewPasswordOnChangeEvent(value));
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "New Password",
        hintText: "Enter your new password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildcnfrmNewPassFormField(BuildContext context, bool enabled) {
    return TextFormField(
      obscureText: true,
      enabled: enabled,
      controller: newConfirmPasswordController,
      onChanged: (value) {
        BlocProvider.of<ChangePasswordBloc>(context).add(
            ConfirmNewPasswordOnChangeEvent(value, newPasswordController.text));
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: "Confirm new Password",
        hintText: "Re-enter your new password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
