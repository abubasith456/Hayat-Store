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

class RegisterUsernameOnChangedEvent extends RegisterEvent {
  String userName;

  RegisterUsernameOnChangedEvent(this.userName);

  @override
  List<Object> get props => [userName];
}

class RegisterEmailOnChangedEvent extends RegisterEvent {
  String email;

  RegisterEmailOnChangedEvent(this.email);

  @override
  List<Object> get props => [email];
}

class RegisterPasswordOnChangedEvent extends RegisterEvent {
  String password;

  RegisterPasswordOnChangedEvent(this.password);

  @override
  List<Object> get props => [password];
}

class RegisterCnfrmPasswordOnChangedEvent extends RegisterEvent {
  String cnfrmPassword;
  String password;
  RegisterCnfrmPasswordOnChangedEvent(this.cnfrmPassword, this.password);

  @override
  List<Object> get props => [cnfrmPassword];
}

class RegisterMobileNumOnChangedEvent extends RegisterEvent {
  String mobileNumber;

  RegisterMobileNumOnChangedEvent(this.mobileNumber);

  @override
  List<Object> get props => [mobileNumber];
}

class RegisterDOBOnChangedEvent extends RegisterEvent {
  String dob;

  RegisterDOBOnChangedEvent(this.dob);

  @override
  List<Object> get props => [dob];
}

class RegisterAddressOnChangedEvent extends RegisterEvent {
  String address;

  RegisterAddressOnChangedEvent(this.address);

  @override
  List<Object> get props => [address];
}
