import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const DARK = Color.fromRGBO(82, 82, 82, 1);
  static const OPERATION = Color.fromRGBO(255, 159, 10, 1);
  static const DEFAULT = Color.fromRGBO(112, 112, 112, 1);

  final String text;
  final bool big;
  final Color color;
  final void Function(String) onPressed;

  const Button({
    super.key,
    required this.text,
    this.big = false,
    this.color = DEFAULT,
    required this.onPressed,
  });

  const Button.big({
    super.key,
    required this.text,
    this.big = true,
    this.color = DEFAULT,
    required this.onPressed,
  });

  const Button.dark({
    super.key,
    required this.text,
    this.big = false,
    this.color = DARK,
    required this.onPressed,
  });

  const Button.operation({
    super.key,
    required this.text,
    this.big = false,
    this.color = OPERATION,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // sem arredondamento
          ),
        ),

        onPressed: () => onPressed(text),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
