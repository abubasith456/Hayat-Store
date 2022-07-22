import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/login_model.dart';

import '../../../api/api_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _provider = ApiProvider();

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        if (event is LoginUserEvent) {
          emit(LoadingState());
          var loginResponse =
              await _provider.loginUser(event.email, event.password);

          print("Login: " + loginResponse.toJson().toString());

          emit(LoadedState(loginResponse));
          if (loginResponse.error != null) {
            emit(ErrorState(loginResponse.error!));
          }
        }

        //Email Event
        if (event is LoginEmailChangedEvent) {
          if (event.email == "") {
            emit(LoginEmailFieldValidateState().copyWith(
                emailError: "Email is required please enter the value!",
                emailValidated: false));
          } else if (!emailValidatorRegExp.hasMatch(event.email)) {
            emit(LoginEmailFieldValidateState().copyWith(
                emailError: "Enter valid email!", emailValidated: false));
          } else {
            emit(LoginEmailFieldValidateState()
                .copyWith(emailError: "", emailValidated: true));
          }
        }

        //Password Event
        if (event is LoginPasswordChangedEvent) {
          if (event.password == "") {
            emit(LoginPasswordFieldValidateState().copyWith(
                passwordError: "Password is required please enter the value!",
                passwordValidated: false));
          } else if (event.password.length < 5) {
            emit(LoginPasswordFieldValidateState().copyWith(
                passwordError: "Password is not strong!",
                passwordValidated: false));
          } else {
            emit(LoginPasswordFieldValidateState()
                .copyWith(passwordError: "", passwordValidated: true));
          }
        }

        ///
        // if (event is LoginEmailFieldValidateEvent) {
        //   if (event.email.length != 0) {
        //     emit(LoginFieldValidateState().copyWith(emailIsEmpty: true));
        //     print("LoginEmailFieldValidateSuccessState called");
        //   } else {
        //     emit(LoginFieldValidateState().copyWith(emailIsEmpty: false));
        //     print("LoginEmailFieldValidateFailedState called");
        //   }
        // }

        // if (event is LoginPasswordFieldValidateEvent) {
        //   if (event.password.length != 0) {
        //     emit(LoginFieldValidateState().copyWith(passwordIsEmpty: true));
        //     print("LoginPasswordFieldValidateSuccessState called");
        //   } else {
        //     emit(LoginFieldValidateState().copyWith(passwordIsEmpty: false));
        //     print("LoginPasswordFieldValidateFailedState called");
        //   }
        // }
      } catch (e) {
        print(e);
        emit(ErrorState(e.toString()));
      }
    });
  }
}
