import 'package:aurora/services/auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:aurora/widgets.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
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
                height: 116,
                width: 100,
                'images/logo.png',
              ),
              const SizedBox(
                height: 91.0,
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
                            return const LoginScreen();
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
                  const Text(
                    " |",
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      ' Sign up',
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
              const SizedBox(height: 4),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 13, horizontal: 4),
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
                      EdgeInsets.symmetric(vertical: 13, horizontal: 4),
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
                      EdgeInsets.symmetric(vertical: 13, horizontal: 4),
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
                    scale: 1,
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
              const SizedBox(height: 30),
              PAsyncButton(
                colour: Colors.black,
                title: const Text(
                  'Sign-up',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  ),
                ),
                paddings: EdgeInsets.zero,
                onPress: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  await AuthService()
                      .emailRegister(_email.text, _password.text, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
