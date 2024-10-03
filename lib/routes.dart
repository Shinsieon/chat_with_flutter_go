import 'package:flutter/material.dart';
import 'package:my_app/screens/chats.dart';
import 'package:my_app/screens/home.dart';
import 'package:my_app/screens/room.dart';
import 'package:my_app/screens/signup.dart';
import 'screens/signin.dart';

class AppRoutes {
  static const String signInScreen = '/signin';
  static const String signUpScreen = 'signup';
  static const String homeScreen = '/home';
  static const String chatsScreen = '/chats';
  static const String roomScreen = '/room';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      signInScreen: (context) => const SignInScreen(),
      signUpScreen: (context) => SignUpScreen(),
      homeScreen: (context) => const HomeScreen(),
      chatsScreen: (context) => const ChatsScreen(),
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case roomScreen:
        final args = settings.arguments as RoomScreenArguments;
        return MaterialPageRoute(
          builder: (context) => RoomScreen(
            chatRoomId: args.roomName,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );
    }
  }
}

class RoomScreenArguments {
  final String roomName;
  final String ownerNickname;
  final DateTime createdAt;
  final int participantCount;
  RoomScreenArguments(
      {required this.roomName,
      required this.ownerNickname,
      required this.createdAt,
      required this.participantCount});
}
