import 'package:flutter/material.dart';
import 'dart:io';
import 'package:aurora/screens/profile.dart';
import 'package:flutter/cupertino.dart';

import '../screens/info/info.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../services/user_info.dart';

final user = FirebaseAuth.instance.currentUser;

class MainAppBar extends StatelessWidget {
  final AsyncSnapshot userData;
  const MainAppBar({
    required this.userData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffDAF0F0),
      child: Padding(
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
              child: Image.asset(
                './images/care.png',
                color: const Color.fromRGBO(41, 41, 41, 1),
                fit: BoxFit.fitHeight,
                height: 30,
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
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 17.5,
                child: userData.data['imageURL'] != null
                    ? Image.network(
                        userData.data['imageURL'],
                        fit: BoxFit.fitHeight,
                        height: 35,
                        width: 35,
                      )
                    : Text(
                        UserService().getInitials(userData.data['name']),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'RobotoMono'),
                      ), //Text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
