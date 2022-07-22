// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class LoadedState extends LoginState {
  LoginModel loginModel;

  LoadedState(this.loginModel);

  @override
  List<Object> get props => [loginModel];
}

class ErrorState extends LoginState {
  String error;

  ErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// class LoginFieldValidateState extends LoginState {
//   final String emailError;
//   final String passwordError;
//   final bool emailIsEmpty;
//   final bool passwordIsEmpty;
//   LoginFieldValidateState(
//       {this.emailIsEmpty = false,
//       this.passwordIsEmpty = false,
//       this.emailError = "",
//       this.passwordError = ""});

//   LoginFieldValidateState copyWith({
//     String? emailError,
//     String? passwordError,
//     bool? emailIsEmpty,
//     bool? passwordIsEmpty,
//   }) {
//     return LoginFieldValidateState(
//       emailError: emailError ?? this.emailError,
//       passwordError: passwordError ?? this.passwordError,
//       emailIsEmpty: emailIsEmpty ?? this.emailIsEmpty,
//       passwordIsEmpty: passwordIsEmpty ?? this.passwordIsEmpty,
//     );
//   }

//   @override
//   List<Object> get props =>
//       [emailError, passwordError, emailIsEmpty, passwordIsEmpty];
// }

//Email Field
class LoginEmailFieldValidateState extends LoginState {
  final String emailError;
  final bool emailValidated;
  LoginEmailFieldValidateState({
    this.emailError = "",
    this.emailValidated = false,
  });

  LoginEmailFieldValidateState copyWith({
    String? emailError,
    bool? emailValidated,
  }) {
    return LoginEmailFieldValidateState(
      emailError: emailError ?? this.emailError,
      emailValidated: emailValidated ?? this.emailValidated,
    );
  }

  @override
  List<Object> get props => [emailError, emailValidated];
}

//Password Field
class LoginPasswordFieldValidateState extends LoginState {
  final String passwordError;
  final bool passwordValidated;
  LoginPasswordFieldValidateState({
    this.passwordValidated = false,
    this.passwordError = "",
  });

  LoginPasswordFieldValidateState copyWith({
    String? passwordError,
    bool? passwordValidated,
  }) {
    return LoginPasswordFieldValidateState(
      passwordError: passwordError ?? this.passwordError,
      passwordValidated: passwordValidated ?? this.passwordValidated,
    );
  }

  @override
  List<Object> get props => [passwordError, passwordValidated];
}
