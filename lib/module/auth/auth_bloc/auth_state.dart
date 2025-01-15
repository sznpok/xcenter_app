part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String email;
  final String password;
  final bool isLoading;
  final bool isPasswordVisible;
  final String fullName;
  final String confirmPassword;
  final bool isConfirmPasswordVisible;
  final GlobalKey<FormState>? registerKey;
  final GlobalKey<FormState>? loginKey;

  const AuthState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.fullName = '',
    this.confirmPassword = '',
    this.isConfirmPasswordVisible = false,
    this.registerKey,
    this.loginKey,
  });

  AuthState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? isPasswordVisible,
    String? fullName,
    String? confirmPassword,
    bool? isConfirmPasswordVisible,
    GlobalKey<FormState>? registerKey,
    GlobalKey<FormState>? loginKey,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      fullName: fullName ?? this.fullName,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      registerKey: registerKey ?? this.registerKey,
      loginKey: loginKey ?? this.loginKey,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isLoading,
        isPasswordVisible,
        fullName,
        confirmPassword,
        isConfirmPasswordVisible,
        registerKey,
        loginKey,
      ];
}
