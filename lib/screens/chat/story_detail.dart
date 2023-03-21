import 'package:aurora/widgets/chat/story_detail/story_detail_first.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoryDetail extends StatelessWidget {
  const StoryDetail({Key? key, required this.storyData}) : super(key: key);
  final storyData;

  @override
  Widget build(BuildContext context) {
    print(storyData);
    List story = storyData["story"];
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 28,
          ),
        ),
        title: Text(storyData["name"]),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.amber.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StoryDetailFirst(
              data: storyData,
            ),
            Padding(
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
            ),
          ],
        ),
      ),
    );
  }
}
