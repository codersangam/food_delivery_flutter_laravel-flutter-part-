import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon(
      {Key? key,
      required this.icon,
      required this.data,
      required this.backgroundColor})
      : super(key: key);

  final IconData icon;
  final String data;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2))
      ]),
      child: Row(
        children: [
          VxCircle(
            radius: 40,
            backgroundColor: backgroundColor,
            child: LineIcon(
              icon,
              color: Colors.white,
            ),
          ),
          10.widthBox,
          data.text.bold.xl.make(),
        ],
      ),
    );
  }
}
