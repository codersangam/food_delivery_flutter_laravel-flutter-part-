import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/colors.dart';
import 'package:food_delivery_laravel/controllers/auth_controller.dart';
import 'package:food_delivery_laravel/controllers/location_controller.dart';
import 'package:food_delivery_laravel/controllers/user_controller.dart';
import 'package:food_delivery_laravel/widgets/app_icon.dart';
import 'package:food_delivery_laravel/widgets/icon_text.dart';
import 'package:food_delivery_laravel/widgets/profile_icon.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  late final LatLng _initialPosition = const LatLng(27.7090319, 85.2911132);

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_isLoggedIn && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      const CameraPosition(target: LatLng(27.7090319, 85.2911132));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: 'Add Address'.text.makeCentered(),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        if (userController.userModel != null &&
            _contactPersonName.text.isEmpty) {
          _contactPersonName.text = '${userController.userModel!.name}';
          _contactPersonNumber.text = '${userController.userModel!.phone}';
          if (Get.find<LocationController>().addressList.isNotEmpty) {
            _addressController.text =
                Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController) {
          _addressController.text = '${locationController.placemark.name ?? ''}'
              '${locationController.placemark.locality ?? ''}'
              '${locationController.placemark.postalCode ?? ''}'
              '${locationController.placemark.country ?? ''}';
          return Column(
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
                      initialCameraPosition:
                          CameraPosition(target: _initialPosition, zoom: 17),
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      mapToolbarEnabled: false,
                      indoorViewEnabled: true,
                      onCameraIdle: () {
                        locationController.updatePosition(
                            _cameraPosition, true);
                      },
                      onCameraMove: ((position) => _cameraPosition = position),
                      onMapCreated: (GoogleMapController controller) {
                        locationController.setMapController(controller);
                      },
                    ),
                  ],
                ),
              ),
              20.heightBox,
              'Delivery Address'
                  .text
                  .xl2
                  .bold
                  .make()
                  .pOnly(left: 15, right: 15),
              10.heightBox,
              ProfileIcon(
                  icon: Icons.location_on,
                  data: _addressController.text,
                  backgroundColor: primaryColor),
              20.heightBox,
              'Name'.text.bold.xl2.make().pOnly(left: 15, right: 15),
              10.heightBox,
              ProfileIcon(
                  icon: Icons.person,
                  data: _contactPersonName.text,
                  backgroundColor: primaryColor),
              20.heightBox,
              'Phone Number'.text.xl2.bold.make().pOnly(left: 15, right: 15),
              10.heightBox,
              ProfileIcon(
                  icon: Icons.phone,
                  data: _contactPersonNumber.text,
                  backgroundColor: primaryColor),
            ],
          );
        });
      }),
    );
  }
}
