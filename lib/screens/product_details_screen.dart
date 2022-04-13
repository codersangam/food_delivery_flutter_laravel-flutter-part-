import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/constants.dart';
import 'package:food_delivery_laravel/widgets/app_icon.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/big_text.dart';
import '../widgets/icon_text.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://demo3.codersangam.com/wp-content/uploads/2022/04/057d06e00f4c9d437ef64baee9f7bca6.webp'),
                ),
              ),
            ),
          ),
          Positioned(
              top: 60,
              left: 15,
              right: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: AppIcon(
                        iconColor: primaryColor,
                        icon: Icons.arrow_back_ios_new),
                  ),
                  AppIcon(iconColor: primaryColor, icon: Icons.shopping_basket),
                ],
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 330,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BigText(text: 'Special Chinese Pizza'),
                    10.heightBox,
                    Row(
                      children: [
                        VxRating(
                          onRatingUpdate: (value) {},
                          count: 5,
                        ),
                        5.widthBox,
                        '4.5'.text.color(Vx.gray400).make(),
                        10.widthBox,
                        '1287'.text.color(Vx.gray400).make(),
                        5.widthBox,
                        'Comments'.text.color(Vx.gray400).make()
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const IconText(
                            icon: Icons.circle,
                            iconColor: Colors.yellow,
                            text: 'Normal'),
                        IconText(
                            icon: Icons.location_pin,
                            iconColor: primaryColor,
                            text: '1.7 KM'),
                        const IconText(
                            icon: Icons.location_pin,
                            iconColor: Colors.orange,
                            text: '37 Mins')
                      ],
                    ),
                    30.heightBox,
                    'pizza, dish of Italian origin consisting of a flattened disk of bread dough topped with some combination of olive oil, oregano, tomato, olives, mozzarella or other cheese, and many other ingredients, baked quickly—usually, in a commercial setting, using a wood-fired oven heated to a very high temperature—and served hot.'
                        .text
                        .make()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 120,
        padding: const EdgeInsets.only(left: 15, right: 15),
        decoration: const BoxDecoration(
          color: Vx.gray200,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const VxStepper(
              min: 1,
              step: 1,
            ),
            ElevatedButton(
                onPressed: () {},
                child: 'Add to Cart'.text.make(),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                )),
          ],
        ),
      ),
    );
  }
}
