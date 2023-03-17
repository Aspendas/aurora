import 'package:aurora/services/auth.dart';
import 'package:aurora/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:aurora/services/user_info.dart';
import 'package:intl/intl.dart';
import 'package:aurora/screens/profile_edit.dart';
import 'package:aurora/screens/notification.dart';

final user = FirebaseAuth.instance.currentUser;
final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
final _userdata = FirebaseFirestore.instance.collection("users").doc(user!.uid);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService().getUserInfo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var dt = snapshot.data['challengeStartDates'] != null
              ? (snapshot.data['challengeStartDates'] as Timestamp).toDate()
              : null;

          final String formattedStartDate = dt != null
              ? formatter.format(dt)
              : 'You have not started a challenge yet. You can start it on main screen ';
          String imageUrl = snapshot.data['imageURL'];
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Profile",
              ),
              actions: [
                IconButton(
                  iconSize: 35,
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return const NotificationScreen();
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.circle_notifications),
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 75,
                        child: snapshot.data['imageURL'] != null
                            ? Image.network(
                                imageUrl,
                                fit: BoxFit.fitHeight,
                                height: 120,
                                width: 90,
                              )
                            : Text(
                                UserService()
                                    .getInitials(snapshot.data['name']),
                                style: const TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'RobotoMono'),
                              ), //Text
                      ),
                      const SizedBox(height: 11),
                      Text(
                        snapshot.data['name'],
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'RobotoMono'),
                      ),
                      Text(
                        "${user!.email}",
                        style: const TextStyle(
                            fontSize: 10, fontFamily: 'RobotoMono'),
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) {
                                return const ProfileEditScreen();
                              },
                            ),
                          );
                        },
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 14),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                        child: Icon(
                                      Icons.edit,
                                      size: 15,
                                    )),
                                    TextSpan(
                                        text: " Edit Profile",
                                        style: TextStyle(fontSize: 13)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      PDropDown(
                        uptext: 'Age',
                        title: Text(
                          "${snapshot.data['age']}",
                          style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "Robotomono",
                              fontWeight: FontWeight.w600),
                        ),
                        editstatus: false,
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      PDropDown(
                        uptext: 'Biological Gender',
                        title: Text(
                          snapshot.data['gender'],
                          style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "Robotomono",
                              fontWeight: FontWeight.w600),
                        ),
                        editstatus: false,
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      PDropDown(
                        uptext: 'Addiction Type',
                        title: Text(
                          snapshot.data['addiction'],
                          style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "Robotomono",
                              fontWeight: FontWeight.w600),
                        ),
                        editstatus: false,
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      PDropDown(
                        uptext: 'Starting Date',
                        title: Text(
                          formattedStartDate,
                          style: dt != null
                              ? const TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Robotomono",
                                  fontWeight: FontWeight.w400)
                              : const TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Robotomono",
                                  color: Colors.grey),
                        ),
                        editstatus: false,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                              ),
                            ),
                            height: 40,
                            width: 348,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.info_outline,
                                        size: 20,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "  About",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Robotomono",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      RoundedButton(
                        colour: Colors.white,
                        paddings: const EdgeInsets.all(8),
                        onPress: () {
                          AuthService().signOut(context);
                        },
                        title: const Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
