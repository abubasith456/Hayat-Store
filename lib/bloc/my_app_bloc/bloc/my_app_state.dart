part of 'my_app_bloc.dart';

abstract class MyAppState extends Equatable {
  const MyAppState();

  @override
  List<Object> get props => [];
}

class MyAppInitial extends MyAppState {}

class LoadingMyAppState extends MyAppState {}

class LoadedMyAppState extends MyAppState {
  bool isLogged;
  bool isNotShowWelcomScreen;

  LoadedMyAppState(this.isLogged, this.isNotShowWelcomScreen);
}

class ErrorMyAppState extends MyAppState {
  String error;
  ErrorMyAppState(this.error);
}
