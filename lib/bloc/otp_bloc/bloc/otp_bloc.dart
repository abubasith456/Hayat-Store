import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/db/userDB.dart';
import 'package:shop_app/models/response_model.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    ApiProvider _apiProvider = ApiProvider();
    on<OtpEvent>((event, emit) async {
      if (event is OtpEndEvent) {
        emit(OtpEndState());
      }
      if (event is OtpVerifyButtonPressedEvent) {
        emit(OtpVerificationLoadingState());

        var requestBody = {
          "email": event.email,
          "otp": event.otp,
        };
        var result = await _apiProvider.verifyOtp(requestBody);

        if (result.status == 400) {
          emit(OtpVerificationErrorState(result.message!));
        } else {
          emit(OtpVerificationLoadedState(result));
        }
      }

      if (event is OtpValidationEvent) {
        if (event.value.length == 4) {
          emit(OtpFieldValidateSuccessState());
          print("OtpFieldValidateSuccessState called");
        } else {
          emit(OtpFieldValidatedFailedState());
          print("OtpFieldValidatedFailedState called");
        }
      }
    });
  }
}
