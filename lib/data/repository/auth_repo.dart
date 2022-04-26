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

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(
        Constants.loginUsersUrl, {'email': email, 'password': password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(Constants.token, token);
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(Constants.token);
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(Constants.token) ?? 'None';
  }

  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      await sharedPreferences.setString(Constants.email, email);
      await sharedPreferences.setString(Constants.password, password);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  bool logout() {
    sharedPreferences.remove(Constants.token);
    sharedPreferences.remove(Constants.email);
    sharedPreferences.remove(Constants.password);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
