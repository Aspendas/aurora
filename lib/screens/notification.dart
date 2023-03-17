import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aurora/widgets/notificationbox.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Notifications",
        ),
      ),
      body: Container(
        color: Colors.white,
        child: const NotificationBox(),
      ),
    );
  }
}
