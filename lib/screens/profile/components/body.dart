// ignore_for_file: empty_statements

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:shop_app/db/db_services.dart';
import 'package:shop_app/db/userDB.dart';
import 'package:shop_app/router/routes.dart';
import 'package:shop_app/util/shared_pref.dart';
import '../../../animation/animation_demo.dart';
import '../../../constants.dart';
import '../../sign_in/sign_in_screen.dart';
import '../../user_profile/user_profile_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sharedPref = SharedPref();

    Future getUser() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.get(userIdKey);
    }

    return Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * .15,
            padding: const EdgeInsets.only(bottom: 30),
            color: kPrimaryColor,
            width: double.infinity,
            child: Center(
                child: Text(
              "Hayat Store",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ))),
        Expanded(
            flex: 4,
            child: Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
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
                      SizedBox(height: 20),
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
                        text: "Notifications",
                        icon: "assets/icons/Bell.svg",
                        press: () {},
                      ),
                      ProfileMenu(
                        text: "Settings",
                        icon: "assets/icons/Settings.svg",
                        press: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute<void>(
                          //     builder: (BuildContext context) {
                          //       return const OpenContainerTransformDemo();
                          //     },
                          //   ),
                          // );
                        },
                      ),
                      ProfileMenu(
                        text: "Help Center",
                        icon: "assets/icons/Question mark.svg",
                        press: () {},
                      ),
                      ProfileMenu(
                        text: "Log Out",
                        icon: "assets/icons/Log out.svg",
                        press: () async {
                          // _userService.deleteUser(1);
                          sharedPref.setBoolValue(loggedKey, false);
                          Navigator.pushNamed(context, SignInScreen.routeName);
                          await UserDb.instance.delete(1);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ]))
      ],
    );

    // Column(children: [
    //   Container(
    //       height: MediaQuery.of(context).size.height - 600,
    //       color: kPrimaryColor,
    //       width: double.infinity,
    //       child: Center(
    //           child: Text(
    //         "Hayat Store",
    //         style: TextStyle(
    //             color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
    //       ))),
    //   Container(
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height,
    //     child: Card(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    //       ),
    //       child: SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             // ProfilePic(),
    //             SizedBox(height: 20),
    //             ProfileMenu(
    //               text: "My Account",
    //               icon: "assets/icons/User Icon.svg",
    //               press: () async => {
    //                 // get the scoped router by calling
    //                 Navigator.pushNamed(context, UserProfileScreen.routeName),
    //               },
    //             ),
    //             ProfileMenu(
    //               text: "Notifications",
    //               icon: "assets/icons/Bell.svg",
    //               press: () {},
    //             ),
    //             ProfileMenu(
    //               text: "Settings",
    //               icon: "assets/icons/Settings.svg",
    //               press: () {},
    //             ),
    //             ProfileMenu(
    //               text: "Help Center",
    //               icon: "assets/icons/Question mark.svg",
    //               press: () {},
    //             ),
    //             ProfileMenu(
    //               text: "Log Out",
    //               icon: "assets/icons/Log out.svg",
    //               press: () async {
    //                 // _userService.deleteUser(1);
    //                 sharedPref.setBoolValue(loggedKey, false);
    //                 Navigator.pushNamed(context, SignInScreen.routeName);
    //                 await UserDb.instance.delete(1);
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   )
    // ]);
  }
}
