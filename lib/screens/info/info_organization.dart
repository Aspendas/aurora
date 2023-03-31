import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class Organization extends StatelessWidget {
  const Organization(
      {Key? key, @required this.title, @required this.body, @required this.url})
      : super(key: key);

  final title;
  final body;
  final url;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: activitycolor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      body,
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Click here',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(url);
                              },
                          ),
                          const TextSpan(
                            text:
                                ' to get more information about organization.',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
