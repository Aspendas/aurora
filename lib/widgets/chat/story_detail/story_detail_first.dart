import 'package:flutter/material.dart';

class StoryDetailFirst extends StatelessWidget {
  const StoryDetailFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              topLeft: Radius.circular(16),
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Image.network(
              "https://e00-marca.uecdn.es/assets/multimedia/imagenes/2023/01/12/16735402991293.jpg",
              fit: BoxFit.fitHeight,
              height: 120,
              width: 90,
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Text("    " +
              "In 1987, Downey Jr. gave a stellar performance as a wealthy, troubled youth in the film Less Than Zero, followed by an unexpected triumph as Charlie Chaplin in Richard Attenborough’s biopic Chaplin in 1992 that earned him an Oscar nomination."),
        ),
      ],
    );
  }
}
