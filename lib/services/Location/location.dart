import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  LatLng pinPosition = LatLng(37.3797536, -122.1017334);

  static CameraPosition cameraPosition() {
    //Camera position
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(10.882605, 79.679260),
      zoom: 9.4746,
    );
    return _kGooglePlex;
  }

  static CameraPosition shopPosition() {
//position moving camera with animation
    final CameraPosition _kShop = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(10.882605, 79.679260),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    return _kShop;
  }
}
