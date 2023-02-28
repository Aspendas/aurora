import 'package:flutter/material.dart';

class TermAndConditions extends StatelessWidget {
  const TermAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text1 =
        "Welcome to our app. These terms and conditions govern your use of the app. By using the app, you agree to be bound by these terms and conditions. If you do not agree to these terms and conditions, please do not use the app.";
    String text2 =
        'The app is provided on an "as is" and "as available" basis. We make no representations or warranties of any kind, express or implied, as to the operation of the app or the information, content, materials, or products included on the app. You expressly agree that your use of the app is at your sole risk.';
    String text3 =
        'We reserve the right to modify, update, or remove the app or any part of it without notice.';
    String text4 =
        'We are not liable for any damages, including without limitation, direct, indirect, incidental, special, or consequential damages arising from the use of the app.';
    String text5 =
        'The app may contain links to third-party websites or resources. We do not endorse and are not responsible for the content of these websites or resources.';
    String text6 =
        'You are solely responsible for the use of the app and any consequences thereof.';
    String text7 =
        'We reserve the right to terminate your access to the app at any time for any reason without notice.';
    String text8 =
        'You agree to use the app only for lawful purposes and in accordance with these terms and conditions.';
    String text9 =
        'We reserve the right to update these terms and conditions at any time without notice. Your continued use of the app after such changes will constitute your acceptance of the new terms and conditions.';
    String text10 =
        'These terms and conditions are governed by the laws of [insert country/state here]. Any disputes arising from the use of the app shall be resolved exclusively in the courts of [insert country/state here].';
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text(text1),
          Text(text2),
          Text(text3),
          Text(text4),
          Text(text5),
          Text(text6),
          Text(text7),
          Text(text8),
          Text(text9),
          Text(text10),
        ],
      ),
    );
  }
}
