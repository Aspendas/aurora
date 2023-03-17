import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 50,
          child: Text(
            'BBB',
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w600,
                fontFamily: 'RobotoMono'),
          ), //Text
        ),
      ),
    );
  }
}
