import 'package:aurora/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentsService {
  CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');

  Future getComments() {
    var allComments = comments.get();
    return allComments;
  }

  Future getProfilePictureURL(String uid) async {
    String defaultURL = "";

    DocumentReference docRef = FirebaseFirestore.instance
        .collection("users")
        .doc("SA0ERu24VeRjIb23I888oHM9lqW2");
    DocumentSnapshot docSnap = await docRef.get();

    if (docSnap.exists) {
      Map<String, dynamic>? data = docSnap.data() as Map<String, dynamic>?;
      if (data != null) {
        return data['imageURL'];
      }
    } else {
      return defaultURL;
    }
  }
}
