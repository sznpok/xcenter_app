import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_video/module/auth/auth_bloc/auth_bloc.dart';

import '../../../constants/app_colors.dart';
import '../../../routers/routers.dart';
import '../../../utils/validation_mixin.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_form.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  static Route<void> route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const RegisterView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(10.sp),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: state.registerKey,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadowColor,
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            10.verticalSpace,
                            Text(
                              "Create Account",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                            ),
                            30.verticalSpace,
                            CustomTextFormField(
                              label: "",
                              prefixIcon: Icon(
                                Icons.person,
                                color: AppColors.primaryColor,
                              ),
                              hintText: "Enter your full name",
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your full name";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value != null) {
                                  context
                                      .read<AuthBloc>()
                                      .add(FullNameChangedEvent(value));
                                }
                              },
                              initialValue: state.fullName,
                              name: "fullName",
                            ),
                            20.verticalSpace,
                            CustomTextFormField(
                              label: "",
                              prefixIcon: Icon(Icons.email,
                                  color: AppColors.primaryColor),
                              hintText: "Enter your email",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required";
                                }
                                if (!ValidationMixin().validateEmail(value)) {
                                  return "Invalid email";
                                }
                              },
                              onChanged: (value) {
                                if (value != null) {
                                  context
                                      .read<AuthBloc>()
                                      .add(EmailChangedEvent(value));
                                }
                              },
                              name: "email",
                            ),
                            20.verticalSpace,
                            CustomTextFormField(
                              label: "",
                              prefixIcon: Icon(Icons.lock,
                                  color: AppColors.primaryColor),
                              hintText: "Enter New Password",
                              name: "password",
                              initialValue: state.password,
                              obscureText: !state.isPasswordVisible,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                }
                                if (!ValidationMixin()
                                    .validatePassword(value)) {
                                  return "Invalid password";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value != null) {
                                  context
                                      .read<AuthBloc>()
                                      .add(PasswordChangedEvent(value));
                                }
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(PasswordVisibleEvent());
                                },
                                icon: Icon(
                                  !state.isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            20.verticalSpace,
                            CustomTextFormField(
                              label: "",
                              initialValue: state.confirmPassword,
                              obscureText: !state.isConfirmPasswordVisible,
                              prefixIcon: Icon(Icons.lock,
                                  color: AppColors.primaryColor),
                              hintText: "Confirm your password",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                } else if (value != state.password) {
                                  return "Passwords do not match";
                                }
                                if (!ValidationMixin()
                                    .validatePassword(value)) {
                                  return "Invalid password";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                if (value != null) {
                                  context
                                      .read<AuthBloc>()
                                      .add(ConfirmPasswordChangedEvent(value));
                                }
                              },
                              name: "confirmpassword",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(ConfirmPasswordVisibleEvent());
                                },
                                icon: Icon(
                                  !state.isConfirmPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            20.verticalSpace,
                            CustomButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(RegisterEvent());
                              },
                              label: "Sign Up",
                              labelColor: AppColors.white,
                              loading: state.isLoading,
                            ),
                            10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, Routers.login);
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            10.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
