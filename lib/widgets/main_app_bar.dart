import 'package:flutter/material.dart';
import 'dart:io';
import 'package:aurora/screens/profile.dart';
import 'package:flutter/cupertino.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Platform.isIOS
          ? const EdgeInsets.only(top: 0, left: 24.0, right: 24.0)
          : const EdgeInsets.only(top: 24, left: 24.0, right: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: const Icon(
              Icons.calendar_month,
              size: 32,
            ),
          ),
          Column(
            children: [
              Image.asset(
                "./images/logo_aurora.png",
                fit: BoxFit.fitHeight,
                height: 40,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) {
                    return const ProfileScreen();
                  },
                ),
              );
            },
            child: const Icon(
              Icons.account_circle_rounded,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
