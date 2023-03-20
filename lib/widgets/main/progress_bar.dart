import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'dart:async';

class ProgressBar extends StatefulWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressBar> {
  final DateTime _now = DateTime.now();
  late double second = _now.second.toDouble();
  late ValueNotifier<double> valueNotifier;
  @override
  void initState() {
    super.initState();
    valueNotifier = ValueNotifier(second);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        second++;
        valueNotifier.value++;
      });
    });
  }

  @override
  void dispose() {
    valueNotifier.dispose();
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
              width: 55,
              height: 55,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.fromARGB(31, 179, 149, 86),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                  stops: [0.9, 1],
                ),
              ),
              child: SimpleCircularProgressBar(
                valueNotifier: valueNotifier,
                maxValue: 60,
                progressStrokeWidth: 4,
                backStrokeWidth: 4,
                progressColors: const [
                  Colors.orangeAccent,
                  Colors.orange,
                  Colors.deepOrangeAccent,
                  Colors.deepOrange
                ],
                backColor: const Color.fromARGB(255, 244, 207, 158),
                animationDuration: 2,
                size: 36,
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
              width: 55,
              height: 55,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.fromARGB(31, 179, 149, 86),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                  stops: [0.9, 1],
                ),
              ),
              child: SimpleCircularProgressBar(
                valueNotifier: valueNotifier,
                maxValue: 60,
                progressStrokeWidth: 4,
                backStrokeWidth: 4,
                progressColors: const [
                  Colors.orangeAccent,
                  Colors.orange,
                  Colors.deepOrangeAccent,
                  Colors.deepOrange
                ],
                backColor: const Color.fromARGB(255, 244, 207, 158),
                animationDuration: 2,
                size: 36,
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
              width: 55,
              height: 55,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.fromARGB(31, 179, 149, 86),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                  stops: [0.9, 1],
                ),
              ),
              child: SimpleCircularProgressBar(
                valueNotifier: valueNotifier,
                maxValue: 60,
                progressStrokeWidth: 4,
                backStrokeWidth: 4,
                progressColors: const [
                  Colors.orangeAccent,
                  Colors.orange,
                  Colors.deepOrangeAccent,
                  Colors.deepOrange
                ],
                backColor: const Color.fromARGB(255, 244, 207, 158),
                animationDuration: 2,
                size: 36,
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
              width: 55,
              height: 55,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.fromARGB(31, 179, 149, 86),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                  stops: [0.9, 1],
                ),
              ),
              child: SimpleCircularProgressBar(
                valueNotifier: valueNotifier,
                maxValue: 60,
                progressStrokeWidth: 4.5,
                backStrokeWidth: 3,
                progressColors: const [
                  Colors.orangeAccent,
                  Colors.orange,
                  Colors.deepOrangeAccent,
                  Colors.deepOrange
                ],
                backColor: const Color.fromARGB(255, 244, 207, 158),
                animationDuration: 2,
                size: 36,
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
