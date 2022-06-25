part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  RegisterModel registerModel;

  RegisterLoaded(this.registerModel);
}

class RegsiterError extends RegisterState {
  String error;
  RegsiterError(this.error);
}
