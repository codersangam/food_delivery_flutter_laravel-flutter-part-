import 'package:food_delivery_laravel/constants.dart';
import 'package:food_delivery_laravel/data/api/api_client.dart';
import 'package:get/get.dart';

class UserRepo {
  UserRepo({required this.apiClient});
  final ApiClient apiClient;

  Future<Response> getUserInfo() async {
    return await apiClient.getData(Constants.userInfo);
  }
}
