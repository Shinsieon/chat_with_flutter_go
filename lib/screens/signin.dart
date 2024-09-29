import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/components/custom_button.dart';
import 'package:my_app/components/custom_text.dart';
import 'package:my_app/components/custom_textfield.dart';
import 'package:my_app/enums.dart';
import 'package:my_app/routes.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  LoginScreen({super.key});
  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: pwController.text,
      );
      print("User signed in : ${userCredential.user?.email}");
    } catch (e) {
      print("Error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome \nBack',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w900,
              height: 0,
            ),
          ),
          const SizedBox(height: 100),
          CustomTextField(
            labelText: 'Email',
            controller: emailController,
          ),
          const SizedBox(
            height: 50,
          ),
          CustomTextField(
            labelText: 'Password',
            controller: pwController,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                text: 'Don’t have an account?  ',
                color: Colors.white,
                size: TextSize.medium, // size Enum 사용
              ),
              CustomText(
                text: 'SIGN UP',
                color: AppColors.yellowColor,
                fontWeight: FontWeightOption.bold,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                text: 'Forgot Password ?',
                size: TextSize.small,
                fontWeight: FontWeightOption.medium,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: CustomButton(
              text: 'Click Me', // 버튼 텍스트
              onPressed: () {
                print('Button Pressed'); // 버튼 클릭 시 동작
              },
              backgroundColor: AppColors.secondaryColor, // 배경색 설정
              textColor: Colors.white, // 텍스트 색상 설정
              size: ButtonSize.large,
            ),
          )
        ],
      ),
    ));
  }
}
