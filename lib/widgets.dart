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

  PDropDown(
      {Key? key,
      this.title,
      this.kitemnumber,
      required this.editstatus,
      this.ilist,
      this.initialval,
      required this.uptext})
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
                            fontWeight: FontWeight.w600),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            widget.initialval = "$value";
                          });
                        },
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
  @override
  Widget build(BuildContext context) {
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
                  'Reset Challenge Start Date',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'RobotoMono'),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                iconSize: 100,
                                icon: Icon(
                                  Icons.calendar_month,
                                ),
                                tooltip: 'Reset challenge start time',
                                onPressed: () async {
                                  final date = await pickDate();
                                  if (date == null) return;
                                  setState(() {
                                    widget.currentdate = date;
                                    widget.formattedDate =
                                        widget.formatter.format(date);
                                  });
                                  print(date);
                                  print(widget.formattedDate);
                                  Navigator.pop(context, date);
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
                              iconSize: 100,
                              icon: Icon(
                                Icons.rotate_left_sharp,
                              ),
                              tooltip: 'Reset challenge start time',
                              onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
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
                                      onPressed: () =>
                                          Navigator.pop(context, 'Yes'),
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
      initialDate: widget.currentdate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100));
}
