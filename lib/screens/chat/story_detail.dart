import 'package:aurora/widgets/chat/story_detail/story_detail_first.dart';
import 'package:aurora/widgets/chat/story_detail/story_detail_normal.dart';
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
        backgroundColor: Color(0xffDAF0F0),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 28,
          ),
        ),
        title: Text(
          storyData["name"],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Color(0xffCFE3E3),
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StoryDetailFirst(
              data: storyData,
            ),
            StoryDetailNormal(story: story),
          ],
        ),
      ),
    );
  }
}
