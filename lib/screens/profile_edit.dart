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

import 'home.dart';

final user = FirebaseAuth.instance.currentUser;
final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');

class ProfileEditScreen extends StatefulWidget {
  final userData;

  const ProfileEditScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late String formattedStartDate;
  late Future UserInfo;
  late String gender;
  final TextEditingController _name = TextEditingController();

  late int age = widget.userData.data['age'];
  late String addiction = widget.userData.data['addiction'];

  @override
  void initState() {
    super.initState();
    gender = widget.userData.data['gender'];
    age = widget.userData.data['age'];
    addiction = widget.userData.data['addiction'];
    _name.text = widget.userData.data['name'];
    UserInfo = UserService().getUserInfo();
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
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
        growable: true);

    final addList = <String>['Alcohol', 'Tobacco', 'Substance'];

    var dt = widget.userData.data['challengeStartDates'] != null
        ? (widget.userData.data['challengeStartDates'] as Timestamp).toDate()
        : null;

    var formattedStartDate = dt != null
        ? formatter.format(dt)
        : 'You have not started a challenge yet. You can start it on main screen ';

    var imageUrl = widget.userData.data['imageURL'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xffCFE3E3),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
          ),
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
                              fontFamily: 'RobotoMono',
                            ),
                          ), //Text
                  ),
                ),
                const SizedBox(height: 11),
                InkWell(
                  onTap: () async {
                    var navigator = Navigator.of(context);
                    final avatarURLs = await FirebaseFirestore.instance
                        .collection("Profile")
                        .doc('Avatars')
                        .get();
                    navigator.push(
                      CupertinoPageRoute(
                        builder: (context) {
                          return AvatarChangeScreen(
                            userData: widget.userData,
                            avatarURLs: avatarURLs,
                          );
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
                      color: Color(0xFF886EE5),
                    ),
                  ),
                ),
                const SizedBox(height: 62),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                      child: Text(
                        'Name and Surname',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextField(
                      controller: _name,
                      keyboardType: TextInputType.name,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Robotomono",
                          fontWeight: FontWeight.w400),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: "Robotomono",
                            fontSize: 18.0),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        hintText: "Name Surname",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
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
                                scrollController: FixedExtentScrollController(),
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
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(
                      () {
                        gender = "$value";
                      },
                    );
                  },
                ),
                const SizedBox(height: 9),
                PDropDown(
                  uptext: 'Addiction',
                  editstatus: true,
                  kitemnumber: 32.0,
                  ilist: addList,
                  initialval: addiction,
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      addiction = "$value";
                    });
                  },
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
                              setState(
                                () {
                                  formattedStartDate =
                                      formatter.format(dt as DateTime);
                                },
                              );
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
                          child: Text(
                            formattedStartDate,
                            style: dt != null
                                ? const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Robotomono",
                                    fontWeight: FontWeight.w400)
                                : const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Robotomono",
                                    color: Colors.grey,
                                  ),
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
                    UserService()
                        .updateUserInfo(addiction, gender, age, _name.text);
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(builder: (context) {
                      return const HomeScreen();
                    }), (route) => false);
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
}

class AvatarChangeScreen extends StatefulWidget {
  final userData;
  final avatarURLs;

  const AvatarChangeScreen(
      {Key? key, required this.userData, required this.avatarURLs})
      : super(key: key);

  @override
  State<AvatarChangeScreen> createState() => _AvatarChangeScreenState();
}

class _AvatarChangeScreenState extends State<AvatarChangeScreen> {
  final storageRef = FirebaseStorage.instance.ref();
  late var selectedAvatar = widget.userData.data['imageURL'];
  late Future userData;
  late Future avatars;
  late final List urlList;

  @override
  void initState() {
    userData = UserService().getUserInfo();
    avatars =
        FirebaseFirestore.instance.collection("Profile").doc('Avatars').get();
    // initial load
    selectedAvatar = widget.userData.data['imageURL'];
    urlList = widget.avatarURLs['URLs'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xffDAF0F0),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Avatar Change",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Column(
              children: [
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
                    radius: 50,
                    child: selectedAvatar != null
                        ? Image.network(
                            selectedAvatar,
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
                          ),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: SizedBox(
                    height: 350,
                    width: 350,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        final item = urlList[index];
                        return GridTile(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 7.5, 8, 7.5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedAvatar = item;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedAvatar == item
                                        ? Colors.blue
                                        : Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 75,
                                    child: Image.network(
                                      item,
                                      fit: BoxFit.fitHeight,
                                      height: 120,
                                      width: 90,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 9,
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RoundedButton(
                  colour: Colors.white,
                  paddings: const EdgeInsets.all(8),
                  onPress: () {
                    UserService().userAvatarChange(selectedAvatar);
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(builder: (context) {
                      return const HomeScreen();
                    }), (route) => false);
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
            ), //Text
          ],
        ),
      ),
    );
  }
}
