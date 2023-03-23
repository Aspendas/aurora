import 'package:cloud_firestore/cloud_firestore.dart';
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
    final Stream<QuerySnapshot> _commentsStream = FirebaseFirestore.instance
        .collection('comments')
        .orderBy("postDate", descending: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _commentsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: snapshot.data!.docs.map(
            (DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Comment(
                data: data,
              );
            },
          ).toList(),
        );
      },
    );
    /*FutureBuilder(
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
    );*/
  }
}
