import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocity_x/velocity_x.dart';
import '../colors.dart';
import '../constants.dart';
import '../controllers/cart_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../models/product_model.dart';
import '../widgets/app_icon.dart';
import '../widgets/big_text.dart';
import '../widgets/icon_text.dart';
import 'cart_screen.dart';
import 'main_screen.dart';

class RecommendedProductDetailsScreen extends StatelessWidget {
  const RecommendedProductDetailsScreen({Key? key, required this.data})
      : super(key: key);

  final ProductModel data;

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>()
        .initProduct(data, Get.find<CartController>());
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
                      Get.to(() => const MainScreen());
                    },
                    child: AppIcon(
                        iconColor: primaryColor,
                        icon: Icons.arrow_back_ios_new),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const CartScreen());
                    },
                    child: GetBuilder<PopularProductController>(
                        builder: (popularProductController) {
                      return AppIcon(
                              iconColor: primaryColor,
                              icon: LineIcons.shoppingCart)
                          .badge(count: popularProductController.totalItems);
                    }),
                  ),
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
      bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProductController) {
        return Container(
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
              Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          popularProductController.setQuantity(false);
                        },
                        icon: const Icon(LineIcons.minus)),
                    popularProductController.cartItems.text.xl.make(),
                    IconButton(
                        onPressed: () {
                          popularProductController.setQuantity(true);
                        },
                        icon: const Icon(LineIcons.plus)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  popularProductController.addItem(data);
                },
                child: Container(
                  height: 60,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      'Rs. ${data.price!}'.text.xl.white.make(),
                      'Add to Cart'.text.xl.white.make(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
