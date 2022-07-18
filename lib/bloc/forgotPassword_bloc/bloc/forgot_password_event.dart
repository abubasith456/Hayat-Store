part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordButtonPressedEvent extends ForgotPasswordEvent {
  String email;
  BuildContext context;

  ForgotPasswordButtonPressedEvent({
    required this.email,
    required this.context,
  });

  @override
  List<Object> get props => [email, context];
}
