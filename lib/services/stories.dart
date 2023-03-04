import 'package:cloud_firestore/cloud_firestore.dart';

class StoryService {
  CollectionReference stories =
      FirebaseFirestore.instance.collection('stories');

  Future getCelebrity() {
    var celebrityStories = stories.where('isCelebrity', isEqualTo: true).get();
    return celebrityStories;
  }

  Future getNormal() {
    var celebrityStories = stories.where('isCelebrity', isEqualTo: false).get();
    return celebrityStories;
  }
}
