import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText(
      {Key? key,
      required this.icon,
      required this.iconColor,
      required this.text})
      : super(key: key);

  final IconData icon;
  final Color iconColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.grey[400]),
        ),
      ],
    );
  }
}
