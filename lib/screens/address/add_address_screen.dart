import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/colors.dart';
import 'package:food_delivery_laravel/controllers/auth_controller.dart';
import 'package:food_delivery_laravel/controllers/location_controller.dart';
import 'package:food_delivery_laravel/controllers/user_controller.dart';
import 'package:food_delivery_laravel/models/address_model.dart';
import 'package:food_delivery_laravel/screens/address/pick_location_screen.dart';
import 'package:food_delivery_laravel/screens/main_screen.dart';
import 'package:food_delivery_laravel/widgets/profile_icon.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocity_x/velocity_x.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLoggedIn;

  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(27.7090319, 85.2911132), zoom: 17);
  late LatLng _initialPosition = const LatLng(27.7090319, 85.2911132);

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_isLoggedIn && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      //* bug fix
      if (Get.find<LocationController>().getUserAddressFromStorage() == "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));

      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: 'Add Address'.text.makeCentered(),
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.userModel != null &&
              _contactPersonName.text.isEmpty) {
            _contactPersonName.text = '${userController.userModel!.name}';
            _contactPersonNumber.text = '${userController.userModel!.phone}';
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text =
                  '${locationController.placemark.name ?? ''}'
                  '${locationController.placemark.locality ?? ''}'
                  '${locationController.placemark.postalCode ?? ''}'
                  '${locationController.placemark.country ?? ''}';
              // ignore: avoid_print
              print('Address in my view is ' + _addressController.text);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 2, color: primaryColor)),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _initialPosition, zoom: 17),
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            mapToolbarEnabled: false,
                            indoorViewEnabled: true,
                            myLocationEnabled: true,
                            onCameraIdle: () {
                              locationController.updatePosition(
                                  _cameraPosition, true);
                            },
                            onCameraMove: ((position) =>
                                _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                            },
                            onTap: (latlng) {
                              Get.to(
                                () => PickLocationScreen(
                                  fromRegister: false,
                                  fromAddress: true,
                                  googleMapController:
                                      locationController.googleMapController,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    20.heightBox,
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: locationController.addressTypeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              locationController.setAddressTypeIndex(index);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).cardColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Vx.gray200,
                                      spreadRadius: 1.0,
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      index == 0
                                          ? LineIcons.home
                                          : index == 1
                                              ? LineIcons.mapPin
                                              : LineIcons.landmark,
                                      color:
                                          locationController.addressTypeIndex ==
                                                  index
                                              ? primaryColor
                                              : Vx.gray500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    20.heightBox,
                    'Delivery Address'
                        .text
                        .xl
                        .bold
                        .make()
                        .pOnly(left: 15, right: 15),
                    5.heightBox,
                    ProfileIcon(
                        icon: Icons.location_on,
                        data: _addressController.text,
                        backgroundColor: primaryColor),
                    20.heightBox,
                    'Name'.text.bold.xl.make().pOnly(left: 15, right: 15),
                    5.heightBox,
                    ProfileIcon(
                        icon: Icons.person,
                        data: _contactPersonName.text,
                        backgroundColor: primaryColor),
                    20.heightBox,
                    'Phone Number'
                        .text
                        .xl
                        .bold
                        .make()
                        .pOnly(left: 15, right: 15),
                    5.heightBox,
                    ProfileIcon(
                      icon: Icons.phone,
                      data: _contactPersonNumber.text,
                      backgroundColor: primaryColor,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar:
          GetBuilder<LocationController>(builder: (locationController) {
        return GestureDetector(
          onTap: () {
            AddressModel _addressModel = AddressModel(
              addressType: locationController
                  .addressTypeList[locationController.addressTypeIndex],
              contactPersonName: _contactPersonName.text,
              contactPersonNumber: _contactPersonNumber.text,
              address: _addressController.text,
              latitude: locationController.position.latitude.toString(),
              longitude: locationController.position.longitude.toString(),
            );
            locationController.addUserAddress(_addressModel).then((response) {
              if (response.isSuccess) {
                Get.to(() => const MainScreen());
                Get.snackbar('Address', 'Saved Successfully');
              } else {
                Get.snackbar('Address', 'Cannot Save Address');
              }
            });
          },
          child: Container(
            height: 120,
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: const BoxDecoration(
              color: Vx.gray100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primaryColor,
                  ),
                  child: 'Save Address'.text.xl.white.makeCentered(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
