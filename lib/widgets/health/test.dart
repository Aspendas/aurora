import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);
  _launchActivity() async {
    // var activityUrl = data['activityURL'].toString();
    var testUrl = "https://www.google.com";
    final Uri testUri = Uri.parse(testUrl);

    try {
      await launchUrl(testUri);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0XFFCFE3E3),
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "American Mental Health Association",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "This is description of the test",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _launchActivity();
            },
            child: const Icon(
              Icons.open_in_new_rounded,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
