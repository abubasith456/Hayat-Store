import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/response_model.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  var apiCall = ApiProvider();
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) async {
      try {
        if (event is ForgotPasswordButtonPressedEvent) {
          emit(ForgotPasswordLoading());
          Map<String, dynamic> forgotPassswordRequest = {
            "email": event.email,
          };
          var _forgotpasswordData = await apiCall.forgotPassword(
              forgotPassswordRequest, event.context);

          if (_forgotpasswordData.error != null) {
            emit(ForgotPasswordError(_forgotpasswordData.error.toString()));
          } else {
            emit(ForgotPasswordLoaded(_forgotpasswordData));
          }
        }

        if (event is EmailChangedEvent) {
          if (event.email == "") {
            emit(EmailFieldValidateState().copyWith(
                emailError: "Email is required please enter the value!",
                emailValidated: false));
          } else if (!emailValidatorRegExp.hasMatch(event.email)) {
            emit(EmailFieldValidateState().copyWith(
                emailError: "Enter valid email!", emailValidated: false));
          } else {
            emit(EmailFieldValidateState()
                .copyWith(emailError: "", emailValidated: true));
          }
        }
      } catch (e) {
        emit(ForgotPasswordError(e.toString()));
      }
    });
  }
}
