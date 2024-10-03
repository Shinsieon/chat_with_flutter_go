import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/components/CBottomButton.dart';
import 'package:my_app/components/CTextField.dart';
import 'package:my_app/utils/toast.dart';

class ChangeUsernameScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  ChangeUsernameScreen({super.key});

  Future<void> _updateUsername(BuildContext context) async {
    String username = _usernameController.text.trim();
    if (username.isNotEmpty) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateProfile(displayName: username);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        ToastUtil.showToast("Username updated to ${user?.displayName}");
        Navigator.pop(context);
      }
    } else {
      ToastUtil.showToast("Username cannot be empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextField(
          labelText: 'Username',
          placeholder: auth.currentUser?.displayName ?? 'Username',
          controller: _usernameController,
        ),
        const SizedBox(height: 20),
        CustomBottomButton(
          buttons: [
            ButtonConfig(
              text: 'Cancel',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ButtonConfig(
              text: 'OK',
              onPressed: () {
                _updateUsername(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
