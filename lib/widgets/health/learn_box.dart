import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({Key? key, this.data}) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    final body = data['body'];
    final title = data['title'];
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xffDAF0F0),
        centerTitle: false,
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$title',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    '$body',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
