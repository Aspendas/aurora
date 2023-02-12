import 'package:aurora/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:aurora/widgets.dart';

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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 60, 50, 20),
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
                        style:
                            TextStyle(fontFamily: 'RobotoMono', fontSize: 11),
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
                    const Text('Remember me')
                  ],
                ),
                const Text('Forgot Password?', textAlign: TextAlign.left),
                const SizedBox(height: 30),
                RoundedButton(
                  title: 'Log In',
                  colour: Colors.white,
                  paddings: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 85),
                  onPress: () {},
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Don\'t have an account yet?',
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
                            fontSize: 11,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: const <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1.5,
                      ),
                    ),
                    Text("        or login        "),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 60,
                      height: 45,
                      child: Material(
                        elevation: 4.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                              const BorderSide(color: Colors.black, width: 1.5),
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
                        elevation: 4.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                              const BorderSide(color: Colors.black, width: 1.5),
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
                        'With Google',
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
                const SizedBox(height: 35),
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
    );
  }
}
