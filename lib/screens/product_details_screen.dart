import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/constants.dart';
import 'package:food_delivery_laravel/models/product_model.dart';
import '/colors.dart';
import 'package:food_delivery_laravel/widgets/app_icon.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/big_text.dart';
import '../widgets/icon_text.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.data}) : super(key: key);

  final ProductModel data;

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
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      Constants.appBaseUrl + "/uploads/" + data.img.toString()),
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
                    BigText(text: data.name.toString()),
                    10.heightBox,
                    Row(
                      children: [
                        VxRating(
                          onRatingUpdate: (value) {},
                          count: data.stars!.toInt(),
                        ),
                        5.widthBox,
                        '${data.stars}'.text.color(Vx.gray400).make(),
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
                    SingleChildScrollView(
                      child: data.description!.text
                          .textStyle(const TextStyle(height: 1.5))
                          .lg
                          .make(),
                    ).expand()
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
          color: Vx.gray100,
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
