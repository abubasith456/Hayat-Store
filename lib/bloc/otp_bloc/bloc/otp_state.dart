part of 'otp_bloc.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpEndState extends OtpState {}

class OtpVerificationLoadingState extends OtpState {}

class OtpVerificationLoadedState extends OtpState {
  ResponseModel otpModel;
  OtpVerificationLoadedState(this.otpModel);
  @override
  List<Object> get props => [otpModel];
}

class OtpVerificationErrorState extends OtpState {
  String error;

  OtpVerificationErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class OtpFieldValidateSuccessState extends OtpState {}

class OtpFieldValidatedFailedState extends OtpState {}
