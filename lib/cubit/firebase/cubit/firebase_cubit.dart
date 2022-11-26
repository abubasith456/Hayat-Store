import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shop_app/api/api_provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/services/firebase_messaging/firebase_messaging.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/services/shared_preferences/shared_pref.dart';
import 'package:shop_app/util/shared_pref.dart';

part 'firebase_state.dart';

class FirebaseCubit extends Cubit<FirebaseState> {
  FirebaseCubit() : super(FirebaseInitial());
  var _provider = ApiProvider();
  setToken(String id) async {
    //push token
    String token = await FirebaseMessagingService.getToken();
    sl<SharedPrefService>().setData(pushToken, token);
    emit(PushTokenStoringState());

    print("ID: $id, token: $token ");

    var response = await _provider.setPushToken(id, token);

    if (response.error != null) {
      emit(PushTokenStoredState());
    } else {
      emit(PushTokenStoredState());
    }

    //refresh token listener
    FirebaseMessaging.instance.onTokenRefresh.listen((String token) {
      if (sl<SharedPrefService>().getData(pushToken) != token) {
        //store refresh token
        sl<SharedPrefService>().setData(pushToken, token);
      }
      emit(PushTokenStoringState());
      // sync token to server
    });
  }
}
