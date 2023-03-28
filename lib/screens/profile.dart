import 'package:aurora/screens/motivation_page.dart';
import 'package:aurora/services/auth.dart';
import 'package:aurora/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:aurora/services/user_info.dart';
import 'package:intl/intl.dart';
import 'package:aurora/screens/profile_edit.dart';

import '../constants.dart';

final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');

class ProfileScreen extends StatefulWidget {
  final AsyncSnapshot userData;

  const ProfileScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var dt = widget.userData.data['challengeStartDates'] != null
        ? (widget.userData.data['challengeStartDates'] as Timestamp).toDate()
        : null;

    final String formattedStartDate = dt != null
        ? formatter.format(dt)
        : 'You have not started a challenge yet. You can start it on main screen ';
    var imageUrl = widget.userData.data['imageURL'];
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: Color(0xffDAF0F0),
        centerTitle: true,
        title: const Text(
          style: TextStyle(
            color: Colors.black
          ),
          "Profile",
        ),
        actions: [
          IconButton(
            color: Colors.black,
            iconSize: 35,
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) {
                    return MotivationScreen(userData: widget.userData);
                  },
                ),
              );
            },
            icon: const Icon(Icons.view_timeline_outlined),
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
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 75,
                    child: widget.userData.data['imageURL'] != null
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.fitHeight,
                            height: 120,
                            width: 90,
                          )
                        : Text(
                            UserService()
                                .getInitials(widget.userData.data['name']),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'RobotoMono'),
                          ), //Text
                  ),
                ),
                const SizedBox(height: 11),
                Text(
                  widget.userData.data['name'],
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'RobotoMono'),
                ),
                Text(
                  "${user!.email}",
                  style:
                      const TextStyle(fontSize: 10, fontFamily: 'RobotoMono'),
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return ProfileEditScreen(
                            userData: widget.userData,
                          );
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
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 14),
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
                    "${widget.userData.data['age']}",
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
                    widget.userData.data['gender'],
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
                    widget.userData.data['addiction'],
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
                            fontWeight: FontWeight.w600)
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
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
}
