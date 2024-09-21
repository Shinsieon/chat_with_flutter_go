import 'package:flutter/material.dart';
import 'package:my_app/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nicknameController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your Nickname',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: nicknameController,
                decoration: const InputDecoration(
                  labelText: 'Nickname',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final String nickname = nicknameController.text;
                    if (nickname.isNotEmpty) {
                      Navigator.pushNamed(context, AppRoutes.homeScreen,
                          arguments: nickname);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please enter a Nickname'),
                      ));
                    }
                  },
                  child: const Text('Go to home'),
                ),
              )
            ],
          ),
        ));
  }
}
