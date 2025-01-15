part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  const LoginEvent();
}

class RegisterEvent extends AuthEvent {
  const RegisterEvent();
}

class FullNameChangedEvent extends AuthEvent {
  final String fullName;

  const FullNameChangedEvent(this.fullName);
}

class EmailChangedEvent extends AuthEvent {
  final String email;

  const EmailChangedEvent(this.email);
}

class PasswordChangedEvent extends AuthEvent {
  final String password;

  const PasswordChangedEvent(this.password);
}

class ConfirmPasswordChangedEvent extends AuthEvent {
  final String confirmPassword;

  const ConfirmPasswordChangedEvent(this.confirmPassword);
}

class PasswordVisibleEvent extends AuthEvent {
  const PasswordVisibleEvent();
}

class ConfirmPasswordVisibleEvent extends AuthEvent {
  const ConfirmPasswordVisibleEvent();
}
