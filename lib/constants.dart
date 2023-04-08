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
const buttonDisabledColor = Color.fromARGB(255, 197, 197, 197);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// IMPORTANT!
const String customer = "customer";
const String admin = "admin";

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kcnfrmPassError = "Password not match";
const String kMatchPassError = "Passwords don't match";
const String mobileNumberError = "Please Enter Your Mobile Number ";
const String mobileNumberErrorLength = "Please Enter The Valid Number";
const String dateOfError = "Please Enter Your Date Of Birth ";
const String usernameError = "Please Enter Your Username";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

//Delete order
const deleteOrderTitle = "Alert!";
const deleteOrderMessage =
    "Are you sure do you want to delete order data from order history?";
const deletingOrder = "Deleting order...";

//Cancel order
const String cancelPopupTitle = 'Cancel order';
const String cancelPopupMessage =
    'Are you sure, do you want to cancel ypur order?';
const String cancelingOrderProgressText = "Canceling order...";

//Accepting order
const String acceptingOrder = "Accepting Order...";
const String perparingOrder = "Preparing Order...";

// Cancel Order - Admin
const String cancellingOrderAdmin = "";
const String cancelOrderAdminTitile = "Cancel Order!";
const String cancelOrderAdminMessage = "Are you sure do you cancel this order?";

//Common buttontext
const String buttonOkText = 'Ok';
const String buttonYesText = "Yes";
const String buttonNoText = "No";
const String buttonCancelText = "Cancel";

//Something went wrong
const String exceptinTitle = 'Alert!';
const String exceptinMessage =
    'Something went Wrong. Please try again later...';

//Firebase fierstore update keys
const String updateCollectionName = 'update_status';
const String updateDocumentInfoName = 'update_info';
const String updateFieldMessageKey = 'update_message';
const String updateDialogTitle = 'Update available';
const String updateLinkKey = 'update_link';
const String updateOptionalLinkKey = 'update_optional_link';
const String cancelUpdateButtonText = 'Cancel';
const String updateButtonText = 'Update';

//Firebase fierstore Miantenance keys
const String miantenanceCollectionKey = 'maintenance_status';
const String miantenanceDocumentKey = 'maintenance_info';
const String appInMaintenanceMessageKey = 'app_in_maintenance_message';
const String appWillInMaintenanceMessageKey = 'app_will_in_maintenance_message';
const String appInMaintenanceTitle = 'Oops!';
const String appWillInMaintenanceTitle = 'Alert!';

//Remote config
const String remoteConfigUpdateKey = 'update_available';
const String remoteConfigAppInMaintenanceKey = 'app_in_maintenance';
const String remoteConfigAppWillInMaintenance = "app_will_in_maintenance";
const String baseUrlKey = "base_url";

//shared pref
const String loggedKey = 'LoggedIn';
const String isFirstLogin = 'isFirstLogin';
const String emailKey = 'email';
const String userIdKey = 'userId';
const String userNameKey = 'userName';
const String pushToken = 'pushToken';
const String areaNameKey = 'areaName';
const String pinCodeKey = 'pinCode';
const String userRole = "userRole";

//Permission related
const String permisstionNeededTitle = "Premission";
const String permisstionNeededMessage =
    "Location permission needed to find your accurate address!.";
const String permisionNeededbtNText = "Go to Settings";

//Url
String imageLoadUrl =
    'http://ec2-43-205-149-29.ap-south-1.compute.amazonaws.com:3000/';
String APP_BASE_URL =
    "http://ec2-43-205-149-29.ap-south-1.compute.amazonaws.com:3000/";

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

List<Map<String, dynamic>> categoryListBottom = [
  {"icon": "assets/icons/vegetablesIcon.svg", "text": "Vegetables"},
  {"icon": "assets/icons/groceryIcon.svg", "text": "Grocery"},
  {"icon": "assets/icons/drinksIcon.svg", "text": "Drinks"},
  {"icon": "assets/icons/fruitsIcon.svg", "text": "Fruits"},
  {"icon": "assets/icons/dairy.svg", "text": "Dairy"},
];
