// ignore_for_file: empty_statements
import 'package:flutter/material.dart';
import 'package:shop_app/db/database.dart';
import 'package:shop_app/db/userDB.dart';
import 'package:shop_app/screens/aboutUs/aboutus_screen.dart';
import 'package:shop_app/screens/my_address/my_address_screen.dart';
import 'package:shop_app/screens/order_history_screen/order_history_screen.dart';
import 'package:shop_app/services/locator.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences/shared_pref.dart';
import '../../sign_in/sign_in_screen.dart';
import '../../user_profile/user_profile_screen.dart';
import 'profile_menu.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * .15,
            padding: const EdgeInsets.only(bottom: 30),
            color: kPrimaryColor,
            width: MediaQuery.of(context).size.width,
            child: SizedBox(
              child: Image.asset(
                "assets/images/logoXL.png",
                filterQuality: FilterQuality.high,
              ),
            )),
        Expanded(
            flex: 4,
            child: Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ProfilePic(),
                      const SizedBox(height: 20),
                      ProfileMenu(
                        text: "My Account",
                        icon: "assets/icons/User Icon.svg",
                        press: () async => {
                          // get the scoped router by calling
                          Navigator.pushNamed(
                              context, UserProfileScreen.routeName),
                        },
                      ),
                      ProfileMenu(
                        text: "Order History",
                        icon: "assets/icons/order1.svg",
                        press: () async => {
                          // get the scoped router by calling
                          Navigator.pushNamed(
                              context, OrderHistoryScreen.routeName),
                        },
                      ),
                      ProfileMenu(
                        text: "Notifications",
                        icon: "assets/icons/Bell.svg",
                        press: () {},
                      ),
                      ProfileMenu(
                        text: "My Address",
                        icon: "assets/icons/address1.svg",
                        press: () {
                          Navigator.pushNamed(
                              context, MyAddressScreen.routeName);
                        },
                      ),
                      ProfileMenu(
                        text: "About Us",
                        icon: "assets/icons/Question mark.svg",
                        press: () {
                          Navigator.pushNamed(context, AboutUsScreen.routeName);
                        },
                      ),
                      ProfileMenu(
                        text: "Log Out",
                        icon: "assets/icons/Log out.svg",
                        press: () async {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                          await UserDb.instance.delete(1);
                          await MyDatabase.instance.deleteTable();
                          sl<SharedPrefService>().clearData();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ]))
      ],
    );
  }
}
