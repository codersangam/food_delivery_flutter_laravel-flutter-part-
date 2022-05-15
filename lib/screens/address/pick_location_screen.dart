import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/colors.dart';
import 'package:food_delivery_laravel/controllers/location_controller.dart';
import 'package:food_delivery_laravel/screens/address/add_address_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../widgets/profile_icon.dart';
import 'package:velocity_x/velocity_x.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen(
      {Key? key,
      required this.fromRegister,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  final bool fromRegister;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  late LatLng _initialPosition;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = const LatLng(27.7090319, 85.2911132);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(
                Get.find<LocationController>().getAddress['longitude']));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 17,
                  ),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    Get.find<LocationController>()
                        .updatePosition(_cameraPosition, false);
                  },
                ),
                Center(
                  child: !locationController.isLoading
                      ? Image.asset(
                          'assets/images/pick_marker.png',
                          height: 50,
                          width: 50,
                        )
                      : CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
                Positioned(
                  top: 35,
                  left: 20,
                  right: 20,
                  child: ProfileIcon(
                      icon: Icons.location_on,
                      data: locationController.pickPlaceMark.name.toString(),
                      backgroundColor: Colors.yellow),
                ),
                Positioned(
                  bottom: 80,
                  left: 20,
                  right: 20,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor)),
                      onPressed: locationController.isLoading
                          ? null
                          : () {
                              if (locationController.pickPosition.latitude !=
                                      0 &&
                                  locationController.pickPlaceMark.name !=
                                      null) {
                                if (widget.fromAddress) {
                                  // ignore: unnecessary_null_comparison
                                  if (widget.googleMapController != null) {
                                    widget.googleMapController!.moveCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: LatLng(
                                            locationController
                                                .pickPosition.latitude,
                                            locationController
                                                .pickPosition.longitude,
                                          ),
                                        ),
                                      ),
                                    );
                                    locationController.setAddAddressData();
                                  }
                                  // Get.back();
                                  // Get.offAll(() => const AddAddressScreen());
                                  Get.to(const AddAddressScreen());
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         const AddAddressScreen()));
                                }
                              }
                            },
                      child: 'Pick Address'.text.lg.make(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
