import 'package:aurora/screens/home.dart';
import 'package:aurora/screens/motivation_page.dart';
import 'package:aurora/services/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../widgets.dart';
import '../widgets/main/progress_bar.dart';
import '../widgets/main_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/motivation.dart';
import 'dart:math';

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
      if (daynumber == 1 &&
          widget.userData.data['wquotes'] == null &&
          widget.userData.data['motivations'] == null) {
        selectedmotivation = 'select';
        quoteday = true;
        selectedquote = 'select';
        motivationday = true;
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              MainAppBar(userData: widget.userData),
              const SizedBox(height: 30),
              Center(
                child: challengeStartDate != null
                    ? ProgressBar(
                        challengeDate: challengeStartDate,
                      )
                    : const SizedBox(),
              ),
              widget.userData.data['challengeStartDates'] == null
                  ? RoundedButton(
                      colour: Colors.white,
                      onPress: () {
                        UserService().startChallenge(Timestamp.fromDate(date));
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
              RoundedButton(
                colour: Colors.white,
                onPress: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) {
                        return MotivationScreen(userData: widget.userData);
                      },
                    ),
                  );
                },
                paddings: EdgeInsets.zero,
                title: const Text('Test Page'),
              ),
              Container(
                child: Column(
                  children: [
                    selectedmotivation != ''
                        ? FutureBuilder(
                            future: _motivationdata
                                .doc(widget.userData.data['addiction']
                                    .toLowerCase())
                                .get(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                motivationday == true
                                    ? selectedmotivation =
                                        motivationSelect(snapshot)
                                    : Container();
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Motivation(
                                          image: Image.asset(
                                            'images/motivation.png',
                                            width: 45,
                                            height: 45,
                                          ),
                                          body: selectedmotivation,
                                          height: 500.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          )
                        : Container(),
                    selectedquote != ''
                        ? FutureBuilder(
                            future: _motivationdata.doc('quotes').get(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                if (quoteday == true) {
                                  selectedquote = quoteSelect(snapshot)[0];
                                  selectedperson = quoteSelect(snapshot)[1];
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Center(
                                    child: Motivation(
                                        image: Image.asset(
                                          'images/quote.png',
                                          width: 45,
                                          height: 45,
                                        ),
                                        body: selectedquote,
                                        height: 500.0,
                                        quote: true,
                                        name: selectedperson),
                                  ),
                                );
                              }
                            })
                        : Container()
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
