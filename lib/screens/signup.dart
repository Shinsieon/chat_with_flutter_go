import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/components/CButton.dart';
import 'package:my_app/components/CText.dart';
import 'package:my_app/components/CTextField.dart';
import 'package:my_app/enums.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/utils/toast.dart';
import 'package:my_app/utils/validator.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpScreen({super.key});

  Future<bool> _signUp() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ToastUtil.showToast("Email and Password cannot be empty");
      return false;
    }
    if (!Validator.isValidEmail(emailController.text)) {
      ToastUtil.showToast("Please enter a valid email address");
      return false;
    }
    // Handle sign-up logic here
    //For example, you can use Firebase Auth to create a user
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      ToastUtil.showToast(
          "successfully signed up: ${userCredential.user?.email}");
      // Navigate to the home screen
      return true;
    } catch (e) {
      print("Error: $e");
      ToastUtil.showToast("Sign up failed: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome!',
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
              isEmail: true,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'Password',
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CustomText(
                  text: 'Oh I remember now! ',
                  color: Colors.white,
                  size: TextSize.medium, // size Enum 사용
                ),
                GestureDetector(
                  onTap: () {
                    // Handle SIGN UP click
                    Navigator.pop(context);
                  },
                  child: const CustomText(
                    text: 'SIGN IN',
                    color: AppColors.yellowColor,
                    fontWeight: FontWeightOption.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: CustomButton(
                text: 'Sign Up', // 버튼 텍스트
                onPressed: () async {
                  var result = await _signUp();
                  if (result == true) {
                    Navigator.pop(context);
                  }
                },
                backgroundColor: AppColors.secondaryColor, // 배경색 설정
                textColor: Colors.white, // 텍스트 색상 설정
                size: ButtonSize.large,
              ),
            )
          ],
        ),
      ),
    );
  }
}
