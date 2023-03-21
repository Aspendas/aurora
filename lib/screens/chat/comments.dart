import 'package:flutter/material.dart';

import '../../services/comments.dart';
import '../../widgets/chat/comment.dart';

class Comments extends StatelessWidget {
  const Comments({
    Key? key,
    required AsyncSnapshot this.userData,
  }) : super(key: key);

  final userData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CommentsService().getComments(userData.data["addiction"]),
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
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Comment(data: snapshot.data.docs[index].data());
            },
          );
        }
      },
    );
  }
}
