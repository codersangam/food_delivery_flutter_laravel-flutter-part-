import 'package:food_delivery_laravel/data/api/api_client.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class LocationRepo {
  LocationRepo({required this.apiClient, required this.sharedPreferences});
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  Future<Response> getAddressFromGeoCode(LatLng latlng) async {
    return await apiClient.getData('${Constants.geoCodeUrl}'
        '?lat=${latlng.latitude}&lng=${latlng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(Constants.userAddress) ?? "";
  }
}
