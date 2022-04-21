import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/constants.dart';
import 'package:food_delivery_laravel/controllers/popular_product_controller.dart';
import 'package:food_delivery_laravel/controllers/recommended_product_controller.dart';
import 'package:food_delivery_laravel/models/product_model.dart';
import 'package:food_delivery_laravel/screens/product_details_screen.dart';
import 'package:food_delivery_laravel/widgets/big_text.dart';
import 'package:food_delivery_laravel/widgets/icon_text.dart';
import 'package:food_delivery_laravel/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);

  var _currentPageValue = 0.0;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<void> loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: SafeArea(
          child: SingleChildScrollView(
            child: VxBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeScreenHeader().p(8),
                  GetBuilder<PopularProductController>(
                    builder: (popularProducts) {
                      return popularProducts.isLoading
                          ? VxBox(
                              child: PageView.builder(
                              itemCount:
                                  popularProducts.popularProductList.length,
                              controller: _pageController,
                              itemBuilder: (context, index) {
                                var data =
                                    popularProducts.popularProductList[index];
                                return HomeScreenBody(
                                  data: data,
                                );
                              },
                            )).make().h(320)
                          : Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<PopularProductController>(
                          builder: (popularProducts) {
                        return DotsIndicator(
                          dotsCount: popularProducts.popularProductList.isEmpty
                              ? 1
                              : popularProducts.popularProductList.length,
                          position: _currentPageValue,
                          decorator: DotsDecorator(
                            size: const Size.square(9.0),
                            activeColor: primaryColor,
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  10.heightBox,
                  const Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: BigText(text: 'Recommended Items'),
                  ),
                  20.heightBox,
                  GetBuilder<RecommendedProductController>(
                      builder: (recommendedProduct) {
                    return recommendedProduct.isLoading
                        ? VxBox(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: recommendedProduct
                                  .recommendedProductList.length,
                              itemBuilder: (context, index) {
                                var data = recommendedProduct
                                    .recommendedProductList[index];
                                return RecommendedItemsList(
                                  data: data,
                                );
                              },
                            ),
                          ).make()
                        : Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          );
                  }),
                ],
              ),
            ).make(),
          ),
        ),
        onRefresh: loadResource);
  }
}

class RecommendedItemsList extends StatelessWidget {
  const RecommendedItemsList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ProductModel data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailsScreen(data: data),
            transition: Transition.fadeIn);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    Constants.appBaseUrl + "/uploads/" + data.img.toString(),
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              width: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 5,
                    color: Color(0xffe8e8e8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: data.name.toString(),
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    SmallText(
                      text: data.location.toString(),
                      color: Vx.gray400,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    )
                  ],
                ),
              ),
            ).expand(),
          ],
        ),
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ProductModel data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
            () => ProductDetailsScreen(
                  data: data,
                ),
            transition: Transition.leftToRightWithFade);
      },
      child: Stack(
        children: [
          Container(
            height: 220,
            margin: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  Constants.appBaseUrl + "/uploads/" + data.img.toString(),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 140,
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xffe8e8e8),
                        offset: Offset(0, 5),
                        blurRadius: 5),
                  ]),
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: data.name.toString()),
                    Row(
                      children: [
                        VxRating(
                          onRatingUpdate: (value) {},
                          count: data.stars!,
                        ),
                        5.widthBox,
                        '${data.stars}'.text.color(Vx.gray400).make(),
                        10.widthBox,
                        '1287'.text.color(Vx.gray400).make(),
                        5.widthBox,
                        'Comments'.text.color(Vx.gray400).make()
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BigText(text: 'Nepal'),
            Row(
              children: const [
                SmallText(text: 'Kathmandu'),
                Icon(Icons.arrow_drop_down)
              ],
            )
          ],
        ),
        VxBox(
          child: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ).make().backgroundColor(primaryColor).wh(40, 40).cornerRadius(10)
      ],
    );
  }
}
