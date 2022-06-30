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

  // @override
  // List<Object> get props => [loginModel];
}

class ErrorState extends LoginState {
  String error;

  ErrorState(this.error);

  // @override
  // List<Object> get props => [error];
}
