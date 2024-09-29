import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/colors.dart';
import 'package:my_app/components/CButton.dart';
import 'package:my_app/components/CText.dart';
import 'package:my_app/components/CTextField.dart';
import 'package:my_app/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/signup.dart';
import 'package:my_app/utils/toast.dart';
import 'package:my_app/utils/validator.dart';

class SignInScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  SignInScreen({super.key});
  Future<bool> _signIn() async {
    if (emailController.text.isEmpty || pwController.text.isEmpty) {
      print("Email and Password cannot be empty");
      ToastUtil.showToast("Email and Password cannot be empty");
      return false;
    }
    if (!Validator.isValidEmail(emailController.text)) {
      ToastUtil.showToast("Please enter a valid email address");
      return false;
    }
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: pwController.text,
      );
      ToastUtil.showToast(
          "successfully signed in: ${userCredential.user?.email}");
      return true;
    } catch (e) {
      print("Error : $e");
      ToastUtil.showToast(e.toString());
      return false;
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
          const SizedBox(
            height: 50,
          ),
          CustomTextField(
            labelText: 'Password',
            controller: pwController,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const CustomText(
                text: 'Don’t have an account?  ',
                color: Colors.white,
                size: TextSize.medium, // size Enum 사용
              ),
              GestureDetector(
                onTap: () {
                  // Handle SIGN UP click
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  );
                },
                child: const CustomText(
                  text: 'SIGN UP',
                  color: AppColors.yellowColor,
                  fontWeight: FontWeightOption.bold,
                ),
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
              text: 'Sign In', // 버튼 텍스트
              onPressed: () {
                _signIn(); // 버튼 클릭 시 동작
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
