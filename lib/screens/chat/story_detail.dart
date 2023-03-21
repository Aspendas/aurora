import 'package:aurora/widgets/chat/story_detail/story_detail_first.dart';
import 'package:flutter/material.dart';

class StoryDetail extends StatelessWidget {
  const StoryDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 28,
          ),
        ),
        title: const Text("Robert Downey"),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [StoryDetailFirst()],
        ),
      ),
    );
  }
}
