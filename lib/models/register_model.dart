import 'dart:math';

class RegisterModel {
  int? status;
  String? connection;
  String? message;
  String? error;

  RegisterModel.error(String error) {
    this.error = error;
  }

  RegisterModel({this.status, this.connection, this.message});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    connection = json['connection'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['connection'] = this.connection;
    data['message'] = this.message;
    return data;
  }
}
