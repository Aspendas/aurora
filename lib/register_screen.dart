import 'package:flutter/material.dart';
import 'log_screen.dart';
import 'package:aurora/widgets.dart';

class RegScreen extends StatefulWidget {
  static const String id = 'reg_screen';

  @override
  RegScreenState createState() => RegScreenState();
}

class RegScreenState extends State<RegScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFCFE3E3),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 60, 50, 130),
          child: Column(
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
              InputField(
                hinttext: "confirm password",
                iconl: const Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                passw: true,
                paddings: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
