import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: const Color.fromRGBO(247, 218, 200, 0.7),
          ),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                    ),
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/aurora-sc.appspot.com/o/Avatars%2Fwoman_avatar.jpeg?alt=media&token=73ecb86c-faf9-415d-9d5e-a3abccf3f5c9",
                      fit: BoxFit.fitHeight,
                      height: 120,
                      width: 90,
                    ),
                  ),
                  const Text("Day 33"),
                ],
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "45. günümdeyim. İyiye gittiğimi hissediyorum. Ailem ve arkadaşlarımdan daha fazla destek görüyorum...",
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
