import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  const BigText(
      {Key? key,
      this.color = const Color(0xff89D9D0),
      this.size = 20,
      required this.text,
      this.textOverflow})
      : super(key: key);

  final Color? color;
  final double size;
  final String text;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
