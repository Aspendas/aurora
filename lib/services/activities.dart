import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityService {
  CollectionReference activities =
      FirebaseFirestore.instance.collection('activities');

  Future getActivities() {
    var activityList = activities.get();
    return activityList;
  }
}
