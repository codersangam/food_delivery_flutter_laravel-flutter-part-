import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/screens/main_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInExpo);

    Timer(
      const Duration(seconds: 3),
      () => Get.off(
        () => const MainScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: Image.asset(
                'assets/images/logopart1.png',
                width: 250,
              ),
            ),
            Image.asset(
              'assets/images/logopart2.png',
              width: 250,
            ),
          ],
        ),
      ),
    );
  }
}
