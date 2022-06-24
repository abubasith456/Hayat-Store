class User {
  int? id;
  int? userId;
  String? email;
  String? password;

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['userId'] = userId ?? null;
    mapping['email'] = email ?? '';
    mapping['password'] = password ?? '';

    return mapping;
  }
}
