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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:aurora/widgets/avatar.dart';

final user = FirebaseAuth.instance.currentUser;
final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
final _userdata = FirebaseFirestore.instance.collection("users").doc(user!.uid);

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
      'Male',
      'Female',
    ];
    final ageList = List<Widget>.generate(
        111,
        (int index) => Center(
              child: Text(
                "${index + 15}",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
        growable: true);

    final addList = <String>['Alcohol', 'Smoking', 'kibritten yaptigim'];

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
          var dt = snapshot.data['challengeStartDates'] != null
              ? (snapshot.data['challengeStartDates'] as Timestamp).toDate()
              : null;

          var formattedStartDate = dt != null
              ? formatter.format(dt)
              : 'You have not started a challenge yet. You can start it on main screen ';
          int age = snapshot.data['age'];
          String gender = snapshot.data['gender'];
          String addiction = snapshot.data['addiction'];
          String imageUrl = snapshot.data['imageURL'];

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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) {
                                return const AvatarChangeScreen();
                              },
                            ),
                          );
                        },
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Text(
                              'Age',
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (_) => SizedBox(
                                  width: double.infinity,
                                  height: 250,
                                  child: CupertinoPicker(
                                      backgroundColor: Colors.white,
                                      itemExtent: 40,
                                      scrollController:
                                          FixedExtentScrollController(),
                                      onSelectedItemChanged: (index) {
                                        setState(() {
                                          age = index + 15;
                                        });
                                      },
                                      children: ageList),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                ),
                              ),
                              height: 45,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 15),
                                child: Text(
                                  '$age',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Robotomono",
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      PDropDown(
                        uptext: 'Biological Gender',
                        editstatus: true,
                        kitemnumber: 32.0,
                        ilist: genderList,
                        initialval: gender,
                      ),
                      const SizedBox(height: 9),
                      PDropDown(
                        uptext: 'Addiction',
                        editstatus: true,
                        kitemnumber: 32.0,
                        ilist: addList,
                        initialval: addiction,
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
                            onTap: dt != null
                                ? () async {
                                    await showModalBottomSheet(
                                      context: context,
                                      builder: (context) => StatefulBuilder(
                                        builder: (context, setState) =>
                                            BottomSheetReset(
                                          currentdate: dt ?? DateTime.now(),
                                          formattedDate: formattedStartDate,
                                          formatter: formatter,
                                        ),
                                      ),
                                    ).then((value) {
                                      dt = value;
                                    });
                                    setState(() {
                                      formattedStartDate =
                                          formatter.format(dt as DateTime);
                                    });
                                  }
                                : () {},
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
                                child: Text(formattedStartDate,
                                    style: dt != null
                                        ? const TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Robotomono",
                                            fontWeight: FontWeight.w400)
                                        : const TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Robotomono",
                                            color: Colors.grey)),
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

class AvatarChangeScreen extends StatefulWidget {
  const AvatarChangeScreen({Key? key}) : super(key: key);

  @override
  State<AvatarChangeScreen> createState() => _AvatarChangeScreenState();
}

class _AvatarChangeScreenState extends State<AvatarChangeScreen> {
  final storageRef = FirebaseStorage.instance.ref();

  @override
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
            String imageUrl = snapshot.data['imageURL'];
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "Profile",
                ),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
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
                                ),
                        ),
                        SizedBox(height: 50),
                        FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection("Profile")
                                .doc('Avatars')
                                .get(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                List urlList = snapshot.data['URLs'];
                                return Center(
                                  child: Container(
                                    height: 350,
                                    width: 350,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      separatorBuilder: (context, int) {
                                        return Divider(
                                          color: Colors.black,
                                        );
                                      },
                                      itemCount: 5,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GridView.count(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          crossAxisCount: 3,
                                          children: List.generate(3, (index) {
                                            return Center(
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 75,
                                                child: Image.network(
                                                  urlList[0],
                                                  fit: BoxFit.fitHeight,
                                                  height: 120,
                                                  width: 90,
                                                ),
                                              ),
                                            );
                                          }),
                                        );
                                      },
                                      scrollDirection: Axis.vertical,
                                      physics: const ScrollPhysics(),
                                    ),
                                  ),
                                );
                              }
                            }),
                        SizedBox(
                          height: 30,
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
                    //Text
                  ],
                ),
              ),
            );
          }
        });
  }
}
