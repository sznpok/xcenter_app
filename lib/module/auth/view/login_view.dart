import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_video/module/auth/auth_bloc/auth_bloc.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/image_constant.dart';
import '../../../routers/routers.dart';
import '../../../utils/validation_mixin.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static Route<void> route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LoginView(),
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
        body: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.sp),
                child: Center(
                  child: SingleChildScrollView(
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
                      child: Form(
                        key: state.loginKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              20.verticalSpace,
                              Image.asset(
                                ImageConstant.logoImage,
                                height: 100.h,
                              ),
                              20.verticalSpace,
                              Text(
                                "Welcome Back!",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              5.verticalSpace,
                              Text(
                                "Please sign in to continue",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      color: AppColors.textColor,
                                    ),
                              ),
                              20.verticalSpace,
                              CustomTextFormField(
                                label: "",
                                hintText: "Enter your email",
                                onChanged: (value) {
                                  if (value != null) {
                                    context
                                        .read<AuthBloc>()
                                        .add(EmailChangedEvent(value));
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email is required";
                                  }
                                  if (!ValidationMixin().validateEmail(value)) {
                                    return "Invalid email";
                                  }
                                  return null;
                                },
                                initialValue: state.email,
                                name: "email",
                                prefixIcon: Icon(Icons.email,
                                    color: AppColors.primaryColor),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                              ),
                              20.verticalSpace,
                              CustomTextFormField(
                                label: "",
                                hintText: "Enter your password",
                                name: "password",
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
                                initialValue: state.password,
                                obscureText: !state.isPasswordVisible,
                                prefixIcon: Icon(Icons.lock,
                                    color: AppColors.primaryColor),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
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
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              30.verticalSpace,
                              CustomButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(LoginEvent());
                                },
                                label: "Sign In",
                                labelColor: AppColors.white,
                                loading: state.isLoading,
                              ),
                              20.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account? ",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routers.register);
                                    },
                                    child: Text(
                                      "Sign Up",
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
      ),
    );
  }
}
