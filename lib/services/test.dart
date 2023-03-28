import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityService {
  CollectionReference activities =
      FirebaseFirestore.instance.collection('tests');

  Future getTest() {
    var activityList = activities.get();
    return activityList;
  }
}
