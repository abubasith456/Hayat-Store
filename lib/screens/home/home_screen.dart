import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:shop_app/bloc/liked_bloc/bloc/liked_bloc.dart';
import 'package:shop_app/bloc/vegetable_bloc/bloc/vegetable_screen_bloc.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/cubit/firebase/cubit/firebase_cubit.dart';
import 'package:shop_app/cubit/your_cart/cubit/your_cart_screen_cubit.dart';
import 'package:shop_app/services/firebase_messaging/firebase_messaging.dart';
import 'package:shop_app/services/firebase_push/firebase_push.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/services/shared_preferences/shared_pref.dart';
import 'package:shop_app/util/connection_lost.dart';
import 'package:shop_app/util/enums.dart';
import 'package:shop_app/screens/category_screeen/categories_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';

import '../../bloc/network_bloc/bloc/network_bloc.dart';
import '../../constants.dart';
import '../../util/size_config.dart';
import 'components/body.dart';
import 'home_init_Screen.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color inActiveIconColor = Color(0xFFB6B6B6);
  int currentIndex = 0;

  var pages = [
    HomeScreenInit(),
    CategoryScreeen(),
    ProfileScreen(),
  ];
  onPress(int index) {
    setState(() {
      currentIndex = index;
      if (index == 0) {
        //To refresh the cart count
        context.read<YourCartScreenCubit>().getCartData();
        // BlocProvider.of<LikedBloc>(context).add(GetLikedDBEvent());
      }
    });
  }

  @override
  void initState() {
    storeLocallyPushToken();
    context.read<YourCartScreenCubit>().getCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FirebaseCubit, FirebaseState>(
      listener: (context, state) {
        if (state is PushTokenStoringState) {
          SnackBar(
            content: Text(
              "Please wait....",
            ),
            duration: Duration(milliseconds: 2000),
            behavior: SnackBarBehavior.floating,
          );
        } else if (state is PushTokenStoredState) {
          SnackBar(
            content: Text(
              "Done",
            ),
            duration: Duration(milliseconds: 2000),
            behavior: SnackBarBehavior.floating,
          );
        }
      },
      child: Scaffold(
          body: IndexedStack(children: pages, index: currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            unselectedItemColor: inActiveIconColor,
            selectedItemColor: kPrimaryColor,
            unselectedIconTheme: IconThemeData(color: inActiveIconColor),
            selectedIconTheme: IconThemeData(color: kPrimaryColor),
            showUnselectedLabels: false,
            showSelectedLabels: false,
            elevation: 0,
            onTap: (value) => onPress(value),
            items: [
              BottomNavigationBarItem(
                label: "Home",
                tooltip: 'Home',
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: currentIndex == 0 ? kPrimaryColor : inActiveIconColor,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Liked',
                tooltip: 'Liked',
                icon: SvgPicture.asset(
                  "assets/icons/category.svg",
                  color: currentIndex == 1 ? kPrimaryColor : inActiveIconColor,
                ),
                //  SvgPicture.asset(
                //   "assets/icons/Heart Icon.svg",

                // ),
              ),
              // BottomNavigationBarItem(
              //   label: 'IDK',
              //   tooltip: '',
              //   icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
              // ),
              // BottomNavigationBarItem(
              //   label: 'Somehtimg',
              //   tooltip: 'Home',
              //   icon: SvgPicture.asset(
              //     "assets/icons/Shop Icon.svg",
              //   ),
              // ),
              BottomNavigationBarItem(
                label: 'Profile page',
                tooltip: 'Home',
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: currentIndex == 2 ? kPrimaryColor : inActiveIconColor,
                ),
              ),
            ],
          )

          //  CustomBottomNavBar(selectedMenu: MenuState.home),
          ),
    );
  }
}
