class PostModel {
  String? status;
  int? count;
  List<Posts>? posts;
  String? error;

  PostModel.error(String? statusMessage, {this.error});

  PostModel({this.status, this.count, this.posts});

  PostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['count'] = this.count;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  List<String>? likes;
  String? sId;
  User? user;
  String? image;
  String? profile;
  String? createdAt;
  int? iV;
  String? id;

  Posts(
      {this.likes,
      this.sId,
      this.user,
      this.image,
      this.profile,
      this.createdAt,
      this.iV,
      this.id});

  Posts.fromJson(Map<String, dynamic> json) {
    likes = json['likes'].cast<String>();
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    image = json['image'];
    profile = json['profile'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likes'] = this.likes;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['image'] = this.image;
    data['profile'] = this.profile;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}

class User {
  String? sId;
  int? uniqueId;
  String? email;
  String? username;
  String? dateOfBirth;
  String? mobileNumber;
  String? password;
  String? passwordConf;
  String? role;
  int? iV;
  String? pushToken;
  List<Null>? address;

  User(
      {this.sId,
      this.uniqueId,
      this.email,
      this.username,
      this.dateOfBirth,
      this.mobileNumber,
      this.password,
      this.passwordConf,
      this.role,
      this.iV,
      this.pushToken,
      this.address});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uniqueId = json['unique_id'];
    email = json['email'];
    username = json['username'];
    dateOfBirth = json['dateOfBirth'];
    mobileNumber = json['mobileNumber'];
    password = json['password'];
    passwordConf = json['passwordConf'];
    role = json['role'];
    iV = json['__v'];
    pushToken = json['pushToken'];
    // if (json['address'] != null) {
    //   address = <Null>[];
    //   json['address'].forEach((v) {
    //     address!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['unique_id'] = this.uniqueId;
    data['email'] = this.email;
    data['username'] = this.username;
    data['dateOfBirth'] = this.dateOfBirth;
    data['mobileNumber'] = this.mobileNumber;
    data['password'] = this.password;
    data['passwordConf'] = this.passwordConf;
    data['role'] = this.role;
    data['__v'] = this.iV;
    data['pushToken'] = this.pushToken;
    // if (this.address != null) {
    //   data['address'] = this.address!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
