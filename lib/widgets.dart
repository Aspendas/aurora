import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField(
      {required this.hinttext,
      required this.iconl,
      required this.passw,
      required this.paddings});

  final String hinttext;
  final Icon iconl;
  final bool passw;
  final paddings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddings,
      child: TextField(
        obscureText: passw,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15, 17, 15, 17),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: iconl,
          hintText: hinttext,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.title,
      required this.colour,
      required this.onPress,
      required this.paddings});

  final Color colour;
  final String title;
  final paddings;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddings,
      child: Material(
        elevation: 4,
        color: colour,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.black, width: 1.5),
        ),
        child: MaterialButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          onPressed: onPress,
          height: 50.0,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
