import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/response_model.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    ApiProvider _api = ApiProvider();
    on<ChangePasswordEvent>((event, emit) async {
      if (event is ChangepasswordButtonPressedEvent) {
        emit(ChangePasswordLoadingState());

        Map<String, dynamic> request = {
          "email": event.email,
          "newPassword": event.newPassword,
          "cnfrmNewPassword": event.cnfrmNewPassword
        };

        print(request);
        var _response = await _api.changePassword(request);

        if (_response.error != null) {
          emit(ChangePasswordErrorState(_response.error!));
        } else {
          emit(ChangePasswordLoadedState(_response));
        }
      }

      if (event is NewPasswordOnChangeEvent) {
        if (event.newPassword == "") {
          emit(NewPasswordFieldState().copyWith(
              newPasswordError: "Please enter the new password",
              newPasswordValidated: false));
        } else if (event.newPassword.length < 5) {
          emit(NewPasswordFieldState().copyWith(
              newPasswordError: kShortPassError, newPasswordValidated: false));
        } else {
          emit(NewPasswordFieldState()
              .copyWith(newPasswordError: "", newPasswordValidated: true));
        }
      }

      if (event is ConfirmNewPasswordOnChangeEvent) {
        if (event.cnfrmNewPassword == "") {
          emit(ConfirmNewPasswordFieldState().copyWith(
              cnfrmNewPasswordError: "Please enter the confirm password",
              cnfrmNewPasswordValidated: false));
        } else if (event.cnfrmNewPassword != event.newPassword) {
          emit(ConfirmNewPasswordFieldState().copyWith(
              cnfrmNewPasswordError: "Password not matched",
              cnfrmNewPasswordValidated: false));
        } else {
          emit(ConfirmNewPasswordFieldState().copyWith(
              cnfrmNewPasswordError: "", cnfrmNewPasswordValidated: true));
        }
      }
    });
  }
}
