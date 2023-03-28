import 'package:flutter/material.dart';

import '../../widgets/health/activity.dart';
import '../../widgets/health/activity_reverse.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen(
      {Key? key, required this.userData, required this.activities})
      : super(key: key);
  final AsyncSnapshot userData;
  final activities;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: activities,
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
              if (index % 2 == 0) {
                return Activity(
                  data: snapshot.data.docs[index].data(),
                );
              } else {
                return ActivityReverse(
                  data: snapshot.data.docs[index].data(),
                );
              }
            },
          );
        }
      },
    );
  }
}