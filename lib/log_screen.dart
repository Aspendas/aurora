import 'package:aurora/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:aurora/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogScreen extends StatefulWidget {
  static const String id = 'log_screen';

  @override
  LogScreenState createState() => LogScreenState();
}

class LogScreenState extends State<LogScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFCFE3E3),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 60, 50, 50),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        onTap: () {},
                        child: const Text(
                          'Sign in',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 15,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RegScreen();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          ' Sign up',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                    ],
                  ),
                  InputField(
                    hinttext: "e-mail",
                    iconl: const Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                    ),
                    passw: false,
                    paddings: const EdgeInsets.fromLTRB(0, 13, 0, 11),
                  ),
                  InputField(
                    hinttext: "password",
                    iconl: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    passw: true,
                    paddings: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.2,
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                activeColor: const Color(0xff00C8E8),
                                splashRadius: 25,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
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
                            'Remember me',
                            style: TextStyle(
                                fontFamily: 'RobotoMono', fontSize: 12),
                          ),
                        ],
                      ),
                      const Text(
                        'Forgot Password?',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontFamily: 'RobotoMono', fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  RoundedButton(
                    title: 'Sign-In',
                    colour: Colors.white,
                    paddings: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 85),
                    onPress: () async {
                      var user = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: "a@gmail.com", password: "123456");
                      print(user);
                    },
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Don\'t have an account yet?  ',
                          style:
                              TextStyle(fontFamily: 'RobotoMono', fontSize: 12),
                          textAlign: TextAlign.left),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RegScreen();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Sign up now ',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 12,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1.5,
                        ),
                      ),
                      Text(
                        "      or login      ",
                        style:
                            TextStyle(fontFamily: 'RobotoMono', fontSize: 15),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 60,
                        height: 45,
                        child: Material(
                          elevation: 3.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                color: Colors.black, width: 1.5),
                          ),
                          child: MaterialButton(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            onPressed: () {},
                            height: 50.0,
                            child: Image.asset('images/google logo.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                      SizedBox(
                        width: 60,
                        height: 45,
                        child: Material(
                          elevation: 3.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                color: Colors.black, width: 1.5),
                          ),
                          child: MaterialButton(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              onPressed: () {},
                              height: 50.0,
                              child: const Icon(MdiIcons.ghost)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 2, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          ' with Google',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 9),
                        ),
                        SizedBox(width: 45),
                        Text(
                          'by anonymously*',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 9),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 11),
                  const Text(
                    '*if you continue anonymously, you won’t be able to continue with other devices later and you won’t be able to write blog',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 9),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
