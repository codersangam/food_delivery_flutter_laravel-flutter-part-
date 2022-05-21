import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/controllers/auth_controller.dart';
import 'package:food_delivery_laravel/controllers/cart_controller.dart';
import 'package:food_delivery_laravel/controllers/location_controller.dart';
import 'package:food_delivery_laravel/controllers/popular_product_controller.dart';
import 'package:food_delivery_laravel/screens/address/add_address_screen.dart';
import 'package:food_delivery_laravel/screens/auth/login_screen.dart';
import 'package:food_delivery_laravel/screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocity_x/velocity_x.dart';

import '../colors.dart';
import '../constants.dart';
import '../widgets/app_icon.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 15,
            right: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<CartController>(builder: (cartController) {
                  return AppIcon(
                          iconColor: primaryColor, icon: LineIcons.shoppingCart)
                      .badge(
                    count: cartController.totalItems,
                  );
                }),
                InkWell(
                  onTap: () {
                    Get.to(() => const MainScreen());
                  },
                  child: AppIcon(iconColor: primaryColor, icon: LineIcons.home),
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getCartItems.isNotEmpty
                ? Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 100,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                            builder: (cartController) {
                          return GetBuilder<PopularProductController>(
                              builder: (popularProductController) {
                            return ListView.builder(
                              itemCount: cartController.getCartItems.length,
                              itemBuilder: (context, index) {
                                var data = cartController.getCartItems[index];
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        margin: const EdgeInsets.only(
                                            bottom: 10,
                                            top: 15,
                                            left: 15,
                                            right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: primaryColor,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              Constants.appBaseUrl +
                                                  "/uploads/" +
                                                  data.img!,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          height: 100,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  data.name!.text.xl.bold
                                                      .overflow(
                                                          TextOverflow.ellipsis)
                                                      .maxLines(1)
                                                      .make()
                                                      .expand(),
                                                  LineIcon(LineIcons.trash),
                                                ],
                                              ),
                                              'Spicy'.text.gray400.make(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  'Rs. ${data.price!}'
                                                      .text
                                                      .red500
                                                      .xl
                                                      .make(),
                                                  Container(
                                                    height: 40,
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.grey[200],
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              cartController
                                                                  .addItem(
                                                                      data.productModel!,
                                                                      -1);
                                                            },
                                                            icon: const Icon(
                                                                LineIcons
                                                                    .minus)),
                                                        data.quantity!.text.xl
                                                            .make(),
                                                        IconButton(
                                                            onPressed: () {
                                                              cartController
                                                                  .addItem(
                                                                      data.productModel!,
                                                                      1);
                                                            },
                                                            icon: const Icon(
                                                                LineIcons
                                                                    .plus)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          });
                        }),
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/empty_cart.png',
                          height: 300,
                          width: 300,
                        ),
                        'Cart is Empty'.text.make()
                      ],
                    ),
                  );
          }),
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
            GetBuilder<CartController>(builder: (cartController) {
              return Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: 'Rs. ${cartController.totalAmount}'
                    .text
                    .xl2
                    .bold
                    .makeCentered(),
              );
            }),
            InkWell(
              onTap: () {
                if (Get.find<AuthController>().userLoggedIn()) {
                  if (Get.find<LocationController>().addressList.isEmpty) {
                    Get.to(() => const AddAddressScreen());
                  } else {
                    Get.to(() => const MainScreen());
                  }
                } else {
                  Get.to(() => const LoginScreen());
                }
              },
              child: Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primaryColor,
                ),
                child: 'Checkout'.text.xl.white.makeCentered(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
