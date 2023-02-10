part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordLoaded extends ForgotPasswordState {
  ResponseModel forgotPasswordModel;

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

class EmailFieldValidateState extends ForgotPasswordState {
  final String emailError;
  final bool emailValidated;
  EmailFieldValidateState({
    this.emailError = "",
    this.emailValidated = false,
  });

  EmailFieldValidateState copyWith({
    String? emailError,
    bool? emailValidated,
  }) {
    return EmailFieldValidateState(
      emailError: emailError ?? this.emailError,
      emailValidated: emailValidated ?? this.emailValidated,
    );
  }

  @override
  List<Object> get props => [emailError, emailValidated];
}
