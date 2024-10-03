import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/components/main_layout.dart';
import 'package:my_app/firebase_options.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primaryColor,
        fontFamily: 'Roboto', // 앱 전반에 Roboto 폰트 설정
        primaryColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // 일반 텍스트 색상
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      title: 'Chatter',
      initialRoute: '/',
      routes: AppRoutes.getRoutes(),
      onGenerateRoute: AppRoutes.generateRoute,
      //initialRoute: AppRoutes.loginScreen,
      home: const AuthStateHandler(),
    );
  }
}

class AuthStateHandler extends StatelessWidget {
  const AuthStateHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return const MainLayout();
          } else {
            return const SignInScreen();
          }
        });
  }
}
