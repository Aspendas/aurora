import 'package:aurora/screens/home.dart';
import 'package:aurora/services/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:intl/intl.dart';

class InputField extends StatelessWidget {
  InputField(
      {required this.hinttext,
      required this.iconl,
      required this.passw,
      required this.paddings});

  final String hinttext;
  final Icon iconl;
  final bool passw;
  final paddings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddings,
      child: TextField(
        obscureText: passw,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15, 17, 15, 17),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: iconl,
          hintText: hinttext,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.title,
      required this.colour,
      required this.onPress,
      required this.paddings});

  final Color colour;
  final Text title;
  final paddings;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddings,
      child: Material(
        elevation: 4,
        color: colour,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.black, width: 1.5),
        ),
        child: MaterialButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            onPressed: onPress,
            height: 50.0,
            child: title),
      ),
    );
  }
}

class PAsyncButton extends StatelessWidget {
  PAsyncButton(
      {required this.title,
      required this.colour,
      required this.onPress,
      required this.paddings});

  final Color colour;
  final Text title;
  final paddings;
  final onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddings,
      child: AsyncButtonBuilder(
        onPressed: onPress,
        loadingWidget: const SizedBox(
          height: 16.0,
          width: 16.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        ),
        successWidget: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.check,
            color: Colors.black,
          ),
        ),
        loadingSwitchInCurve: Curves.bounceInOut,
        loadingTransitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1.0),
              end: const Offset(0, 0),
            ).animate(animation),
            child: child,
          );
        },
        builder: (context, child, callback, state) {
          return GestureDetector(
            onTap: callback,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                child: child,
              ),
            ),
          );
        },
        child: title,
      ),
    );
  }
}

class PDropDown extends StatefulWidget {
  final kitemnumber;
  var title;
  final ilist;
  final bool editstatus;
  var initialval;
  final String uptext;
  final Function(String?)? onChanged;

  PDropDown(
      {Key? key,
      this.title,
      this.kitemnumber,
      required this.editstatus,
      this.ilist,
      this.initialval,
      required this.uptext,
      this.onChanged})
      : super(key: key);

  @override
  State<PDropDown> createState() => _PDropDownState();
}

class _PDropDownState extends State<PDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
          child: Text(
            widget.uptext,
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
          height: 40,
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
              child: widget.editstatus
                  ? DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        value: widget.initialval,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Robotomono",
                            fontWeight: FontWeight.w400),
                        onChanged: widget.onChanged,
                        items: widget.ilist
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )
                  : widget.title),
        ),
      ],
    );
  }
}

class BottomSheetReset extends StatefulWidget {
  DateTime currentdate;
  String formattedDate;
  final DateFormat formatter;

  BottomSheetReset({
    Key? key,
    required this.currentdate,
    required this.formattedDate,
    required this.formatter,
  }) : super(key: key);

  @override
  State<BottomSheetReset> createState() => _BottomSheetResetState();
}

class _BottomSheetResetState extends State<BottomSheetReset> {
  var currentdate;
  var currenttime;
  @override
  Widget build(BuildContext context) {
    currentdate = widget.currentdate;
    return Container(
      color: Color(0xff757575),
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              )),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(34, 30, 34, 75),
              child: Column(children: [
                const Text(
                  'Edit Challenge Start Date',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'RobotoMono'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 0.5,
                              ),
                            ),
                            child: IconButton(
                              iconSize: 50,
                              icon: const Icon(
                                Icons.cancel,
                              ),
                              tooltip: 'Reset challenge start time',
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  title: const Text(
                                      'Are you sure you want to end the challenge?',
                                      style: TextStyle(
                                          fontFamily: 'RobotoMono',
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black,
                                          fontSize: 17)),
                                  content: RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                '“Every worthy act is difficult. Ascent is always difficult. Descent is easy and often slippery.”\n\n',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: '– Mahatma Gandhi',
                                            style: TextStyle(
                                                fontFamily: 'RobotoMono',
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        var navigator = Navigator.of(context);
                                        await UserService().endChallenge();
                                        navigator.push(
                                          CupertinoPageRoute(
                                            builder: (context) {
                                              return const HomeScreen();
                                            },
                                          ),
                                        );
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'End Challenge',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 0.5,
                              ),
                            ),
                            child: IconButton(
                                iconSize: 50,
                                icon: const Icon(
                                  Icons.calendar_month,
                                ),
                                tooltip: 'Reset challenge start time',
                                onPressed: () async {
                                  var navigator = Navigator.of(context);
                                  final date = await pickDate();
                                  if (date == null) return;

                                  final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(
                                          hour: DateTime.now().hour,
                                          minute: DateTime.now().minute));

                                  if (time == null) return;

                                  setState(() {
                                    currentdate = date;
                                    currenttime = time;
                                  });
                                  var resettime = DateTime(
                                      currentdate.year,
                                      currentdate.month,
                                      currentdate.day,
                                      currenttime.hour,
                                      currenttime.minute);
                                  await UserService().resetChallenge(
                                      Timestamp.fromDate(resettime));
                                  navigator.push(
                                    CupertinoPageRoute(
                                      builder: (context) {
                                        return const HomeScreen();
                                      },
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Text('Set Challenge Start Time',
                              style: TextStyle(fontSize: 10)),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 0.5,
                              ),
                            ),
                            child: IconButton(
                              iconSize: 50,
                              icon: const Icon(
                                Icons.rotate_left_sharp,
                              ),
                              tooltip: 'Reset challenge start time',
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  title: const Text(
                                      'Are you sure you want to reset the counter?',
                                      style: TextStyle(
                                          fontFamily: 'RobotoMono',
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black,
                                          fontSize: 17)),
                                  content: RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                '“Our greatest glory is not in never failing, but in rising up every time we fail.”\n\n',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: '– Ralph Waldo Emerson',
                                            style: TextStyle(
                                                fontFamily: 'RobotoMono',
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        var navigator = Navigator.of(context);
                                        await UserService()
                                            .resetChallenge(DateTime.now());
                                        navigator.push(
                                          CupertinoPageRoute(
                                            builder: (context) {
                                              return const HomeScreen();
                                            },
                                          ),
                                        );
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Reset Challenge',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100));
}
