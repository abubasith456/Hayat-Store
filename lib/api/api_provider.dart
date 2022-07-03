import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/drinks_model.dart';
import 'package:shop_app/models/grocery_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/models/user_profile_model.dart';
import 'package:shop_app/models/vegetables_model.dart';
import '../models/login_model.dart';
import 'package:flutter/material.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final url = "https://hidden-waters-80713.herokuapp.com";

//Login user
  Future<LoginModel> loginUser(String email, String password) async {
    try {
      var loginUrl = "https://hidden-waters-80713.herokuapp.com/login";

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
      var registerUrl = "https://hidden-waters-80713.herokuapp.com/register";

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

//product
  Future<ProductModel> getProduct() async {
    try {
      var registerUrl = "https://hidden-waters-80713.herokuapp.com/products";

      Response response = await _dio.get(registerUrl);

      return ProductModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return ProductModel.error(e.toString());
    }
  }

//Category
  Future getCategory() async {
    try {
      var registerUrl = "https://hidden-waters-80713.herokuapp.com/category";

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
      var profileDta = "https://hidden-waters-80713.herokuapp.com/profile";

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

  Future<VegetablesModel> getVegetables() async {
    try {
      var VegetableUrl = "https://hidden-waters-80713.herokuapp.com/vegetables";

      Response response = await _dio.get(VegetableUrl);

      return VegetablesModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return VegetablesModel.error(e.toString());
    }
  }

  Future<GroceryModel> getGroceryItems() async {
    try {
      var groceryUrl = "https://hidden-waters-80713.herokuapp.com/grocery";

      Response response = await _dio.get(groceryUrl);

      return GroceryModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return GroceryModel.error(e.toString());
    }
  }

  Future<DrinksModel> getDrinksItems() async {
    try {
      var drinksUrl = "https://hidden-waters-80713.herokuapp.com/drinks";

      Response response = await _dio.get(drinksUrl);

      return DrinksModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return DrinksModel.error(e.toString());
    }
  }
}
