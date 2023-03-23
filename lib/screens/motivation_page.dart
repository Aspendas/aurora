import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

import '../services/user_info.dart';
import '../widgets/motivation.dart';

class MotivationScreen extends StatefulWidget {
  final AsyncSnapshot userData;

  const MotivationScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<MotivationScreen> createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen>
    with TickerProviderStateMixin {
  late final userDataget;
  late final AnimationController _guitarController =
      AnimationController(vsync: this, duration: const Duration(seconds: 2));

  void dispose() {
    _guitarController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userDataget = UserService().getUserInfo();
    // set initial value
    _guitarController.forward();
    _guitarController.addListener(() {
      if (_guitarController.isCompleted) {
        _guitarController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: FutureBuilder(
              future: userDataget,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Opacity(
                              opacity: 0.3,
                              child: Lottie.asset(
                                'images/motivation_illustration.json',
                                controller: _guitarController,
                                width: 600,
                                height: 600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: snapshot.data['motivations'] != null &&
                                snapshot.data['wquotes'] != null
                            ? ListView(
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 30, 20, 30),
                                    child: Text(
                                      "You can see past motivation phrases and weekly quotes",
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        snapshot.data['wquotes'].length < 2
                                            ? snapshot.data['wquotes'].length
                                            : 2,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: Motivation(
                                          image: Image.asset(
                                            'images/quote.png',
                                            width: 45,
                                            height: 45,
                                          ),
                                          body: snapshot.data['wquotes'][index],
                                          height: 500.0,
                                          quote: true,
                                          name: snapshot.data['wquotenames']
                                              [index],
                                        ),
                                      );
                                    },
                                  ),
                                  Column(
                                    children: [
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data['motivations']
                                                    .length <
                                                3
                                            ? snapshot
                                                .data['motivations'].length
                                            : 3,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12.0),
                                            child: Motivation(
                                              image: Image.asset(
                                                'images/motivation.png',
                                                width: 45,
                                                height: 45,
                                              ),
                                              body: snapshot.data['motivations']
                                                  [index],
                                              height: 500.0,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 32),
                                    ],
                                  )
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    'You have no past motivation phrases or quotes right now',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 30),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  );
                }
              })),
    );
  }
}
