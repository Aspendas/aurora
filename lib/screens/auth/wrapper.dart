import 'package:aurora/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:aurora/services/user_info.dart';
import 'package:aurora/screens/user_init_page.dart';

import '../home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return FutureBuilder(
        future: UserService().checkUserExist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == false) {
            return (user != null)
                ? const userInitScreen()
                : const LoginScreen();
          } else {
            return (user != null) ? const HomeScreen() : const LoginScreen();
          }
        });
  }
}
