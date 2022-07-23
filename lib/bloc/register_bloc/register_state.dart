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

class EmailFieldState extends RegisterState {
  final String emailError;
  final bool emailValidated;
  EmailFieldState({
    this.emailError = "",
    this.emailValidated = false,
  });

  EmailFieldState copyWith({
    String? emailError,
    bool? emailValidated,
  }) {
    return EmailFieldState(
      emailError: emailError ?? this.emailError,
      emailValidated: emailValidated ?? this.emailValidated,
    );
  }

  @override
  List<Object> get props => [emailError, emailValidated];
}

class PasswordFieldState extends RegisterState {
  final String passwordError;
  final bool passwordValidated;
  PasswordFieldState({
    this.passwordError = "",
    this.passwordValidated = false,
  });

  PasswordFieldState copyWith({
    String? passwordError,
    bool? passwordValidated,
  }) {
    return PasswordFieldState(
      passwordError: passwordError ?? this.passwordError,
      passwordValidated: passwordValidated ?? this.passwordValidated,
    );
  }

  @override
  List<Object> get props => [passwordError, passwordValidated];
}

class ConfrmPasswordFieldState extends RegisterState {
  final String cnfrmPasswordError;
  final bool cnfrmPasswordValidated;
  ConfrmPasswordFieldState({
    this.cnfrmPasswordError = "",
    this.cnfrmPasswordValidated = false,
  });

  ConfrmPasswordFieldState copyWith({
    String? cnfrmPasswordError,
    bool? cnfrmPasswordValidated,
  }) {
    return ConfrmPasswordFieldState(
      cnfrmPasswordError: cnfrmPasswordError ?? this.cnfrmPasswordError,
      cnfrmPasswordValidated:
          cnfrmPasswordValidated ?? this.cnfrmPasswordValidated,
    );
  }

  @override
  List<Object> get props => [cnfrmPasswordError, cnfrmPasswordValidated];
}

class UsernameFieldState extends RegisterState {
  final String usernameError;
  final bool usernameValidated;
  UsernameFieldState({
    this.usernameError = "",
    this.usernameValidated = false,
  });

  UsernameFieldState copyWith({
    String? usernameError,
    bool? usernameValidated,
  }) {
    return UsernameFieldState(
      usernameError: usernameError ?? this.usernameError,
      usernameValidated: usernameValidated ?? this.usernameValidated,
    );
  }

  @override
  List<Object> get props => [usernameError, usernameValidated];
}

class MobileNumberFieldState extends RegisterState {
  final String mobileNumberError;
  final bool mobileNumberValidated;
  MobileNumberFieldState({
    this.mobileNumberError = "",
    this.mobileNumberValidated = false,
  });

  MobileNumberFieldState copyWith({
    String? mobileNumberError,
    bool? mobileNumberValidated,
  }) {
    return MobileNumberFieldState(
      mobileNumberError: mobileNumberError ?? this.mobileNumberError,
      mobileNumberValidated:
          mobileNumberValidated ?? this.mobileNumberValidated,
    );
  }

  @override
  List<Object> get props => [mobileNumberError, mobileNumberValidated];
}

class DOBFieldState extends RegisterState {
  final String dobError;
  final bool dobValidated;
  DOBFieldState({
    this.dobError = "",
    this.dobValidated = false,
  });

  DOBFieldState copyWith({
    String? dobError,
    bool? dobValidated,
  }) {
    return DOBFieldState(
      dobError: dobError ?? this.dobError,
      dobValidated: dobValidated ?? this.dobValidated,
    );
  }

  @override
  List<Object> get props => [dobError, dobValidated];
}

class AddressFieldState extends RegisterState {
  final String addressError;
  final bool addressValidated;
  AddressFieldState({
    this.addressError = "",
    this.addressValidated = false,
  });

  AddressFieldState copyWith({
    String? addressError,
    bool? addressValidated,
  }) {
    return AddressFieldState(
      addressError: addressError ?? this.addressError,
      addressValidated: addressValidated ?? this.addressValidated,
    );
  }

  @override
  List<Object> get props => [addressError, addressValidated];
}
