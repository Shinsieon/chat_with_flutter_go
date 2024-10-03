import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/CAppbar.dart';
import 'package:my_app/components/CBottomSheet.dart';
import 'package:my_app/components/CListItem.dart';
import 'package:my_app/screens/changeUserName.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }

  void _showChangeUsernameDialog(BuildContext context) {
    showCBottomSheet(
      BottomSheetParams(
          context: context,
          child: ChangeUsernameScreen(),
          title: 'Change Username'),
    );
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
            icon: Icons.change_circle,
            title: 'Modify Username',
            onTap: () => _showChangeUsernameDialog(context),
          ),
        ],
      ),
    );
  }
}
