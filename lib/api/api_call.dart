import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
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
}
