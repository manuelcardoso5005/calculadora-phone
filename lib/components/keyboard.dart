import 'package:flutter/material.dart';
import 'button.dart';
import 'button_row.dart';

class Keyboard extends StatelessWidget {
  final void Function(String) onButtonPressed;
  static const dark = Color.fromRGBO(82, 82, 82, 1);
  const Keyboard(this.onButtonPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Keyboard.dark,
      child: Column(
        children: [
          ButtonRow([
            Button.big(
              text: "AC",
              color: Button.DARK,
              onPressed: onButtonPressed,
            ),
            Button(text: "%", color: Button.DARK, onPressed: onButtonPressed),
            Button.operation(text: "/", onPressed: onButtonPressed),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(text: "7", onPressed: onButtonPressed),
            Button(text: "8", onPressed: onButtonPressed),
            Button(text: "9", onPressed: onButtonPressed),
            Button.operation(text: "x", onPressed: onButtonPressed),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(text: "4", onPressed: onButtonPressed),
            Button(text: "5", onPressed: onButtonPressed),
            Button(text: "6", onPressed: onButtonPressed),
            Button.operation(text: "-", onPressed: onButtonPressed),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button(text: "1", onPressed: onButtonPressed),
            Button(text: "2", onPressed: onButtonPressed),
            Button(text: "3", onPressed: onButtonPressed),
            Button.operation(text: "+", onPressed: onButtonPressed),
          ]),
          SizedBox(height: 1),
          ButtonRow([
            Button.big(text: "0", onPressed: onButtonPressed),
            Button(text: ".", onPressed: onButtonPressed),
            Button.operation(text: "=", onPressed: onButtonPressed),
          ]),
        ],
      ),
    );
  }
}
