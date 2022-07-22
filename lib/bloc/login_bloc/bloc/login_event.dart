part of 'login_bloc.dart';

enum LoadingStatus {
  LOADING,
  LOADED,
}

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUserEvent extends LoginEvent {
  String email;
  String password;

  LoginUserEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginEmailChangedEvent extends LoginEvent {
  String email;
  LoginEmailChangedEvent(this.email);

  @override
  List<Object> get props => [email];
}

class LoginPasswordChangedEvent extends LoginEvent {
  String password;
  LoginPasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];
}
