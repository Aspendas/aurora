import 'package:flutter/material.dart';

class StoryDetailNormal extends StatelessWidget {
  const StoryDetailNormal({Key? key, required this.story}) : super(key: key);
  final story;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 16),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: story.length - 1,
        itemBuilder: (context, index) {
          if (story.length == 1) {
            return const SizedBox();
          } else {
            return Column(
              children: [
                Text("   ${story[index + 1]}"),
                const SizedBox(
                  height: 4,
                )
              ],
            );
          }
        },
      ),
    );
  }
}
