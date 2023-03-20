import 'package:aurora/services/auth.dart';
import 'package:aurora/widgets.dart';
import 'package:aurora/widgets/main/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../widgets/main_app_bar.dart';

class MainScreen extends StatelessWidget {
  final AsyncSnapshot userData;
  MainScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              MainAppBar(userData: userData),
              SizedBox(height: 30),
              Center(child: ProgressBar()),
            ],
          ),
        ),
      ),
    );
  }
}
