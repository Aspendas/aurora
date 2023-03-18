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
    String defaultURL =
        "https://firebasestorage.googleapis.com/v0/b/aurora-sc.appspot.com/o/Avatars%2F2.png?alt=media&token=da6ab49a-02f7-4fa5-bae7-c1ea698eef04";

    DocumentReference docRef =
        FirebaseFirestore.instance.collection("users").doc(uid);
    DocumentSnapshot docSnap = await docRef.get();

    if (docSnap.exists) {
      Map<String, dynamic>? data = docSnap.data() as Map<String, dynamic>?;
      if (data != null) {
        if (data["imageURL"] != null) {
          return data['imageURL'];
        } else {
          return defaultURL;
        }
      }
    } else {
      return defaultURL;
    }
  }
}