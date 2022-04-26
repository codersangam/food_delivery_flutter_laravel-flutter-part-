import 'package:food_delivery_laravel/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = sharedPreferences.getString(Constants.token).toString();
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
    };
  }
  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = (await get(uri, headers: headers ?? _mainHeaders));
      return response;
    } catch (e) {
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  Future<Response> postData(String url, dynamic body) async {
    try {
      Response response = await post(url, body, headers: _mainHeaders);
      return response;
    } catch (e) {
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
    };
  }
}
