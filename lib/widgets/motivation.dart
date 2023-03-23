import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Motivation extends StatelessWidget {
  const Motivation({
    Key? key,
    @required this.image,
    @required this.body,
    @required this.height,
    @required this.quote,
    this.name,
  }) : super(key: key);

  final image;
  final body;
  final height;
  final quote;
  final name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(230, 222, 222, 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: height, maxWidth: 60),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                  child: image,
                ),
              ),
            ),
            const SizedBox(width: 3),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      body,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 6),
                  quote == true
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '- $name',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
