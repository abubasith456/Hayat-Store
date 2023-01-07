import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/bloc/order_bloc/bloc/order_bloc.dart';
import 'package:shop_app/cubit/firebase/cubit/firebase_cubit.dart';
import 'package:shop_app/cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import 'package:shop_app/db/userDB.dart';
import 'package:shop_app/services/locator.dart';
import 'my_app.dart';

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
  await Firebase.initializeApp();
  await GetStorage.init();
  await setLocator();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, sound: true, badge: true);
  var user = await UserDb.instance.readAllUser();

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
