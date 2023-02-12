import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 60, 50, 150),
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
              height: 20.0,
            ),
            const Text("Aurora",
                style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 50,
                    fontWeight: FontWeight.w900),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Log in',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'RobotoMono', fontSize: 11),
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
                        fontSize: 11,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(width: 2),
              ],
            ),
            InputField(
              hinttext: "e-mail",
              iconl: const Icon(Icons.email_outlined),
              passw: false,
            ),
            InputField(
              hinttext: "password",
              iconl: const Icon(Icons.lock),
              passw: true,
            ),
            InputField(
              hinttext: "confirm password",
              iconl: const Icon(Icons.lock),
              passw: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Transform.scale(
                  scale: 1.2,
                  child: SizedBox(
                    width: 20,
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
                InkWell(
                  onTap: () {},
                  child: const Text.rich(
                    TextSpan(
                      text: 'I agree the ',
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Terms',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            RoundedButton(
              title: 'Sign-up',
              colour: Colors.white,
              paddings:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 100),
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
