import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubit/cubit/register_cubit.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/models/temp_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  var apiCall = ApiProvider();
  RegisterBloc(BuildContext context) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      try {
        if (event is RegisterButtonPressed) {
          emit(RegisterLoading());

          Map<String, dynamic> mapRegister = {
            "email": event.email,
            "username": event.username,
            "dateOfBirth": event.dateOfBirth,
            "mobileNumber": event.mobileNumber,
            "password": event.password,
            "passwordConf": event.cnfrmPassword,
          };

          var regsierData = await apiCall.registerUser(mapRegister);

          emit(RegisterLoaded(regsierData));
        }

        if (event is RegisterEmailOnChangedEvent) {
          if (event.email == "") {
            emit(EmailFieldState()
                .copyWith(emailError: kEmailNullError, emailValidated: false));
          } else if (!emailValidatorRegExp.hasMatch(event.email)) {
            emit(EmailFieldState().copyWith(
                emailError: kInvalidEmailError, emailValidated: false));
          } else {
            emit(EmailFieldState()
                .copyWith(emailError: "", emailValidated: true));
          }
        }

        if (event is RegisterPasswordOnChangedEvent) {
          if (event.password == "") {
            emit(PasswordFieldState().copyWith(
                passwordError: kPassNullError, passwordValidated: false));
          } else if (event.password.length < 5) {
            emit(PasswordFieldState().copyWith(
                passwordError: kShortPassError, passwordValidated: false));
          } else {
            emit(PasswordFieldState()
                .copyWith(passwordError: "", passwordValidated: true));
          }
        }

        if (event is RegisterCnfrmPasswordOnChangedEvent) {
          if (event.password != event.cnfrmPassword) {
            emit(ConfrmPasswordFieldState().copyWith(
                cnfrmPasswordError: kcnfrmPassError,
                cnfrmPasswordValidated: false));
          } else {
            emit(ConfrmPasswordFieldState().copyWith(
                cnfrmPasswordError: "", cnfrmPasswordValidated: true));
          }
        }

        if (event is RegisterUsernameOnChangedEvent) {
          if (event.userName == "") {
            emit(UsernameFieldState().copyWith(
                usernameError: usernameError, usernameValidated: false));
          } else {
            emit(UsernameFieldState()
                .copyWith(usernameError: "", usernameValidated: true));
          }
        }

        if (event is RegisterMobileNumOnChangedEvent) {
          if (event.mobileNumber == "") {
            emit(MobileNumberFieldState().copyWith(
                mobileNumberError: kPhoneNumberNullError,
                mobileNumberValidated: false));
          } else if (event.mobileNumber.length < 10) {
            emit(MobileNumberFieldState().copyWith(
                mobileNumberError: mobileNumberErrorLength,
                mobileNumberValidated: false));
          } else {
            emit(MobileNumberFieldState()
                .copyWith(mobileNumberError: "", mobileNumberValidated: true));
          }
        }

        if (event is RegisterDOBOnChangedEvent) {
          if (event.dob == "") {
            emit(DOBFieldState()
                .copyWith(dobError: dateOfError, dobValidated: false));
          } else {
            emit(DOBFieldState().copyWith(dobError: "", dobValidated: true));
          }
        }

        if (event is RegisterAddressOnChangedEvent) {
          if (event.address == "") {
            emit(AddressFieldState().copyWith(
                addressError: kAddressNullError, addressValidated: false));
          } else {
            emit(AddressFieldState()
                .copyWith(addressError: "", addressValidated: true));
          }
        }
      } catch (e) {
        print(e.toString());
        emit(await RegsiterError(e.toString()));
      }
    });
  }
}
