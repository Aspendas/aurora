import 'package:flutter/material.dart';
import 'log_screen.dart';
import 'package:aurora/widgets.dart';
import 'package:aurora/services/auth.dart';

class PasswrScreen extends StatefulWidget {
  static const String id = 'passwr_screen';

  @override
  PasswrScreenState createState() => PasswrScreenState();
}

class PasswrScreenState extends State<PasswrScreen> {
  late final TextEditingController _email;

  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

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
              const SizedBox(height: 40),
              RoundedButton(
                title: 'Send E-mail',
                colour: Colors.white,
                paddings:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 85),
                onPress: () {
                  AuthService().resetPassword(_email.text, context);
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
