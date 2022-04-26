import 'package:food_delivery_laravel/constants.dart';
import 'package:food_delivery_laravel/controllers/popular_product_controller.dart';
import 'package:food_delivery_laravel/controllers/auth_controller.dart';
import 'package:food_delivery_laravel/controllers/user_controller.dart';
import 'package:food_delivery_laravel/data/api/api_client.dart';
import 'package:food_delivery_laravel/data/repository/popular_product_repo.dart';
import 'package:food_delivery_laravel/data/repository/auth_repo.dart';
import 'package:food_delivery_laravel/data/repository/user_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  // API Client Initialization
  Get.lazyPut(() => ApiClient(
      appBaseUrl: Constants.appBaseUrl, sharedPreferences: Get.find()));

  // Repo Initialization
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  // Controller Initialization
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));

  Get.lazyPut(() => UserController(userRepo: Get.find()));
}
