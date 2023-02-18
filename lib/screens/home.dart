import 'package:aurora/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
          child: RoundedButton(
        colour: Colors.amber,
        paddings: EdgeInsets.all(8),
        onPress: () {},
        title: "SignOut",
      )),
    );
  }
}
