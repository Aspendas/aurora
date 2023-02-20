import 'package:aurora/screens/auth/log_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/auth/passw_res.dart';
import '../screens/home.dart';

class AuthService {
  emailRegister(String email, String password, BuildContext context) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }), (route) => false),
          );
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The password provided is too weak.'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The account already exists for that email.'),
          ),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email.'),
          ),
        );
      }
      return Future.error(e);
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
              return const HomeScreen();
            }), (route) => false),
          );
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password provided for that user.'),
          ),
        );
      } else if (e.code == 'too-many-requests') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'You have entered the wrong password too many times; please wait a while and try again.'),
          ),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email.'),
          ),
        );
      }
      return Future.error(e);
    }
  }

  anonymousSignIn(BuildContext context) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInAnonymously().then(
                (value) => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return const HomeScreen();
                }), (route) => false),
              );
      print("Signed in with temporary account.");
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

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
            return const HomeScreen();
          }), (route) => false),
        );
  }

  signOut(BuildContext context) async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => LogScreen(),
            ),
            (route) => false));
  }

  resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then(
            (value) => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return MailCheckScreen();
            }), (route) => false),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The email address is invalid.'),
          ),
        );
      }
      return Future.error(e);
    }
  }
}
