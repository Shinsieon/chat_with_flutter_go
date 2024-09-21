import 'package:flutter/material.dart';
import 'package:my_app/screens/home.dart';
import 'screens/login.dart';

class AppRoutes {
  static const String loginScreen = '/login';
  static const String homeScreen = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      loginScreen: (context) => const LoginScreen(),
      homeScreen: (context) => HomeScreen()
    };
  }
}
