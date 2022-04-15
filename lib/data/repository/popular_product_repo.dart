import 'package:food_delivery_laravel/data/api/api_client.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  PopularProductRepo({required this.apiClient});
  final ApiClient apiClient;

  Future<Response> getPopularProductList() async {
    return await apiClient.getData("/api/v1/products/popular");
  }
}
