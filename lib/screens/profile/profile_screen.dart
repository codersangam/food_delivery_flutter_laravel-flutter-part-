import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/colors.dart';
import 'package:food_delivery_laravel/controllers/auth_controller.dart';
import 'package:food_delivery_laravel/controllers/user_controller.dart';
import 'package:food_delivery_laravel/screens/auth/login_screen.dart';
import 'package:food_delivery_laravel/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/profile_icon.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
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
      body: GetBuilder<UserController>(
        builder: (userInfo) {
          return _userLoggedIn
              ? userInfo.isLoading
                  ? SingleChildScrollView(
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
                              ).makeCentered().circle(
                                  backgroundColor: primaryColor, radius: 130),
                            ],
                          ),
                          10.heightBox,
                          ProfileIcon(
                            icon: Icons.person,
                            data: userInfo.userModel!.name.toString(),
                            backgroundColor: primaryColor,
                          ),
                          10.heightBox,
                          ProfileIcon(
                            icon: Icons.phone,
                            data: userInfo.userModel!.phone.toString(),
                            backgroundColor: Colors.yellow,
                          ),
                          10.heightBox,
                          ProfileIcon(
                            icon: Icons.email,
                            data: userInfo.userModel!.email.toString(),
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
                          GestureDetector(
                            onTap: () {
                              if (Get.find<AuthController>().userLoggedIn()) {
                                Get.find<AuthController>().logout();
                                Get.offAll(() => const LoginScreen());
                              }
                            },
                            child: const ProfileIcon(
                              icon: Icons.logout,
                              data: 'Logout',
                              backgroundColor: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
              : GestureDetector(
                  onTap: () {
                    Get.to(() => const LoginScreen());
                  },
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: 'Please LogIn'.text.white.makeCentered(),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
