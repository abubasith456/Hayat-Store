class RegisterModel {
  int? status;
  String? connection;
  String? message;
  UserData? userData;
  String? error;

  RegisterModel.error(String error) {
    this.error = error;
  }

  RegisterModel({this.status, this.connection, this.message, this.userData});

  RegisterModel.fromJson(Map<String, dynamic> json) {
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
  String? role;

  UserData(
      {this.userId,
      this.username,
      this.email,
      this.dateOfBirth,
      this.mobileNumber,
      this.role});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    mobileNumber = json['mobileNumber'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['dateOfBirth'] = this.dateOfBirth;
    data['mobileNumber'] = this.mobileNumber;
    data['role'] = this.role;
    return data;
  }
}
