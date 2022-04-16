import 'package:food_delivery_laravel/constants.dart';
import 'package:food_delivery_laravel/controllers/popular_product_controller.dart';
import 'package:food_delivery_laravel/data/api/api_client.dart';
import 'package:food_delivery_laravel/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import '../controllers/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init() async {
  // API Client Initialization
  Get.lazyPut(() => ApiClient(appBaseUrl: Constants.appBaseUrl));

  // Repo Initialization
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));

  // Controller Initialization
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
}
