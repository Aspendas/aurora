import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:aurora/widgets.dart';
import 'package:aurora/services/auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'forgot_password_screen';

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController _email;

  @override
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
      backgroundColor: const Color(0xFFDAF0F0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 42.0),
            child: GestureDetector(
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 36,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 24, 50, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  height: 116,
                  width: 212,
                  'images/logo.png',
                ),
                const SizedBox(height: 80),
                const Text(
                  'Forgot your password?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 64),
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
                PAsyncButton(
                  colour: Colors.black,
                  title: const Text(
                    'Send E-mail',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                    ),
                  ),
                  paddings: EdgeInsets.zero,
                  onPress: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    await AuthService().resetPassword(_email.text, context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(),
        ],
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
                title: const Text(
                  'Return',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  ),
                ),
                colour: Colors.white,
                paddings:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 85),
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
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
