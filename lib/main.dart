import 'package:flutter/material.dart';
import 'log_screen.dart';
import 'register_screen.dart';

void main() {
  runApp(Aurora());
}

class Aurora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LogScreen.id,
      routes: {
        LogScreen.id: (context) => LogScreen(),
        RegScreen.id: (context) => RegScreen(),
      },
    );
  }
}
