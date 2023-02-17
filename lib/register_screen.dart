import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'log_screen.dart';
import 'package:aurora/widgets.dart';

class RegScreen extends StatefulWidget {
  static const String id = 'reg_screen';

  @override
  RegScreenState createState() => RegScreenState();
}

class RegScreenState extends State<RegScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFCFE3E3),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                height: 100,
                width: 100,
                'images/logo.png',
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LogScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'Sign in',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Sign up',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                ],
              ),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18, horizontal: 4),
                  hintText: "E-mail",
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 28,
                    color: Color.fromRGBO(49, 62, 64, 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    borderSide: BorderSide(width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    borderSide: BorderSide(width: 1, color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18, horizontal: 4),
                  hintText: "Password",
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.lock,
                    size: 28,
                    color: Color.fromRGBO(49, 62, 64, 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    borderSide: BorderSide(width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    borderSide: BorderSide(width: 1, color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: _confirmPassword,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18, horizontal: 4),
                  hintText: "Confirm Password",
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.lock,
                    size: 28,
                    color: Color.fromRGBO(49, 62, 64, 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    borderSide: BorderSide(width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    borderSide: BorderSide(width: 1, color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Transform.scale(
                    scale: 1.2,
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        activeColor: const Color(0xff00C8E8),
                        splashRadius: 25,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'I agree the ',
                    style: TextStyle(fontFamily: 'RobotoMono', fontSize: 12),
                  ),
                  GestureDetector(
                    child: const Text(
                      'Terms',
                      style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              RoundedButton(
                title: 'Sign-up',
                colour: Colors.white,
                paddings:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 85),
                onPress: () async {
                  try {
                    final userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _email.text, password: _password.text)
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
