import 'package:aurora/screens/health/activities.dart';

import 'package:aurora/services/activities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aurora/widgets/health/activity_reverse.dart';
import 'package:aurora/widgets/main_app_bar.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants.dart';
import '../../../widgets/health/activity.dart';
import '../../widgets/health/learn_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LearnPage extends StatefulWidget {
  LearnPage({Key? key}) : super(key: key);

  @override
  State<LearnPage> createState() => _LearnPageState();
  final learnbase = FirebaseFirestore.instance.collection("learn").get();
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.learnbase,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: GridTile(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(CupertinoPageRoute(builder: (context) {
                            return LearnScreen(
                                data: snapshot.data.docs[index].data());
                          }));
                        },
                        child: Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              boxShadow: shadow,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: activitycolor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Center(
                                  child: Text(
                                snapshot.data.docs[index].data()['title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              )),
                            )),
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data.docs.length,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
              ),
            );
          }
        });
  }
}
