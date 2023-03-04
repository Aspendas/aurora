import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: const Icon(
              Icons.calendar_month,
              size: 32,
            ),
          ),
          const Text(
            "AURORA",
            style: TextStyle(fontSize: 20),
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
