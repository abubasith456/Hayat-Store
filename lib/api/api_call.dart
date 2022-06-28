import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/models/register_model.dart';
import '../models/login_model.dart';
import 'package:flutter/material.dart';

class ApiProvider {
  final Dio _dio = Dio();

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

  Future<RegisterModel> registerUser(dynamic registerRequest) async {
    try {
      var registerUrl = "https://hidden-waters-80713.herokuapp.com/register";

      Response response = await _dio.post(registerUrl, data: registerRequest);

      return RegisterModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return RegisterModel.error(e.toString());
    }
  }

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
}
