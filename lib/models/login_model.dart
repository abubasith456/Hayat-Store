class LoginModel {
  int? status;
  String? connection;
  String? message;
  UserData? userData;
  String? errorMessage;

  LoginModel({this.status, this.connection, this.message, this.userData});

  LoginModel.loginError(String error) {
    this.errorMessage = error;
  }

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    connection = json['connection'];
    message = json['message'];
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['connection'] = this.connection;
    data['message'] = this.message;
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  int? userId;
  String? username;
  String? email;
  String? dateOfBirth;
  String? mobileNumber;

  UserData(
      {this.userId,
      this.username,
      this.email,
      this.dateOfBirth,
      this.mobileNumber});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    mobileNumber = json['mobileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['dateOfBirth'] = this.dateOfBirth;
    data['mobileNumber'] = this.mobileNumber;
    return data;
  }
}
