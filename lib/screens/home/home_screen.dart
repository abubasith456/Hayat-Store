import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/util/enums.dart';
import 'package:shop_app/screens/liked_screeen/liked_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';

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
    LikedScreeen(),
    ProfileScreen(),
  ];
  onPress(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(children: pages, index: currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          unselectedItemColor: inActiveIconColor,
          selectedItemColor: kPrimaryColor,
          unselectedIconTheme: IconThemeData(color: inActiveIconColor),
          selectedIconTheme: IconThemeData(color: kPrimaryColor),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 10,
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
                "assets/icons/Heart Icon.svg",
                color: currentIndex == 1 ? kPrimaryColor : inActiveIconColor,
              ),
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
        );
  }
}
