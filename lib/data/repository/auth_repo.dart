import 'package:food_delivery_laravel/constants.dart';
import 'package:food_delivery_laravel/data/api/api_client.dart';
import 'package:food_delivery_laravel/models/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  AuthRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> registration(UserModel userModel) async {
    return await apiClient.postData(
        Constants.registerUsersUrl, userModel.toJson());
  }

  saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(Constants.token, token);
  }
}
