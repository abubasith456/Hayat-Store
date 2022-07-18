import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/models/forgot_pswd_model.dart';

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
      } catch (e) {
        emit(ForgotPasswordError(e.toString()));
      }
    });
  }
}
