part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  String username;
  String mobileNumber;
  String dateOfBirth;

  RegisterButtonPressed(
      {required this.username,
      required this.mobileNumber,
      required this.dateOfBirth});
}
