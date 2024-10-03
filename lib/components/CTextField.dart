import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String placeholder;
  final bool obscureText;
  final bool isEmail;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.placeholder = '',
    this.obscureText = false, // 기본값은 false
    this.isEmail = false, // 기본값은 false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        border: const UnderlineInputBorder(),
        hintText: placeholder,
        hintStyle: const TextStyle(color: Colors.white),
      ),
      obscureText: obscureText,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
    );
  }
}
