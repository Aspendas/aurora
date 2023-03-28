import 'package:aurora/widgets/health/test.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key, required this.userData}) : super(key: key);
  final AsyncSnapshot userData;
  @override
  Widget build(BuildContext context) {
    return Test();
  }
}
