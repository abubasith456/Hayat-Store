part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordLoadedState extends ChangePasswordState {
  ForgotPasswordModel changePasswordRes;

  ChangePasswordLoadedState(this.changePasswordRes);

  @override
  List<Object> get props => [changePasswordRes];
}

class ChangePasswordErrorState extends ChangePasswordState {
  String error;
  ChangePasswordErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class NewPasswordFieldState extends ChangePasswordState {
  final String newPasswordError;
  final bool newPasswordValidated;

  NewPasswordFieldState(
      {this.newPasswordError = "", this.newPasswordValidated = false});

  NewPasswordFieldState copyWith({
    String? newPasswordError,
    bool? newPasswordValidated,
  }) {
    return NewPasswordFieldState(
      newPasswordError: newPasswordError ?? this.newPasswordError,
      newPasswordValidated: newPasswordValidated ?? this.newPasswordValidated,
    );
  }

  @override
  List<Object> get props => [newPasswordError, newPasswordValidated];
}

class ConfirmNewPasswordFieldState extends ChangePasswordState {
  final String cnfrmNewPasswordError;
  final bool cnfrmNewPasswordValidated;

  ConfirmNewPasswordFieldState(
      {this.cnfrmNewPasswordError = "",
      this.cnfrmNewPasswordValidated = false});

  ConfirmNewPasswordFieldState copyWith({
    String? cnfrmNewPasswordError,
    bool? cnfrmNewPasswordValidated,
  }) {
    return ConfirmNewPasswordFieldState(
      cnfrmNewPasswordError:
          cnfrmNewPasswordError ?? this.cnfrmNewPasswordError,
      cnfrmNewPasswordValidated:
          cnfrmNewPasswordValidated ?? this.cnfrmNewPasswordValidated,
    );
  }

  @override
  List<Object> get props => [cnfrmNewPasswordError, cnfrmNewPasswordValidated];
}
