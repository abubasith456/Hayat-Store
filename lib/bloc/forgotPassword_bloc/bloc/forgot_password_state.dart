part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordLoaded extends ForgotPasswordState {
  ForgotPasswordModel forgotPasswordModel;

  ForgotPasswordLoaded(this.forgotPasswordModel);

  @override
  List<Object> get props => [forgotPasswordModel];
}

class ForgotPasswordError extends ForgotPasswordState {
  String error;
  ForgotPasswordError(this.error);

  @override
  List<Object> get props => [error];
}
