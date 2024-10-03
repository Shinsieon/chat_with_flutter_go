import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/CAppbar.dart';
import 'package:my_app/components/CListItem.dart';
import 'package:my_app/screens/signin.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: ListView(
        children: <Widget>[
          CustomListItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => _logout(context),
          ),
          CustomListItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
