import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  bool get permissionPopupOpened;

  Future<bool> getPhotosPermission();

  Future<bool> getCameraPermission();

  Future<bool> getLocationPermission();

  Future<bool?> handlePermission({
    required Permission permission,
    required bool shouldRequestPermission,
    Function? ifDenied,
    Function? ifAllowed,
    Function? onDeny,
    Function? onAllow,
  });

  Future<bool> isCameraPermissionGranted();

  Future<bool> isPhotosPermissionGranted();

  Future<bool> isLocationPermissionGranted();

  Future<bool> isLocationPermissionDeniedPermanently();

  void bgBiometricHandled();

  Future<bool> getStoragePermission();
}

class PermissionServiceImpl implements PermissionService {
  bool _requestTriggered = false;

  @override
  bool get permissionPopupOpened => _requestTriggered;

  @override
  Future<bool> getPhotosPermission() async {
    final status = await _requestPermission(
      Platform.isAndroid ? Permission.storage : Permission.photos,
    );

    return status.isGranted || status.isLimited;
  }

  @override
  Future<bool> getCameraPermission() async {
    final status = await _requestPermission(Permission.camera);

    return status.isGranted;
  }

  @override
  Future<bool> getStoragePermission() async {
    final status = await _requestPermission(Permission.storage);

    return status.isGranted;
  }

  @override
  Future<bool> getLocationPermission() async {
    final status = await _requestPermission(
      Platform.isAndroid ? Permission.location : Permission.location,
    );

    return status.isGranted || status.isLimited;
  }

  @override
  Future<bool?> handlePermission({
    required Permission permission,
    required bool shouldRequestPermission,
    Function? ifDenied,
    Function? ifAllowed,
    Function? onDeny,
    Function? onAllow,
  }) async {
    if (await permission.isGranted) {
      return ifAllowed?.call();
    } else if (shouldRequestPermission) {
      _requestTriggered = true;
      await permission.request();
      if (await permission.isGranted) {
        return onAllow?.call();
      } else {
        return onDeny?.call();
      }
    } else {
      return ifDenied?.call();
    }
  }

  @override
  Future<bool> isCameraPermissionGranted() {
    return Permission.camera.isGranted;
  }

  @override
  Future<bool> isPhotosPermissionGranted() async {
    final Permission storagePermission =
        Platform.isAndroid ? Permission.storage : Permission.photos;
    return await storagePermission.isGranted ||
        await storagePermission.isLimited;
  }

  @override
  Future<bool> isLocationPermissionGranted() async {
    return Permission.location.isGranted;
  }

  @override
  Future<bool> isLocationPermissionDeniedPermanently() async {
    var status = Permission.location.status;
    if (status == PermissionStatus.permanentlyDenied) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void bgBiometricHandled() {
    _requestTriggered = false;
  }

  Future<bool> getATTPermission() async {
    if (await Permission.appTrackingTransparency.isGranted) return true;
    return false;
  }

  Future<void> requestATTPermission() async {
    await Permission.appTrackingTransparency.request();
  }

  Future<PermissionStatus> _requestPermission(Permission permission) async {
    late final PermissionStatus status;

    if (await permission.status != PermissionStatus.granted) {
      _requestTriggered = true;

      status = await permission.request();
    } else {
      status = await permission.status;
    }

    debugPrint("$permission status: $status");

    return status;
  }
}
