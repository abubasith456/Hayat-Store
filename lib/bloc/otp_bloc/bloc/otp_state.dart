part of 'otp_bloc.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpEndState extends OtpState {}

class OtpVerificationLoadingState extends OtpState {}

class OtpVerificationLoadedState extends OtpState {}
