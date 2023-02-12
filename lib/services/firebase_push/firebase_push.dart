import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/api/api_provider.dart';

import '../../constants.dart';
import '../locator.dart';
import '../shared_preferences/shared_pref.dart';

var _provider = ApiProvider();
sePushtoken(BuildContext context) {
  var id = sl<SharedPrefService>().getData(userIdKey);
  var token = sl<SharedPrefService>().getData(pushToken);
  _requestToken(id.toString(), token.toString());

  //refresh token listener
  FirebaseMessaging.instance.onTokenRefresh.listen((String token) {
    print("Push token refresed ==> $token");
    if (sl<SharedPrefService>().getData(pushToken) != token) {
      //store refresh token
      sl<SharedPrefService>().setData(pushToken, token);
      _requestToken(id.toString(), token);
    }
    // sync token to server
  });
}

_requestToken(String id, String token) {
  _provider.setPushToken(id.toString(), token.toString()).then((value) => {
        if (value.status == 200)
          {print("=====> Token Pushed")}
        else
          {print("=====> Token Not pushed")}
      });
}
