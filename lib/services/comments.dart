import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsService {
  CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');

  Future getComments() {
    var allComments = comments.get();
    return allComments;
  }
}
