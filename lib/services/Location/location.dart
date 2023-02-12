import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/services/permission/permission.dart';
import 'package:shop_app/services/shared_preferences/shared_pref.dart';

abstract class LocationService {
  getAdressDetailsFromGeo(Position position);
  determinePosition();
  getAddressDetailsGeo();
}

class LocationServiceImpl implements LocationService {
  @override
  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  //Get address from the Geao locaton and store to shared pref
  @override
  getAdressDetailsFromGeo(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude,
            localeIdentifier: "en_US")
        .then((value) {
      Placemark place = value[0];
      sl<SharedPrefService>().setData(areaNameKey, place.subLocality!);
      sl<SharedPrefService>().setData(pinCodeKey, place.postalCode!);
      print(
          "Place GetGeoAddressEvent ===> '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';");
      return;
    });
  }

  //Call the gea address anywhere using this
  @override
  getAddressDetailsGeo() async {
    try {
      await sl<PermissionService>().getLocationPermission().then((value) async {
        if (value) {
          await determinePosition().then((position) async {
            getAdressDetailsFromGeo(position);
          });
        } else {
          return;
        }
      });
    } catch (e) {
      print(e);
      return;
    }
  }
}

class LocationUtils {
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
        zoom: 20.151926040649414);
    return _kShop;
  }
}
