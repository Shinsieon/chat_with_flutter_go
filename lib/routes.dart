import 'package:flutter/material.dart';
import 'package:my_app/screens/home.dart';
import 'package:my_app/screens/room.dart';
import 'package:my_app/screens/signup.dart';
import 'screens/signin.dart';

class AppRoutes {
  static const String signInScreen = '/signin';
  static const String signUpScreen = 'signup';
  static const String homeScreen = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      signInScreen: (context) => SignInScreen(),
      signUpScreen: (context) => SignUpScreen(),
      homeScreen: (context) => HomeScreen()
    };
  }
}
