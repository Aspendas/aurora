import 'package:aurora/services/auth.dart';
import 'package:aurora/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Page"),
      ),
      body: Center(
        child: RoundedButton(
          colour: Colors.amber,
          paddings: EdgeInsets.all(8),
          onPress: () {
            AuthService().signOut(context);
          },
          title: const Text(
            "Sign Out",
            style: TextStyle(
              fontSize: 19,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
