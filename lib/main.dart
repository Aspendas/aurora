import 'package:flutter/material.dart';
import 'log_screen.dart';
import 'register_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(Aurora());
}

class Aurora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          initialRoute: LogScreen.id,
          routes: {
            LogScreen.id: (context) => LogScreen(),
            RegScreen.id: (context) => RegScreen(),
          },
        );
      },
    );
  }
}
