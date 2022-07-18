part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class OtpEndEvent extends OtpEvent {}

class OtpVerifyButtonPressedEvent extends OtpEvent {
  String email;
  String otp;

  OtpVerifyButtonPressedEvent({required this.email, required this.otp});
}
