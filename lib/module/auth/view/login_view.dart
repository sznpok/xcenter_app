import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/image_constant.dart';
import '../../../routers/routers.dart';
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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
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
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 16.sp,
                                    color: AppColors.textColor,
                                  ),
                        ),
                        20.verticalSpace,
                        CustomTextFormField(
                          label: "Email",
                          hintText: "Enter your email",
                          onChanged: (value) {},
                          name: "email",
                          prefixIcon:
                              Icon(Icons.email, color: AppColors.primaryColor),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                        20.verticalSpace,
                        CustomTextFormField(
                          label: "Password",
                          hintText: "Enter your password",
                          name: "password",
                          prefixIcon:
                              Icon(Icons.lock, color: AppColors.primaryColor),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {},
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.visibility_outlined,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        30.verticalSpace,
                        CustomButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routers.home);
                          },
                          label: "Sign In",
                          labelColor: AppColors.white,
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
                                Navigator.pushNamed(context, Routers.register);
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
        ),
      ),
    );
  }
}
