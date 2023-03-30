import 'package:flutter/material.dart';

import '../../services/stories.dart';
import '../../widgets/chat/story.dart';

class Stories extends StatelessWidget {
  const Stories({
    Key? key,
    required AsyncSnapshot this.userData,
  }) : super(key: key);

  final userData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: StoryService().getCelebrity(userData.data['addiction']),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Story(data: snapshot.data.docs[index].data()),
                  );
                },
              );
            }
          },
        ),
        FutureBuilder(
          future: StoryService().getNormal(userData.data['addiction']),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Story(data: snapshot.data.docs[index].data()),
                  );
                },
              );
            }
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
