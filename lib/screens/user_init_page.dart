import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aurora/widgets.dart';
import '../screens/home.dart';
import 'package:aurora/services/auth.dart';
import "package:aurora/services/user_info.dart";

class userInitScreen extends StatefulWidget {
  const userInitScreen({Key? key}) : super(key: key);

  @override
  State<userInitScreen> createState() => _userInitScreenState();
}

class _userInitScreenState extends State<userInitScreen> {
  late String dropdownValue;
  List listItem = ["1", "2", "3"];
  String? bioGender;
  String? addictionType;
  int age = 15;
  String? name;
  late final TextEditingController _name;

  @override
  void initState() {
    _name = TextEditingController();
    super.initState();
  }

  final genderList = <String>[
    'Male',
    'Female',
  ];

  final ageList = List<Widget>.generate(
      111,
      (int index) => Center(
            child: Text(
              "${index + 15}",
            ),
          ),
      growable: true);

  final addList = <String>['Alcohol', 'Tobacco', 'Substance'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFDAF0F0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: SafeArea(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              Image.asset(
                "images/logo_aurora.png",
                width: 300,
                height: 70,
              ),
              const SizedBox(height: 70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: Text(
                      'Name and Surname *',
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
                        fontWeight: FontWeight.w600),
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
              const SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: Text(
                      'Age *',
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
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: Text(
                      'Biological Gender *',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
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
                            vertical: 8.0, horizontal: 15),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(10),
                            value: bioGender,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: "Robotomono",
                                fontWeight: FontWeight.w600),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                bioGender = "$value";
                              });
                            },
                            items: genderList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: Text(
                      'Addiction you want to quit *',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
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
                            vertical: 8.0, horizontal: 15),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(10),
                            value: addictionType,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: "Robotomono",
                                fontWeight: FontWeight.w600),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                addictionType = "$value";
                              });
                            },
                            items: addList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButton(
                    colour: Colors.white,
                    title: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.redAccent,
                      ),
                    ),
                    paddings: EdgeInsets.fromLTRB(0, 35, 15, 0),
                    onPress: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        title: const Text('Are you sure you want to sign out?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              AuthService().signOut(context);
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  RoundedButton(
                      colour: Colors.white,
                      title: const Text(
                        'Let\'s start  ➔',
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                        ),
                      ),
                      paddings: EdgeInsets.fromLTRB(15, 35, 0, 0),
                      onPress: () async {
                        if (bioGender != null &&
                            age != null &&
                            _name.text != "" &&
                            addictionType != null) {
                          UserService().setUserInfo(
                              addictionType, bioGender, age, _name.text);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                            return const HomeScreen();
                          }), (route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('All fields are required.'),
                            ),
                          );
                        }
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
