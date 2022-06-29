// import 'package:shop_app/models/user.dart';

// import '../api/repository/db_repo.dart';

// class UserService {
//   late DatabaseRepository _repository;
//   UserService() {
//     _repository = DatabaseRepository();
//   }
//   //Save User
//   SaveUser(User user) async {
//     return await _repository.insertData('users', user.userMap());
//   }

//   //Read All Users
//   readAllUsers() async {
//     return await _repository.readData('users');
//   }

//   //Edit User
//   UpdateUser(User user) async {
//     return await _repository.updateData('users', user.userMap());
//   }

//   deleteUser(userId) async {
//     return await _repository.deleteDataById('users', userId);
//   }
// }
