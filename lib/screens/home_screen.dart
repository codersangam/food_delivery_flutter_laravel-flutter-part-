import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/widgets/big_text.dart';
import 'package:food_delivery_laravel/widgets/small_text.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VxBox(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      BigText(text: 'Nepal'),
                      SmallText(text: 'Kathmandu'),
                    ],
                  ),
                  VxBox(
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                      .make()
                      .backgroundColor(primaryColor)
                      .wh(40, 40)
                      .cornerRadius(10)
                ],
              ).p(8),
            ],
          ),
        ).make(),
      ),
    );
  }
}
