// ignore_for_file: empty_statements
import 'package:flutter/material.dart';
import 'package:shop_app/db/database.dart';
import 'package:shop_app/db/userDB.dart';
import 'package:shop_app/screens/aboutUs/aboutus_screen.dart';
import 'package:shop_app/screens/order_history_screen/order_history_screen.dart';
import '../../../constants.dart';
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
            )
            //  Center(
            //   child: Text(
            //     "Hayat Store",
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 25,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            ),
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
                        text: "Order History",
                        icon: "assets/icons/User Icon.svg",
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
                          //   FirebaseFirestore.instance
                          //   .collection("test").
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
