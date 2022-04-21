import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/colors.dart';
import 'package:food_delivery_laravel/widgets/big_text.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/profile_icon.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const BigText(
          text: 'Account',
          size: 24,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VxBox(
                  child: LineIcon(
                    LineIcons.user,
                    color: Colors.white,
                    size: 60.0,
                  ),
                )
                    .makeCentered()
                    .circle(backgroundColor: primaryColor, radius: 130),
              ],
            ),
            10.heightBox,
            ProfileIcon(
              icon: Icons.person,
              data: 'Sangam Singh',
              backgroundColor: primaryColor,
            ),
            10.heightBox,
            const ProfileIcon(
              icon: Icons.phone,
              data: '+977 98277 355 77',
              backgroundColor: Colors.yellow,
            ),
            10.heightBox,
            ProfileIcon(
              icon: Icons.email,
              data: 'admin@codersangam.com',
              backgroundColor: primaryColor,
            ),
            10.heightBox,
            const ProfileIcon(
              icon: Icons.location_on,
              data: 'China',
              backgroundColor: Colors.yellow,
            ),
            10.heightBox,
            ProfileIcon(
              icon: Icons.message,
              data: 'None',
              backgroundColor: primaryColor,
            ),
            10.heightBox,
            const ProfileIcon(
              icon: Icons.logout,
              data: 'Logout',
              backgroundColor: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
