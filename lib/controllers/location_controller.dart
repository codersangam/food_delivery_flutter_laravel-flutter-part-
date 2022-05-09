import 'dart:convert';

import 'package:food_delivery_laravel/data/repository/location_repo.dart';
import 'package:food_delivery_laravel/models/address_model.dart';
import 'package:food_delivery_laravel/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  LocationController({required this.locationRepo});

  final LocationRepo locationRepo;

  final bool _changeAddress = true;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late Position _position;
  Position get position => _position;

  late Position _pickPosition;
  Position get pickPosition => _pickPosition;

  Placemark _placeMark = Placemark();
  Placemark get placemark => _placeMark;

  Placemark _pickPlaceMark = Placemark();
  Placemark get pickPlaceMark => _pickPlaceMark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;

  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;

  final List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;

  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;

  late GoogleMapController _googleMapController;
  GoogleMapController get googleMapController => _googleMapController;

  void setMapController(GoogleMapController googleMapController) {
    _googleMapController = googleMapController;
  }

  bool _updateAddressData = true;
  void updatePosition(CameraPosition cameraPosition, bool fromAddress) async {
    if (_updateAddressData) {
      _isLoading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            longitude: cameraPosition.target.longitude,
            latitude: cameraPosition.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        } else {
          _pickPosition = Position(
            longitude: cameraPosition.target.longitude,
            latitude: cameraPosition.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        }
        if (_changeAddress) {
          String _address = await getAddressFromGeoCode(
            LatLng(
              cameraPosition.target.latitude,
              cameraPosition.target.longitude,
            ),
          );
          fromAddress
              ? _placeMark = Placemark(name: _address)
              : _pickPlaceMark = Placemark(name: _address);
        }
      } catch (e) {
        // ignore: avoid_print
        print(e.toString());
      }
      _isLoading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }

  Future<String> getAddressFromGeoCode(LatLng latlng) async {
    String _address = "Unknown Address Found";
    Response response = await locationRepo.getAddressFromGeoCode(latlng);
    if (response.body['status'] == "OK") {
      _address = response.body['results'][0]['formatted_address'].toString();
    } else {
      printError();
    }
    update();
    return _address;
  }

  AddressModel getUserAddress() {
    late AddressModel _addressModel;

    // *converting to Map using jsonDecode
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addUserAddress(AddressModel addressModel) async {
    _isLoading = true;
    update();
    Response response = await locationRepo.addUserAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body['message'];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      // ignore: avoid_print
      print('Unable to save address');
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _placeMark = _pickPlaceMark;
    _updateAddressData = false;
    update();
  }
}
