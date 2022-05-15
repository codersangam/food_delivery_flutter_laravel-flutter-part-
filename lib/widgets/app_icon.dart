import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:velocity_x/velocity_x.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({Key? key, required this.iconColor, required this.icon})
      : super(key: key);

  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: LineIcon(
        icon,
        color: iconColor,
      ),
    )
        .make()
        .wh(40, 40)
        .cornerRadius(35)
        .glassMorphic(opacity: 1, blur: 5, shadowStrength: 4);
  }
}
