import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/drinks_model.dart';
import 'package:shop_app/models/forgot_pswd_model.dart';
import 'package:shop_app/models/fruit_model.dart';
import 'package:shop_app/models/grocery_model.dart';
import 'package:shop_app/models/order_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/models/user_profile_model.dart';
import 'package:shop_app/models/vegetables_model.dart';
import '../models/login_model.dart';
import 'package:flutter/material.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final BASE_URL =
      "http://ec2-43-205-149-29.ap-south-1.compute.amazonaws.com:3000/";

//Login user
  Future<LoginModel> loginUser(String email, String password) async {
    try {
      var loginUrl = BASE_URL + "login";

      Map<String, String> mapValue = {
        'email': email,
        'password': password,
      };

      Response response = await _dio.post(loginUrl, data: mapValue);

      return LoginModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginModel.error("Data not found / Connection issue");
    }
  }

//Regsiter user
  Future<RegisterModel> registerUser(dynamic registerRequest) async {
    try {
      var registerUrl = BASE_URL + "register";

      Response response = await _dio.post(registerUrl,
          data: registerRequest,
          options: Options(
            followRedirects: false,
            // will not throw errors
            validateStatus: (status) => true,
          ));

      return RegisterModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return RegisterModel.error(e.toString());
    }
  }

  //Forgot password
  Future<ForgotPasswordModel> forgotPassword(
      dynamic forgotPasswordRequest, BuildContext context) async {
    try {
      var forgotPasswordUrl = BASE_URL + "forgotPassword";

      Response response = await _dio.post(
        forgotPasswordUrl,
        data: forgotPasswordRequest,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200) {
        return ForgotPasswordModel.fromJson(response.data);
      } else {
        return ForgotPasswordModel.error("Something went wrong!");
      }
    } catch (e) {
      return ForgotPasswordModel.error(e.toString());
    }
  }

  //Change password
  Future<ForgotPasswordModel> changePassword(
      dynamic changePasswordRequest) async {
    try {
      var changePasswordUrl = BASE_URL + "changePassword";

      Response response = await _dio.post(
        changePasswordUrl,
        data: changePasswordRequest,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200) {
        return ForgotPasswordModel.fromJson(response.data);
      } else {
        return ForgotPasswordModel.error("Something went wrong!");
      }
    } catch (e) {
      return ForgotPasswordModel.error(e.toString());
    }
  }

  //Verify OTP
  Future<ForgotPasswordModel> verifyOtp(dynamic verifyOtpRequest) async {
    try {
      var forgotPasswordUrl = BASE_URL + "forgotPassword/verify";

      Response response = await _dio.post(
        forgotPasswordUrl,
        data: verifyOtpRequest,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200) {
        return ForgotPasswordModel.fromJson(response.data);
      } else {
        return ForgotPasswordModel.error("Something went wrong!");
      }
    } catch (e) {
      return ForgotPasswordModel.error(e.toString());
    }
  }

//product
  Future<ProductModel> getProduct() async {
    try {
      var productUrl = BASE_URL + "products";

      Response response = await _dio.get(productUrl);
      print(response.data);
      return ProductModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return ProductModel.error(e.toString());
    }
  }

//Category - no use
  Future getCategory() async {
    try {
      var registerUrl = BASE_URL + "category";

      Response response = await _dio.get(registerUrl);
      List list = response.data;
      List<CategoryModel> categoryModelList =
          list.map((e) => CategoryModel.fromJson(e)).toList();

      return categoryModelList;
    } catch (e) {
      print(e);
      return CategoryModel.error(e.toString());
    }
  }

//Profile
  Future<UserProfileModel> getUserProfile(String userId) async {
    try {
      var profileDta = BASE_URL + "profile";

      Map<String, String> mapValue = {
        'userId': userId,
      };

      Response response = await _dio.post(profileDta, data: mapValue);

      return UserProfileModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return UserProfileModel.error(e.toString());
    }
  }

//GetVegetables
  Future<ProductModel> getVegetables() async {
    try {
      var VegetableUrl = BASE_URL + "vegetables";

      Response response = await _dio.get(VegetableUrl);

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        return ProductModel.error(response.statusMessage);
      }
    } catch (e) {
      print(e);
      return ProductModel.error(e.toString());
    }
  }

//Get Grocery
  Future<ProductModel> getGroceryItems() async {
    try {
      var groceryUrl = BASE_URL + "grocery";

      Response response = await _dio.get(groceryUrl);

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        return ProductModel.error(response.statusMessage);
      }
    } catch (e) {
      print(e);
      return ProductModel.error(e.toString());
    }
  }

//Get Drinks
  Future<ProductModel> getDrinksItems() async {
    try {
      var drinksUrl = BASE_URL + "drinks";

      Response response = await _dio.get(drinksUrl);

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        return ProductModel.error(response.statusMessage);
      }
    } catch (e) {
      print(e);
      return ProductModel.error(e.toString());
    }
  }

//Get Fruits
  Future<ProductModel> getFruitsItems() async {
    try {
      var fruitsUrl = BASE_URL + "fruits";

      Response response = await _dio.get(fruitsUrl);

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        return ProductModel.error(response.statusMessage);
      }
    } catch (e) {
      print(e);
      return ProductModel.error(e.toString());
    }
  }

//Get Dairy
  Future<ProductModel> getDairyItems() async {
    try {
      var dairyUrl = BASE_URL + "dairy";

      Response response = await _dio.get(dairyUrl);

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        return ProductModel.error(response.statusMessage);
      }
    } catch (e) {
      print(e);
      return ProductModel.error(e.toString());
    }
  }

  Future<OrdersNewModel> postOrders(dynamic list) async {
    try {
      // final req = json.encode(list);
      final orderUrl = BASE_URL + "orders";

      // print(list);

      Response response = await _dio.post(orderUrl, data: list);

      debugPrint("==> ${response.statusCode} ");

      if (response.statusCode == 500) {
        return OrdersNewModel.error(response.statusMessage!);
      } else {
        return OrdersNewModel.fromJson(response.data);
      }
    } catch (e) {
      print("Ordder==> " + e.toString());
      return OrdersNewModel.error(e.toString());
    }
  }

  //fcm
  Future<ForgotPasswordModel> setPushToken(String id, String pushToken) async {
    try {
      var tokenUrl = BASE_URL + "fcm/pushToken";

      Map<String, String> req = {"unique_id": id, "pushToken": pushToken};

      Response response = await _dio.post(tokenUrl, data: req);

      if (response.statusCode == 200) {
        return ForgotPasswordModel.fromJson(response.data);
      } else {
        return ForgotPasswordModel.error(response.statusMessage);
      }
    } catch (e) {
      print(e);
      return ForgotPasswordModel.error(e.toString());
    }
  }
}
