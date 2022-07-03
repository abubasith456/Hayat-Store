import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shop_app/util/connection_util.dart';

class ConnectivityProvider with ChangeNotifier {
  late bool _isOnline;
  bool get isOnline => _isOnline;

  ConnectivityProvider() {
    Connectivity _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectionState.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    });
  }

  // startMonitoring() async {
  //   await initConnectivity();
  //   _connectivity.onConnectivityChanged.listen((event) async {
  //     if (event == ConnectivityResult.none) {
  //       _isOnline = false;
  //       notifyListeners();
  //     } else {
  //       await _updateConnectionStatus().then((bool isConnected) {
  //         _isOnline = isConnected;
  //       });
  //     }
  //   });
  // }

  // Future<void> initConnectivity() async {
  //   try {
  //     var status = await _connectivity.checkConnectivity();

  //     if (status == ConnectivityResult.none) {
  //       _isOnline = false;
  //       notifyListeners();
  //     } else {
  //       _isOnline = true;
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<bool> _updateConnectionStatus() async {
  //   late bool isConnected;
  //   try {
  //     final List<InternetAddress> result =
  //         await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       isConnected = true;
  //     }
  //   } catch (e) {
  //     isConnected = false;
  //     print(e.toString());
  //   }

  //   return isConnected;
  // }
}
