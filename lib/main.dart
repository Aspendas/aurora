import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/auth/log_screen.dart';
import 'screens/auth/passw_res.dart';
import 'screens/auth/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        PasswrScreen.id: (context) => PasswrScreen(),
      },
    );
  }
}
