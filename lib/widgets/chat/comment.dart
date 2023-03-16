import 'package:aurora/services/comments.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment({
    Key? key,
    @required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: const Color.fromRGBO(247, 218, 200, 0.7),
          ),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: FutureBuilder(
                      future: CommentsService()
                          .getProfilePictureURL("SA0ERu24VeRjIb23I888oHM9lqW2"),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                            ),
                            child: Image.network(
                              snapshot.data!.toString(),
                              fit: BoxFit.fitHeight,
                              height: 110,
                              width: 90,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "Day 33",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "45. günümdeyim. İyiye gittiğimi hissediyorum. Ailem ve arkadaşlarımdan daha fazla destek görüyorum...",
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }
}
