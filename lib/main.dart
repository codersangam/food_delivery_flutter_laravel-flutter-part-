import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/controllers/popular_product_controller.dart';
import 'package:food_delivery_laravel/screens/home_screen.dart';
import 'package:get/get.dart';
import 'controllers/recommended_product_controller.dart';
import 'helpers/dependencies.dart' as dependencies;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
