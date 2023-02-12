import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/services/Location/location.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/util/adaptive_dialog.dart';
import 'package:shop_app/util/size_config.dart';
import 'package:shop_app/util/shared_pref.dart';

// This is the best practice
import '../../../services/permission/permission.dart';
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  var shredPref = SharedPref();
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Hayat store, Let’s shop!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text": "We help people conect with store \naround the Tamilnadu",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];
  final storage = GetStorage();

  @override
  void initState() {
    super.initState();
    sl<PermissionService>().getLocationPermission().then((value) {
      if (!value) {
        showAdaptiveAlertDialog(
            context, permisstionNeededTitle, permisstionNeededMessage, () {
          openAppSettings();
          Navigator.of(context).pop();
        }, permisionNeededbtNText);
      } else {
        sl<LocationService>().getAddressDetailsGeo();
      }
    });
  }

  // _getAddressDetailsGeo() async {
  //   try {
  //     await sl<PermissionService>().getLocationPermission().then((value) async {
  //       if (value) {
  //         print("getLocationPermission caled ===> ");
  //         await sl<LocationService>()
  //             .determinePosition()
  //             .then((position) async {
  //           print("determinePosition caled ===> ");
  //           sl<LocationService>().getAdressDetailsFromGeo(position);
  //         });
  //       } else {
  //         return;
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //     return;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      isEnabled: true,
                      text: "Continue",
                      isLoading: false,
                      press: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        // sharedPreferences.setInt('onBoard', 0);
                        sharedPreferences.setBool("seen", true);
                        storage.write('seen', 'yes');
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
