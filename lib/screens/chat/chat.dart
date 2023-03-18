import 'package:aurora/screens/chat/comments.dart';

import 'package:flutter/material.dart';

import '../../widgets/main_app_bar.dart';

import 'stories.dart';

class ChatScreen extends StatefulWidget {
  final AsyncSnapshot userData;
  const ChatScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool chatScreenToggle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainAppBar(userData: widget.userData),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                child: chatScreenToggle
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  chatScreenToggle = !chatScreenToggle;
                                });
                              },
                              child: const Text(
                                "Comments",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            const Text(
                              " - ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const Text(
                              "Stories",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Opacity(
                              opacity: 0,
                              child: FloatingActionButton(
                                mini: true,
                                backgroundColor:
                                    const Color.fromRGBO(222, 222, 222, 1),
                                foregroundColor: Colors.black,
                                onPressed: () {},
                                child: const Icon(Icons.add),
                              ),
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Comments",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const Text(
                                  " - ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      chatScreenToggle = !chatScreenToggle;
                                    });
                                  },
                                  child: const Text(
                                    "Stories",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            FloatingActionButton(
                              mini: true,
                              backgroundColor:
                                  const Color.fromRGBO(222, 222, 222, 1),
                              foregroundColor: Colors.black,
                              onPressed: () {},
                              child: const Icon(Icons.add),
                            )
                          ],
                        ),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              ChatWrapper(toggle: chatScreenToggle),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatWrapper extends StatelessWidget {
  const ChatWrapper({Key? key, required this.toggle}) : super(key: key);
  final bool toggle;
  @override
  Widget build(BuildContext context) {
    if (toggle == true) {
      return const Stories();
    } else {
      return const Comments();
    }
  }
}
