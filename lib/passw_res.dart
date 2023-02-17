import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'log_screen.dart';
import 'package:aurora/widgets.dart';

class PasswrScreen extends StatefulWidget {
  static const String id = 'passwr_screen';

  @override
  PasswrScreenState createState() => PasswrScreenState();
}

class PasswrScreenState extends State<PasswrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFCFE3E3),
      appBar: AppBar(
        title: const Text("Forget Your Password?"), //need color change
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 60, 50, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                height: 100,
                width: 100,
                'images/logo.png',
              ),
              const SizedBox(height: 40),
              const Text(
                'Forgot your password?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
              InputField(
                hinttext: "e-mail",
                iconl: const Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                passw: false,
                paddings: const EdgeInsets.fromLTRB(0, 50, 0, 10),
              ),
              const SizedBox(height: 40),
              RoundedButton(
                title: 'Send E-mail',
                colour: Colors.white,
                paddings:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 85),
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MailCheckScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MailCheckScreen extends StatefulWidget {
  static const String id = 'mail_check_screen';

  @override
  MailCheckScreenState createState() => MailCheckScreenState();
}

class MailCheckScreenState extends State<MailCheckScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFCFE3E3),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 60, 50, 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                height: 100,
                width: 100,
                'images/logo.png',
              ),
              const SizedBox(height: 40),
              const Text(
                'Check your mail',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontSize: 25,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 40),
              const Text(
                'We have sent a password recover instructions to your email',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'RobotoMono', fontSize: 20),
              ),
              const SizedBox(height: 40),
              RoundedButton(
                title: 'Return',
                colour: Colors.white,
                paddings:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 85),
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LogScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
