part of 'register_cubit.dart';

// abstract class RegisterState extends Equatable {
//   const RegisterState();

//   @override
//   List<Object> get props => [];
// }

// class RegisterInitial extends RegisterState {}

class RegisterCubitState {
  late String userame;
  late String email;
  late String password;
  late String cnfrmPassword;
  late String dateOfBirth;
  late String mobilenumber;

  RegisterCubitState({
    required this.userame,
    required this.email,
    required this.password,
    required this.cnfrmPassword,
    required this.dateOfBirth,
    required this.mobilenumber,
  });

  RegisterCubitState copyWith(
      {userame, email, password, cnfrmPassword, dateOfBirth, mobilenumber}) {
    return RegisterCubitState(
      email: email ?? this.email,
      userame: userame ?? this.userame,
      password: password ?? this.password,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      cnfrmPassword: cnfrmPassword ?? this.cnfrmPassword,
      mobilenumber: mobilenumber ?? this.mobilenumber,
    );
  }
}
