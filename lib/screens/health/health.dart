import 'package:aurora/screens/health/activities.dart';
import 'package:aurora/screens/health/test.dart';
import 'package:aurora/services/activities.dart';

import 'package:aurora/widgets/health/activity_reverse.dart';
import 'package:aurora/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widgets/health/activity.dart';

class HealthScreen extends StatefulWidget {
  final AsyncSnapshot userData;
  const HealthScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  bool healthScreenToggle = true;

  @override
  Widget build(BuildContext context) {
    var activities = ActivityService().getActivities();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              MainAppBar(userData: widget.userData),
              SizedBox(
                height: 60,
                child: ArchedLine(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: healthScreenToggle == true
                    ? Row(
                        children: [
                          const Text(
                            "Activities -",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          GestureDetector(
                            child: const Text(
                              " Test",
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              setState(() {
                                healthScreenToggle = false;
                              });
                            },
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                healthScreenToggle = true;
                              });
                            },
                            child: const Text(
                              "Activities ",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          const Text(
                            "- Test",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              HealthWrapper(
                  activities: activities,
                  userData: widget.userData,
                  toggle: healthScreenToggle),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArchedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ArchedLinePainter(),
      child: Container(),
    );
  }
}

class _ArchedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    var path = Path()
      ..moveTo(0, size.height / 2)
      ..quadraticBezierTo(size.width / 2, 0, size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class HealthWrapper extends StatelessWidget {
  const HealthWrapper(
      {Key? key,
      required this.userData,
      required this.toggle,
      required this.activities})
      : super(key: key);
  final AsyncSnapshot userData;
  final bool toggle;
  final activities;

  @override
  Widget build(BuildContext context) {
    if (toggle == true) {
      return ActivitiesScreen(
        activities: activities,
        userData: userData,
      );
    } else {
      return TestScreen(
        userData: userData,
      );
    }
  }
}
