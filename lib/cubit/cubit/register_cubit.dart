import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  RegisterCubit()
      : super(RegisterCubitState(
            email: '',
            userame: '',
            password: '',
            cnfrmPassword: '',
            dateOfBirth: '',
            mobilenumber: ''));

  void username(String username) => emit(state.copyWith(userame: username));
  void email(String email) => emit(state.copyWith(email: email));
  void password(String password) => emit(state.copyWith(password: password));
  void cnfrmPassword(String cnfrmPassword) =>
      emit(state.copyWith(cnfrmPassword: cnfrmPassword));
  void dateOfBirth(String dob) => emit(state.copyWith(dateOfBirth: dob));
  void mobileNumber(String mobileNumber) =>
      emit(state.copyWith(mobilenumber: mobileNumber));

  void setRegsiterValue(RegisterCubitState registerState) => emit(
        state.copyWith(
            email: registerState.email,
            userame: registerState.userame,
            password: registerState.password,
            cnfrmPassword: registerState.cnfrmPassword,
            dateOfBirth: registerState.dateOfBirth,
            mobilenumber: registerState.mobilenumber),
      );
}
