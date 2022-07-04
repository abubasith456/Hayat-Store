import 'package:flutter/material.dart';
import 'package:shop_app/util/size_config.dart';

const kPrimaryColor = Color.fromARGB(255, 67, 177, 255);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const KAshColor = Color.fromARGB(255, 177, 177, 177);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String mobileNumberError = "Please Enter Your Mobile Number ";
const String mobileNumberErrorLength = "Please Enter The Valid Number";
const String dateOfError = "Please Enter Your Date Of Birth ";
const String usernameError = "Please Enter Your Username";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

//shared pref
const String loggedKey = 'LoggedIn';
const String isFirstLogin = 'isFirstLogin';
const String emailKey = 'email';
const String userIdKey = 'userId';

//Url
const String imageLoadUrl = 'https://hidden-waters-80713.herokuapp.com/';

enum TopSnackBarType { success, error, info }

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

List<Map<String, dynamic>> categories = [
  {"icon": "assets/icons/vegetablesIcon.svg", "text": "Vegetables"},
  {"icon": "assets/icons/groceryIcon.svg", "text": "Grocery"},
  {"icon": "assets/icons/drinksIcon.svg", "text": "Drinks"},
  {"icon": "assets/icons/fruitsIcon.svg", "text": "Fruits"},
  {"icon": "assets/icons/dairy.svg", "text": "Dairy"},
];
