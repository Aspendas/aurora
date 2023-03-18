import 'package:flutter/material.dart';
import 'dart:io';
import 'package:aurora/screens/profile.dart';
import 'package:flutter/cupertino.dart';

import '../screens/info/info.dart';

import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser;

class MainAppBar extends StatelessWidget {
  final AsyncSnapshot userData;
  const MainAppBar({
    required this.userData,
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
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) {
                    return const InfoScreen();
                  },
                ),
              );
            },
            child: const Icon(
              Icons.info_outline,
              size: 36,
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
                    return ProfileScreen(userData: userData);
                  },
                ),
              );
            },
            child: const Icon(
              Icons.account_circle_rounded,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}
