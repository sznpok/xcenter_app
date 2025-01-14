import 'package:flutter/material.dart';

import '../module/auth/view/login_view.dart';
import '../module/auth/view/register_view.dart';
import '../module/home/view/home_view.dart';
import '../splash_view.dart';
import 'not_found_page.dart';

class Routers {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routers.splash:
        return SplashView.route();
      case Routers.login:
        return LoginView.route();
      case Routers.register:
        return RegisterView.route();
      case Routers.home:
        return HomeView.route();
      default:
        return NotFoundPage.route();
    }
  }
}
