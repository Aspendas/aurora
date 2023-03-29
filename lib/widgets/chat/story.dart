import 'package:aurora/screens/chat/story_detail.dart';
import 'package:flutter/material.dart';

class Story extends StatelessWidget {
  const Story({
    Key? key,
    @required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    String imageURL = data["imageURL"];
    String name = data["name"];
    List story = data["story"];
    List upvotes = data["upvotes"];
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0XFFB7C9C9),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: Image.network(
                imageURL,
                fit: BoxFit.fitHeight,
                height: 120,
                width: 90,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return StoryDetail(storyData: data);
                                },
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Text(
                      story[0],
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
