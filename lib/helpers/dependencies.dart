import 'package:food_delivery_laravel/controllers/popular_product_controller.dart';
import 'package:food_delivery_laravel/data/api/api_client.dart';
import 'package:food_delivery_laravel/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

Future<void> init() async {
  // API Client Initialization
  Get.lazyPut(() => ApiClient(appBaseUrl: "http://mvs.bslmeiyu.com"));

  // Repo Initialization
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  // Controller Initialization
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}
