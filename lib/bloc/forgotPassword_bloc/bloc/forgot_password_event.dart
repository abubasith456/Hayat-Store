part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordButtonPressed extends ForgotPasswordEvent {
  String email;
  BuildContext context;

  ForgotPasswordButtonPressed({
    required this.email,
    required this.context,
  });

  @override
  List<Object> get props => [email, context];
}
