import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'dart:async';

class ProgressBar extends StatefulWidget {
  const ProgressBar(
      {Key? key,
      required this.challengeDate,
      required this.width,
      required this.height})
      : super(key: key);
  final DateTime challengeDate;
  final double width;
  final double height;

  @override
  State<ProgressBar> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressBar> {
  late final DateTime _now = DateTime.now();
  late final DateTime _challengeDate = widget.challengeDate;
  late final _difference = _now.difference(_challengeDate);
  late final int _secondsDifference = _difference.inSeconds;
  late final int _minutesDifference = _difference.inMinutes;

  late double second = _difference.inSeconds.toDouble() % 60;
  late double minute = _difference.inMinutes.toDouble() % 60;
  late double hour = _difference.inHours.toDouble() % 24;
  late double day = _difference.inDays.toDouble();
  late ValueNotifier<double> valueNotifier;
  late ValueNotifier<double> secondNotifier;
  late ValueNotifier<double> minuteNotifier;
  late ValueNotifier<double> hoursNotifier;
  late ValueNotifier<double> daysNotifier;
  var timer;
  @override
  void initState() {
    super.initState();
    valueNotifier = ValueNotifier(second);
    secondNotifier = ValueNotifier(second);
    minuteNotifier = ValueNotifier(minute);
    hoursNotifier = ValueNotifier(hour);
    daysNotifier = ValueNotifier(day);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondNotifier.value < 59) {
          secondNotifier.value = secondNotifier.value + 1;
        } else if (secondNotifier.value == 59) {
          secondNotifier.value = 0;
          if (minuteNotifier.value < 59) {
            minuteNotifier.value++;
          } else {
            minuteNotifier.value = 0;
            if (hoursNotifier.value < 23) {
              hoursNotifier.value++;
            } else {
              hoursNotifier.value = 0;
              daysNotifier.value++;
            }
          }
        }
      });
    });
  }

  @override
  void dispose() {
    secondNotifier.dispose();
    minuteNotifier.dispose();
    hoursNotifier.dispose();
    daysNotifier.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: widget.width,
              height: widget.height,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white, Colors.grey],
                  stops: [0.9, 1],
                ),
              ),
              child: daysNotifier.value > 59
                  ? SimpleCircularProgressBar(
                      valueNotifier: daysNotifier,
                      maxValue: 360,
                      progressStrokeWidth: 7,
                      backStrokeWidth: 7,
                      progressColors: const [
                        Color(0XFFCFE3E3),
                        Color(0XFFB7C9C9),
                        Color(0XFF95A3A3),
                        Color(0XFF5A6363)
                      ],
                      backColor: Color(0xfff2f2ff),
                      animationDuration: 2,
                      size: 48,
                      onGetText: (double value) {
                        return Text(
                          '${value.toInt()}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600),
                        );
                      },
                    )
                  : SimpleCircularProgressBar(
                      valueNotifier: daysNotifier,
                      maxValue: 60,
                      progressStrokeWidth: 7,
                      backStrokeWidth: 7,
                      progressColors: const [
                        Color(0XFFCFE3E3),
                        Color(0XFFB7C9C9),
                        Color(0XFF95A3A3),
                        Color(0XFF5A6363)
                      ],
                      backColor: Color(0xfff2f2ff),
                      animationDuration: 2,
                      size: 48,
                      onGetText: (double value) {
                        return Text(
                          '${value.toInt()}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600),
                        );
                      },
                    ),
            ),
            const Text(
              "Days",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w600),
            )
          ],
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: widget.width,
              height: widget.height,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white, Colors.grey],
                  stops: [0.9, 1],
                ),
              ),
              child: SimpleCircularProgressBar(
                valueNotifier: hoursNotifier,
                maxValue: 24,
                progressStrokeWidth: 7,
                backStrokeWidth: 7,
                progressColors: const [
                  Color(0XFFCFE3E3),
                  Color(0XFFB7C9C9),
                  Color(0XFF95A3A3),
                  Color(0XFF5A6363)
                ],
                backColor: Color(0xfff2f2ff),
                animationDuration: 2,
                size: 48,
                onGetText: (double value) {
                  return Text(
                    '${value.toInt()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.w600),
                  );
                },
              ),
            ),
            const Text(
              "Hours",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w600),
            )
          ],
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: widget.width,
              height: widget.height,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white, Colors.grey],
                  stops: [0.9, 1],
                ),
              ),
              child: SimpleCircularProgressBar(
                valueNotifier: minuteNotifier,
                maxValue: 60,
                progressStrokeWidth: 7,
                backStrokeWidth: 7,
                progressColors: const [
                  Color(0XFFCFE3E3),
                  Color(0XFFB7C9C9),
                  Color(0XFF95A3A3),
                  Color(0XFF5A6363)
                ],
                backColor: Color(0xfff2f2ff),
                animationDuration: 2,
                size: 48,
                onGetText: (double value) {
                  return Text(
                    '${value.toInt()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.w600),
                  );
                },
              ),
            ),
            const Text(
              "Minutes",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w600),
            )
          ],
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: widget.width,
              height: widget.height,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white, Colors.grey],
                  stops: [0.9, 1],
                ),
              ),
              child: SimpleCircularProgressBar(
                valueNotifier: secondNotifier,
                maxValue: 60,
                progressStrokeWidth: 7,
                backStrokeWidth: 7,
                progressColors: const [
                  Color(0XFFCFE3E3),
                  Color(0XFFB7C9C9),
                  Color(0XFF95A3A3),
                  Color(0XFF5A6363)
                ],
                backColor: Color(0xfff2f2ff),
                animationDuration: 2,
                size: 48,
                onGetText: (double value) {
                  return Text(
                    '${value.toInt()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.w600),
                  );
                },
              ),
            ),
            const Text(
              "Seconds",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ],
    );
  }
}
