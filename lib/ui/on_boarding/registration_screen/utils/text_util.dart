import 'package:flutter/material.dart';

class BuildText extends StatelessWidget {
  const BuildText({
    super.key,
    required this.context,
    required this.text,
    this.color,
    this.fontWeight, this.fontSize, this.letterSpacing,
  });

  final BuildContext context;
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
