import 'package:flutter/material.dart';

class StoryDetailFirst extends StatelessWidget {
  const StoryDetailFirst({Key? key, this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              topLeft: Radius.circular(16),
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Image.network(
              data["imageURL"],
              fit: BoxFit.fitHeight,
              height: 120,
              width: 90,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          flex: 3,
          child: Text(
            "     ${data["story"][0]}",
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
