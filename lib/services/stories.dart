import 'package:cloud_firestore/cloud_firestore.dart';

class StoryService {
  CollectionReference stories =
      FirebaseFirestore.instance.collection('stories');

  Future getCelebrity(String addiction) {
    var celebrityStories = stories
        .where('isCelebrity', isEqualTo: true)
        .where('addictionType', isEqualTo: addiction)
        .get();
    return celebrityStories;
  }

  Future getNormal(String addiction) {
    var celebrityStories = stories
        .where('isCelebrity', isEqualTo: false)
        .where('addictionType', isEqualTo: addiction)
        .get();
    return celebrityStories;
  }
}
