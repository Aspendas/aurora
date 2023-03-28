import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Motivation extends StatelessWidget {
  const Motivation({
    Key? key,
    @required this.image,
    @required this.body,
    @required this.height,
    @required this.quote,
    this.name,
    this.main,
  }) : super(key: key);

  final image;
  final body;
  final height;
  final quote;
  final name;
  final main;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: quote == false
            ? EdgeInsets.fromLTRB(20, 0, 70, 0)
            : EdgeInsets.fromLTRB(70, 0, 20, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffCFE3E3),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          child: main == null && quote == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: height, maxWidth: 60),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                          child: image,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                            child: Text(
                              body,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          quote == true
                              ? Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        '- $name',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                            child: Text(
                              body,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          quote == true
                              ? Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        '- $name',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: height, maxWidth: 60),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: image,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
