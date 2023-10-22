class CommentModel {
  String? status;
  int? data;
  List<Comments>? comments;
  String? error;

  CommentModel.error({this.error});

  CommentModel({this.status, this.data, this.comments});

  CommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  List<Likes>? likes;
  String? sId;
  User? user;
  String? post;
  String? comment;
  int? iV;
  String? createdAt;
  String? id;

  Comments(
      {this.likes,
      this.sId,
      this.user,
      this.post,
      this.comment,
      this.iV,
      this.createdAt,
      this.id});

  Comments.fromJson(Map<String, dynamic> json) {
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(new Likes.fromJson(v));
      });
    }
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    post = json['post'];
    comment = json['comment'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['post'] = this.post;
    data['comment'] = this.comment;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class Likes {
  String? sId;
  String? username;

  Likes({this.sId, this.username});

  Likes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
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
    //     address!.add(new void.fromJson(v));
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
    //   data['address'] = this.address!.map((v) => v!.toJson()).toList();
    // }
    return data;
  }
}
