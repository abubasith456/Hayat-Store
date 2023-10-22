import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/bloc/network_bloc/bloc/network_bloc.dart';
import 'package:shop_app/bloc/news_block/post_bloc.dart';
import 'package:shop_app/bloc/order_bloc/bloc/order_bloc.dart';
import 'package:shop_app/bloc/orders_admin_bloc/bloc/orders_admin_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubit/firebase/cubit/firebase_cubit.dart';
import 'package:shop_app/cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import 'package:shop_app/db/userDB.dart';
import 'package:shop_app/firebase_options.dart';
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

int id = 0;

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
          Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  // String initialRoute = HomePage.routeName;
  // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
  //   selectedNotificationPayload =
  //       notificationAppLaunchDetails!.notificationResponse?.payload;
  //   initialRoute = SecondPage.routeName;
  // }

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: darwinNotificationCategories,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  //Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await NotificationService.initializeNotification((value) {
//     print("Clicked");
//   });

//   await FirebaseMessaging.instance.setAutoInitEnabled(true);

//     final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//   // Firebase background message handler
// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   // handle action
// }
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

//   // Open app when click the notification
//   FirebaseMessaging.onMessageOpenedApp.listen((event) {
//     print("FirebaseMessaging onMessageOpenedApp called ==> " +
//         event.notification!.body!);
//   });

//   //Foreground notification presentation option
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true, sound: true, badge: true);

  // DB
  //My 3rd party local storage
  await GetStorage.init();

  //Register the locators
  await setLocator();
  var user = await UserDb.instance.readAllUser();
  var isAdmin = await UserDb.instance.isAdmin();

  //FIrebase token refresh listerner
  //refresh token listener
   FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance; // Change here
    firebaseMessaging.getToken().then((token){
      print("token is $token");
          if (sl<SharedPrefService>().getData(pushToken) != token) {
      //store refresh token
      sl<SharedPrefService>().setData(pushToken, token!);
    }
  });
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
        ),
        BlocProvider(
          create: ((context) => OrdersAdminBloc()),
        ),
        BlocProvider(
          create: ((context) => PostBloc()..add(GetPost())),
        ),
      ],
      child: MyApp(
        isLogged: user.isNotEmpty ? true : false,
        isAdmin: isAdmin,
      ),
    ),
  );
}
