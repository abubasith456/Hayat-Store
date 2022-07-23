part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangepasswordButtonPressedEvent extends ChangePasswordEvent {
  String email;
  String newPassword;
  String cnfrmNewPassword;
  ChangepasswordButtonPressedEvent(
      this.email, this.newPassword, this.cnfrmNewPassword);

  @override
  List<Object> get props => [email, newPassword, cnfrmNewPassword];
}

class NewPasswordOnChangeEvent extends ChangePasswordEvent {
  String newPassword;
  NewPasswordOnChangeEvent(this.newPassword);
  @override
  List<Object> get props => [newPassword];
}

class ConfirmNewPasswordOnChangeEvent extends ChangePasswordEvent {
  String newPassword;
  String cnfrmNewPassword;

  ConfirmNewPasswordOnChangeEvent(this.cnfrmNewPassword, this.newPassword);
  @override
  List<Object> get props => [cnfrmNewPassword, newPassword];
}
