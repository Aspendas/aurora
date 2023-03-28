import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class Activity extends StatelessWidget {
  const Activity({Key? key, this.data, this.shadow}) : super(key: key);

  final data;
  final shadow;
  @override
  Widget build(BuildContext context) {
    _launchActivity() async {
      var activityUrl = data['activityURL'].toString();
      final Uri activityUri = Uri.parse(activityUrl);

      try {
        await launchUrl(activityUri);
      } catch (e) {
        print(e);
      }
    }

    Map<String, Widget> icon = {
      "food": const SizedBox(
        child: Icon(Icons.fastfood),
      ),
      "visit": const SizedBox(
        child: Icon(Icons.location_on_outlined),
      ),
      "fun": const SizedBox(
        child: Icon(Icons.travel_explore),
      ),
    };

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      height: 150,
      decoration: BoxDecoration(
        boxShadow: shadow,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: activitycolor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 8),
                  child: Text(
                    data["description"].toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      icon[data["category"]]!,
                      GestureDetector(
                        onTap: () {
                          _launchActivity();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            SizedBox(
                              width: 8,
                            ),
                            Text("Go to Activity"),
                            Icon(
                              Icons.play_arrow,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150,
            constraints: const BoxConstraints(
              maxWidth: 120,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.network(
                data['imageURL'].toString(),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
