import 'package:flutter/material.dart';
import 'package:async_button_builder/async_button_builder.dart';

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

class PAsyncButton extends StatelessWidget {
  PAsyncButton(
      {required this.title,
      required this.colour,
      required this.onPress,
      required this.paddings});

  final Color colour;
  final Text title;
  final paddings;
  final onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddings,
      child: AsyncButtonBuilder(
        onPressed: onPress,
        loadingWidget: const SizedBox(
          height: 16.0,
          width: 16.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        ),
        successWidget: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.check,
            color: Colors.black,
          ),
        ),
        loadingSwitchInCurve: Curves.bounceInOut,
        loadingTransitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1.0),
              end: const Offset(0, 0),
            ).animate(animation),
            child: child,
          );
        },
        builder: (context, child, callback, state) {
          return GestureDetector(
            onTap: callback,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                child: child,
              ),
            ),
          );
        },
        child: title,
      ),
    );
  }
}
