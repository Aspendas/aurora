import 'package:flutter/material.dart';
import 'package:aurora/screens/chat/comments.dart';
import 'package:aurora/services/comments.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants.dart';
import '../../widgets/main_app_bar.dart';

import 'stories.dart';

class ChatScreen extends StatefulWidget {
  final AsyncSnapshot userData;
  const ChatScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  bool chatScreenToggle = false;
  @override
  Widget build(BuildContext context) {
    var userData = widget.userData;
    var date = userData.data["challengeStartDates"]?.toDate();

    int nthDay = 0;
    if (date != null) {
      nthDay = DateTime.now().difference(date).inDays;
    }
    return Scaffold(
      backgroundColor: Colors.white,
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
                              child: date != null
                                  ? FloatingActionButton(
                                      mini: true,
                                      backgroundColor: yell,
                                      foregroundColor: Colors.black,
                                      onPressed: () {},
                                      child: const Icon(Icons.add),
                                    )
                                  : const SizedBox(),
                            ),
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
                            date != null
                                ? FloatingActionButton(
                                    mini: true,
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Write Your Comment",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                TextField(
                                                  controller:
                                                      _commentController,
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 8),
                                                  ),
                                                  maxLength: 260,
                                                  minLines: 1,
                                                  maxLines: 8,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const SizedBox(),
                                                    Row(
                                                      children: [
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                                const Color(
                                                                    0xff5A6363),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 20,
                                                              vertical: 12,
                                                            ),
                                                            textStyle:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                                const Color(
                                                                    0xffCFE3E3),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 20,
                                                              vertical: 12,
                                                            ),
                                                            textStyle:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            "Send",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            CommentsService()
                                                                .addComment(
                                                              userData.data[
                                                                  'addiction'],
                                                              _commentController
                                                                  .text,
                                                              nthDay, // must change
                                                              DateTime.now(),
                                                              userId,
                                                            );
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(Icons.add),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
              ),
              const SizedBox(
                height: 16,
              ),
              ChatWrapper(
                toggle: chatScreenToggle,
                userData: widget.userData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatWrapper extends StatelessWidget {
  const ChatWrapper({Key? key, required this.toggle, required this.userData})
      : super(key: key);
  final AsyncSnapshot userData;
  final bool toggle;
  @override
  Widget build(BuildContext context) {
    if (toggle == true) {
      return Stories(
        userData: userData,
      );
    } else {
      return Comments(
        userData: userData,
      );
    }
  }
}
