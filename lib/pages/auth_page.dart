import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gocaff/pages/login_or_register_page.dart';
import 'package:gocaff/pages/menu_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user logged in successfully
          if (snapshot.hasData) {
            return MenuPage();
          }
          //user login failed
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
