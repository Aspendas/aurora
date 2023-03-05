import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
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
                height: 65,
              ),
            ],
          ),
          GestureDetector(
            child: const Icon(
              Icons.person,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
