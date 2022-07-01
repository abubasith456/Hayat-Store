part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  String email;
  String password;
  String cnfrmPassword;
  String username;
  String mobileNumber;
  String dateOfBirth;

  RegisterButtonPressed(
      {required this.email,
      required this.password,
      required this.cnfrmPassword,
      required this.username,
      required this.mobileNumber,
      required this.dateOfBirth});
}
