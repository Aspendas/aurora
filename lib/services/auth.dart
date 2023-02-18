import 'package:aurora/log_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class AuthService {
  emailRegister(String email, String password, BuildContext context) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return const HomePage();
            }), (route) => false),
          );
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  emailSignIn(String email, String password, BuildContext context) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return const HomePage();
            }), (route) => false),
          );
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  /*
  googleLogin(BuildContext context) async {
    final googleSignIn = GoogleSignIn();

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential).then(
          (value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
            return const HomePage();
          }), (route) => false),
        );
    ;
  }
  */

  signOut(BuildContext context) async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => LogScreen(),
            ),
            (route) => false));
  }
}
