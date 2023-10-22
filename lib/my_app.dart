
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop_app/admin_screens/orders_list_screen.dart';
import 'package:shop_app/router/routes.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/util/theme.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.isLogged, required this.isAdmin})
      : super(key: key);
  late bool isLogged;
  late bool isAdmin;
  final storage = GetStorage();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    String seen = widget.storage.read('seen') ?? '';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hayat Shop',
      theme: theme(),
      builder: (context, child) => ResponsiveBreakpoints.builder(
         child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: widget.isLogged
          ? widget.isAdmin
              ? OrdersListAdminScreen.routeName
              : HomeScreen.routeName
          : seen == 'yes'
              ? SignInScreen.routeName
              : SplashScreen.routeName,
      routes: routes,
    );
  }
}
