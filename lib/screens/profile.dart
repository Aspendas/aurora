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
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          DateTime dt =
              (snapshot.data['challengeStartDates'] as Timestamp).toDate();

          final String formattedStartDate = formatter.format(dt);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Profile",
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return const ProfileScreen();
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.account_circle_rounded),
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
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 75,
                        child: Text(
                          'BBB',
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'RobotoMono'),
                        ), //Text
                      ),
                      const SizedBox(height: 11),
                      Text(
                        snapshot.data['name'],
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
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
                              fontSize: 18, fontFamily: "Robotomono"),
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
                              fontSize: 18, fontFamily: "Robotomono"),
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
                              fontSize: 18, fontFamily: "Robotomono"),
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
                          style: const TextStyle(
                              fontSize: 18, fontFamily: "Robotomono"),
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
                                      text: "  about",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Robotomono"),
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

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late String formattedStartDate;
  @override
  void initState() {
    super.initState();
    formattedStartDate = ''; // set initial value
  }

  @override
  Widget build(BuildContext context) {
    final genderList = <String>[
      'Man',
      'woman HAHAHAHA ',
      'attack helicopter',
      'ERRRRRRRRKEK'
    ];
    final ageList = <String>['18', '17', '16'];
    final addList = <String>[
      'Alcohol',
      'League of legends',
      'kibritten yaptigim'
    ];

    return FutureBuilder(
      future: UserService().getUserInfo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          DateTime dt =
              (snapshot.data['challengeStartDates'] as Timestamp).toDate();

          formattedStartDate = formatter.format(dt);

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                " Edit Profile",
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 75,
                        child: Text(
                          'BBB',
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'RobotoMono'),
                        ), //Text
                      ),
                      const SizedBox(height: 11),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          'Change the avatar',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'RobotoMono',
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF0057FF)),
                        ),
                      ),
                      const SizedBox(height: 62),
                      PDropDown(
                        uptext: 'Age',
                        editstatus: true,
                        kitemnumber: 32.0,
                        ilist: ageList,
                        initialval: "${snapshot.data['age']}",
                      ),
                      const SizedBox(height: 9),
                      PDropDown(
                        uptext: 'Biological Gender',
                        editstatus: true,
                        kitemnumber: 32.0,
                        ilist: genderList,
                        initialval: snapshot.data['gender'],
                      ),
                      const SizedBox(height: 9),
                      PDropDown(
                        uptext: 'Addiction',
                        editstatus: true,
                        kitemnumber: 32.0,
                        ilist: addList,
                        initialval: snapshot.data['addiction'],
                      ),
                      const SizedBox(height: 9),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Text(
                              'Starting Date',
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await showModalBottomSheet(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                  builder: (context, setState) =>
                                      BottomSheetReset(
                                    currentdate: dt,
                                    formattedDate: formattedStartDate,
                                    formatter: formatter,
                                  ),
                                ),
                              ).then((value) {
                                dt = value;
                              });
                              setState(() {
                                formattedStartDate = formatter.format(dt);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                ),
                              ),
                              height: 40,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 15),
                                child: Text(
                                  formattedStartDate,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Robotomono",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      RoundedButton(
                        colour: Colors.white,
                        paddings: const EdgeInsets.all(8),
                        onPress: () {
                          print('${snapshot.data['addiction']}');
                        },
                        title: const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black,
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
