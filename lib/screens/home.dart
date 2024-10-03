import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/CAppbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Home'),
      body: Text("Welcome ${auth.currentUser?.displayName ?? "guest"}"),
    );
  }
}
