import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/bloc/order_bloc/bloc/order_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubit/firebase/cubit/firebase_cubit.dart';
import 'package:shop_app/cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import 'package:shop_app/db/userDB.dart';
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/services/firebase_messaging/firebase_messaging.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/services/notification/notification.dart';
import 'my_app.dart';
import 'services/firestore_and_remoteConfig/firestore_database.dart';
import 'services/shared_preferences/shared_pref.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high-importance_channel', 'High Importance Notification',
    description: 'This is channel used for important notifications.',
    playSound: true,
    importance: Importance.high);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('A big message just showed up: ${message.data}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initializeNotification((value) {
    print("Clicked");
  });

  //My 3rd party local storage
  await GetStorage.init();

  //Register the locators
  await setLocator();

  // Firebase background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  //Firebase message listener
  FirebaseMessaging.onMessage.listen((event) {
    print("FirebaseMessaging onMessage called " + event.notification!.body!);
    NotificationService.pushNotification(
        id: 0,
        title: event.notification!.title!,
        body: event.notification!.body!);
  });

  // Open app when click the notification
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("FirebaseMessaging onMessageOpenedApp called ==> " +
        event.notification!.body!);
  });

  //Foreground notification presentation option
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, sound: true, badge: true);
  var user = await UserDb.instance.readAllUser();

  //FIrebase token refresh listerner
  //refresh token listener
  FirebaseMessaging.instance.onTokenRefresh.listen((String token) {
    print("Push token refresed ==> $token");
    if (sl<SharedPrefService>().getData(pushToken) != token) {
      //store refresh token
      sl<SharedPrefService>().setData(pushToken, token);
    }
    // sync token to server
  });

  //Init firebase remoteConfig Settings
  initRemoteConfig();

//Run Application
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => NetworkBloc()
            ..add(
              ListenConnection(),
            ),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => YourCartScreenCubit()..getCartData(),
        ),
        BlocProvider(
          create: ((context) => FirebaseCubit()),
        ),
        BlocProvider(
          create: ((context) => OrderBloc()),
        )
      ],
      child: MyApp(
        isLogged: user.length != 0 ? true : false,
      ),
    ),
  );
}
