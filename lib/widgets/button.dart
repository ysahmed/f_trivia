import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback _onPressed;
  final Color _color;
  final double _height, _width;
  final String _text;
  const Button(
      {super.key,
      required VoidCallback onPressed,
      required Color color,
      required double height,
      required double width,
      required String text})
      : _onPressed = onPressed,
        _color = color,
        _width = width,
        _height = height,
        _text = text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onPressed,
      color: _color,
      height: _height,
      minWidth: _width,
      child: Text(
        _text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
