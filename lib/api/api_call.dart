import 'dart:async';

import 'package:dio/dio.dart';

import '../models/login_model.dart';
import 'package:flutter/material.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future<LoginModel> loginUser() async {
    try {
      var loginUrl = " https://hidden-waters-80713.herokuapp.com/login";
      Response response = await _dio.get(loginUrl);
      return LoginModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginModel.loginError("Data not found / Connection issue");
    }
  }
}
