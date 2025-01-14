import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';
import '../../../routers/routers.dart';
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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                      ),
                      30.verticalSpace,
                      CustomTextFormField(
                        label: "Full Name",
                        prefixIcon: Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                        ),
                        hintText: "Enter your full name",
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                        name: "userName",
                      ),
                      20.verticalSpace,
                      CustomTextFormField(
                        label: "Email",
                        prefixIcon:
                            Icon(Icons.email, color: AppColors.primaryColor),
                        hintText: "Enter your email",
                        onChanged: (value) {},
                        name: "email",
                      ),
                      20.verticalSpace,
                      CustomTextFormField(
                        label: "Password",
                        prefixIcon:
                            Icon(Icons.lock, color: AppColors.primaryColor),
                        hintText: "Enter New Password",
                        name: "password",
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.visibility_off,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      CustomTextFormField(
                        label: "Confirm Password",
                        prefixIcon:
                            Icon(Icons.lock, color: AppColors.primaryColor),
                        hintText: "Confirm your password",
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                        name: "password",
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.visibility_off,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      CustomButton(
                        onPressed: () {},
                        label: "Sign Up",
                        labelColor: AppColors.white,
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
      ),
    );
  }
}
