import 'package:food_delivery_laravel/constants.dart';
import 'package:food_delivery_laravel/data/api/api_client.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  RecommendedProductRepo({required this.apiClient});
  final ApiClient apiClient;

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(Constants.recommendedProductsUrl);
  }
}
