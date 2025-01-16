import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tiktok_video/constants/app_colors.dart';
import 'package:tiktok_video/module/auth/repo/auth_repo.dart';
import 'package:tiktok_video/utils/navigator_key.dart';
import 'package:tiktok_video/utils/snackbar.dart';

import '../../../routers/routers.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(AuthState(
          registerKey: GlobalKey<FormState>(),
          loginKey: GlobalKey<FormState>(),
        )) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<FullNameChangedEvent>(_onFullNameChangedEvent);
    on<EmailChangedEvent>(_onEmailChangedEvent);
    on<PasswordChangedEvent>(_onPasswordChangedEvent);
    on<ConfirmPasswordChangedEvent>(_onConfirmPasswordChangedEvent);
    on<PasswordVisibleEvent>(_onPasswordVisibleEvent);
    on<ConfirmPasswordVisibleEvent>(_onConfirmPasswordVisibleEvent);
  }

  AuthRepo authRepo = AuthRepo();

  FutureOr<void> _onLoginEvent(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (state.loginKey!.currentState!.validate()) {
      emit(state.copyWith(isLoading: true));

      await authRepo
          .signInWithEmailPassword(
        state.email,
        state.password,
      )
          .then((value) {
        emit(state.copyWith(
          isLoading: false,
        ));
        Navigator.pushNamed(RootNavigatorKey.context, Routers.home);
      }).catchError((error) {
        showSnackBar(
          content: error.toString().replaceAll('Exception: ', ''),
          color: AppColors.red,
        );
        emit(state.copyWith(isLoading: false));
      }).whenComplete(() {
        emit(state.copyWith(isLoading: false));
      });
    }
    return;
  }

  FutureOr<void> _onRegisterEvent(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (state.registerKey!.currentState!.validate()) {
      emit(state.copyWith(isLoading: true));
      await authRepo
          .signupWithEmailPassword(
        state.email,
        state.password,
        state.fullName,
      )
          .then((value) {
        emit(state.copyWith(
          isLoading: false,
        ));
        Navigator.pushNamedAndRemoveUntil(
            RootNavigatorKey.context, Routers.home, (value) => false);
      }).catchError((error) {
        emit(state.copyWith(isLoading: false));
        showSnackBar(content: "Sign Up Failed", color: AppColors.red);
      }).whenComplete(() {
        emit(state.copyWith(isLoading: false));
      });
    }
  }

  FutureOr<void> _onFullNameChangedEvent(
    FullNameChangedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(fullName: event.fullName));
  }

  FutureOr<void> _onEmailChangedEvent(
    EmailChangedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onPasswordChangedEvent(
    PasswordChangedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onConfirmPasswordChangedEvent(
    ConfirmPasswordChangedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  FutureOr<void> _onPasswordVisibleEvent(
    PasswordVisibleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  FutureOr<void> _onConfirmPasswordVisibleEvent(
    ConfirmPasswordVisibleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }
}
