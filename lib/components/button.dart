import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const DARK = Color(0xFF525252);
  static const OPERATION = Color(0xFFFF9F0A);
  static const DEFAULT = Color(0xFF707070);

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
      child: Padding(
        padding: const EdgeInsets.all(4.0), // espaço entre os botões
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // bordas arredondadas
            ),
            padding: EdgeInsets.symmetric(vertical: 22), // botão mais alto
            elevation: 4, // sombra suave
            shadowColor: Colors.black45,
          ),
          onPressed: () => onPressed(text),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(0, 1),
                  blurRadius: 1,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
