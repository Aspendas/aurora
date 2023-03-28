import 'package:aurora/screens/home.dart';

import 'package:aurora/services/user_info.dart';

import 'package:flutter/cupertino.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../constants.dart';
import '../services/activities.dart';
import '../widgets.dart';
import '../widgets/health/activity.dart';
import '../widgets/main/progress_bar.dart';
import '../widgets/main_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/motivation.dart';
import 'dart:math';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import 'health/health.dart';

Random random = Random();

class MainScreen extends StatefulWidget {
  final AsyncSnapshot userData;

  const MainScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late var data = widget.userData.data;
  final _motivationdata = FirebaseFirestore.instance.collection("motivation");

  final date = DateTime.now();
  bool visib = false;
  final List<int> milestones = [
    1,
    7,
    14,
    30,
    90,
    180,
    360,
  ];
  var milestone = false;
  var quoteday = false;
  var motivationday = false;
  var selectedquote = '';
  var selectedmotivation = '';
  var selectedperson = '';
  var motivrandom = 0;
  var quoterandom = 0;

  var motivation;
  var quotefuture;
  var activities;
  late int feel;
  var randomactivity;
  var visible;
  var emotionbool;

  @override
  void initState() {
    motivation = _motivationdata
        .doc(widget.userData.data['addiction'].toLowerCase())
        .get();
    quotefuture = _motivationdata.doc('quotes').get();

    activities = ActivityService().getActivities();
    visible = true;
    feel = 5;
    randomactivity = 0;
    emotionbool = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var challengeStartDate = data["challengeStartDates"]?.toDate();
    if (widget.userData.data['challengeStartDates'] != null) {
      final dt =
          (widget.userData.data['challengeStartDates'] as Timestamp).toDate();
      final daynumber = daysBetween(dt, date);

      if (milestones.asMap().containsValue(daynumber)) {
        milestone = true;
      }
      var emotionday = widget.userData.data['dailyemotiondate'] != null
          ? daysBetween(
              (widget.userData.data['dailyemotiondate'] as Timestamp).toDate(),
              date)
          : daynumber;

      if (daynumber >= 1 &&
          widget.userData.data['wquotes'] == null &&
          widget.userData.data['motivations'] == null) {
        selectedmotivation = 'select';
        quoteday = true;
        selectedquote = 'select';
        motivationday = true;
      }
      if (emotionday >= 1) {
        emotionbool = true;
        UserService().updateUserEmotion(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));
      }

      if (widget.userData.data['wquotes'] != null &&
          widget.userData.data['motivations'] != null) {
        final DateTime quotedays =
            (widget.userData.data['wquotesday'][0] as Timestamp).toDate();
        final quotedaynumber = daysBetween(quotedays, date);
        final DateTime motivationdays =
            (widget.userData.data['motivationsdate'][0] as Timestamp).toDate();
        final motivationdaynumber = daysBetween(motivationdays, date);

        if (quotedaynumber >= 7) {
          quoteday = true;
        }

        if (motivationdaynumber >= 3) {
          motivationday = true;
        }
        visib = true;
        selectedquote = widget.userData.data['wquotes'][0];
        selectedmotivation = widget.userData.data['motivations'][0];
        selectedperson = widget.userData.data['wquotenames'][0];
      }
    }
    return Scaffold(
      backgroundColor: const Color(0xffDAF0F0),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MainAppBar(userData: widget.userData),
              const SizedBox(
                height: 15,
              ),
              Flexible(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            offset: Offset(0.0, -1.0),
                            color: Colors.white,
                            inset: true,
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(100, 100, 100, 0.7),
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6,
                            inset: true,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(125, 25),
                            topRight: Radius.elliptical(125, 25)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: challengeStartDate != null
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 5, 15, 5),
                                        child: RichText(
                                          text: TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              const TextSpan(
                                                  text: 'I\'ve been '),
                                              TextSpan(
                                                  text:
                                                      '${widget.userData.data['addiction'].toLowerCase()} free',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const TextSpan(
                                                  text: ' for exactly'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            './images/1111.png',
                                            fit: BoxFit.fitHeight,
                                            height: 30,
                                          ),
                                          Image.asset(
                                            './images/1112.png',
                                            fit: BoxFit.fitHeight,
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      ProgressBar(
                                          challengeDate: challengeStartDate,
                                          width: 75,
                                          height: 75),
                                    ],
                                  )
                                : const SizedBox(),
                          ),
                          widget.userData.data['challengeStartDates'] == null
                              ? RoundedButton(
                                  colour: Colors.white,
                                  onPress: () {
                                    UserService().startChallenge(
                                        Timestamp.fromDate(date));
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) {
                                          return const HomeScreen();
                                        },
                                      ),
                                    );
                                  },
                                  paddings: EdgeInsets.zero,
                                  title: const Text('Start Challenge'),
                                )
                              : Container(),
                          const SizedBox(
                            height: 0,
                          ),
                          emotionbool
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 15),
                                  child: StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              16, 0, 16, 20),
                                          child: Text(
                                            'How are you feeling right now?',
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontFamily: 'robotomono',
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: visible
                                                ? const Color.fromRGBO(
                                                    230, 222, 222, 1)
                                                : Colors.grey,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset:
                                                    Offset(0.0, 1.0), //(x,y)
                                                blurRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Visibility(
                                                visible: visible,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 15, 0, 15),
                                                      child: Image.asset(
                                                          'images/sos.png',
                                                          width: 30,
                                                          height: 30),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 15, 8, 15),
                                                        child: SliderTheme(
                                                          data: SliderTheme.of(
                                                                  context)
                                                              .copyWith(
                                                            inactiveTrackColor:
                                                                const Color(
                                                                    0xFF8D8E98),
                                                            activeTrackColor:
                                                                Colors.black,
                                                            thumbColor:
                                                                const Color(
                                                                    0xFFEB1555),
                                                            overlayColor:
                                                                const Color(
                                                                    0x29EB1555),
                                                            thumbShape:
                                                                const RoundSliderThumbShape(
                                                                    enabledThumbRadius:
                                                                        10.0),
                                                            overlayShape:
                                                                const RoundSliderOverlayShape(
                                                                    overlayRadius:
                                                                        15.0),
                                                          ),
                                                          child: Slider(
                                                              value: feel
                                                                  .toDouble(),
                                                              min: 0,
                                                              max: 10,
                                                              onChangeEnd:
                                                                  (double
                                                                      newValue) {
                                                                setState(() {
                                                                  visible =
                                                                      false;
                                                                });
                                                              },
                                                              onChanged: (double
                                                                  newValue) {
                                                                setState(() {
                                                                  feel = newValue
                                                                      .round();
                                                                });
                                                              }),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 15, 10, 15),
                                                      child: Image.asset(
                                                        'images/strong.png',
                                                        width: 30,
                                                        height: 30,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: visible != true,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Visibility(
                                                      visible:
                                                          visible != true &&
                                                                  feel <= 3
                                                              ? true
                                                              : false,
                                                      child: const Padding(
                                                        padding: EdgeInsets.all(
                                                            25.0),
                                                        child: Text(
                                                          'If you think you are not going to continue your challenging path you can get help from professionals to continue. (You can find the organizations that can help you from top left corner)',
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Visibility(
                                                        visible:
                                                            visible != true &&
                                                                    feel > 3 &&
                                                                    feel < 8
                                                                ? true
                                                                : false,
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  25.0),
                                                          child: Text(
                                                            'You are doing great! You will definitely succeed. Keep going 👍',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible:
                                                          visible != true &&
                                                                  feel >= 8
                                                              ? true
                                                              : false,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(25),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Text(
                                                              'Nothing can stop the man with the right mental attitude from achieving his goal; nothing on earth can help the man with the wrong mental attitude.',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              '– Thomas Jefferson',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                )
                              : Container(),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              selectedmotivation != ''
                                  ? FutureBuilder(
                                      future: motivation,
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          motivationday == true
                                              ? selectedmotivation =
                                                  motivationSelect(snapshot)
                                              : Container();
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 25,
                                                        right: 16,
                                                        top: 16),
                                                    child: Text(
                                                      'Daily Motivation',
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontFamily:
                                                              'robotomono',
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Motivation(
                                                    image: Image.asset(
                                                      'images/motivation.png',
                                                      width: 45,
                                                      height: 45,
                                                    ),
                                                    body: selectedmotivation,
                                                    height: 500.0,
                                                    quote: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 5,
                              ),
                              selectedquote != ''
                                  ? FutureBuilder(
                                      future: quotefuture,
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          if (quoteday == true) {
                                            selectedquote =
                                                quoteSelect(snapshot)[0];
                                            selectedperson =
                                                quoteSelect(snapshot)[1];
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Column(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Motivation(
                                                        image: Image.asset(
                                                          'images/quote.png',
                                                          width: 45,
                                                          height: 45,
                                                        ),
                                                        body: selectedquote,
                                                        height: 500.0,
                                                        quote: true,
                                                        name: selectedperson,
                                                        main: true,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      })
                                  : Container(),
                              const SizedBox(
                                height: 15,
                              ),
                              FutureBuilder(
                                  future: activities,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      randomactivity = randomNumberGenerator(
                                          snapshot.data.docs.length);
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 25, right: 16, top: 15),
                                            child: Text(
                                              'Need Distraction ?',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontFamily: 'robotomono',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Activity(
                                            data: snapshot
                                                .data.docs[randomactivity]
                                                .data(),
                                            shadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset:
                                                    Offset(0.0, 1.0), //(x,y)
                                                blurRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }
                                  }),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  int randomNumberGenerator(length) {
    return random.nextInt(length);
  }

  motivationSelect(snapshot) {
    motivrandom = randomNumberGenerator(snapshot.data['general'].length);

    selectedmotivation = snapshot.data['general'][motivrandom];
    if (widget.userData.data['motivations'] != null) {
      while (widget.userData.data['motivations']
          .asMap()
          .containsValue(selectedmotivation)) {
        motivrandom = randomNumberGenerator(snapshot.data['general'].length);
        selectedmotivation = snapshot.data['general'][motivrandom];
      }
    }

    if (widget.userData.data['motivations'] != null) {
      var motivlist = [
        selectedmotivation,
        ...widget.userData.data['motivations']
      ];
      Timestamp motivTime = Timestamp.fromDate(date);
      var motivtimelist = [
        motivTime,
        ...widget.userData.data['motivationsdate']
      ];
      UserService().updateUserMotivation(motivlist, motivtimelist);
    } else {
      var motivlist = [selectedmotivation];
      Timestamp motivTime = Timestamp.fromDate(date);
      var motivtimelist = [motivTime];
      UserService().updateUserMotivation(motivlist, motivtimelist);
    }
    return selectedmotivation;
  }

  quoteSelect(snapshot) {
    quoterandom = randomNumberGenerator(snapshot.data['quotes'].length);

    selectedquote = snapshot.data['quotes'][quoterandom];
    if (widget.userData.data['wquotes'] != null) {
      while (widget.userData.data['wquotes']
          .asMap()
          .containsValue(selectedquote)) {
        quoterandom = randomNumberGenerator(snapshot.data['quotes'].length);
        selectedquote = snapshot.data['quotes'][quoterandom];
      }
    }
    selectedperson = snapshot.data['person'][quoterandom];
    if (widget.userData.data['wquotes'] != null) {
      var quotelist = [selectedquote, ...widget.userData.data['wquotes']];
      Timestamp quoteday = Timestamp.fromDate(date);
      var quotetimelist = [quoteday, ...widget.userData.data['wquotesday']];
      var quotenamelist = [
        selectedperson,
        ...widget.userData.data['wquotenames']
      ];
      UserService().updateUserQuote(quotelist, quotetimelist, quotenamelist);
    } else {
      var quotelist = [selectedquote];
      Timestamp quoteday = Timestamp.fromDate(date);
      var quotetimelist = [quoteday];
      var quotenamelist = [selectedperson];
      UserService().updateUserQuote(quotelist, quotetimelist, quotenamelist);
    }
    return [selectedquote, selectedperson];
  }
}
