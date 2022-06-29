import 'package:shop_app/db/database.dart';
import 'package:sqflite/sqlite_api.dart';

// class DatabaseRepository {
//   late DatabaseConnector _databaseConnector;

//   DatabaseRepository() {
//     _databaseConnector = DatabaseConnector();
//   }

//   static Database? _database;
//   Future<Database?> get database async {
//     if (_database != null) {
//       return _database;
//     } else {
//       _database = await _databaseConnector.setDatabase();
//       return _database;
//     }
//   }

// //Insert user
//   insertData(table, data) async {
//     var connection = await database;
//     return await connection?.insert(table, data);
//   }

//   //Read all data
//   readData(table) async {
//     var connection = await database;
//     return await connection?.query(table);
//   }

//   //read seprate user
//   readDataById(table, itemId) async {
//     var connection = await database;
//     return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
//   }

//   //Upate user data
//   updateData(table, data) async {
//     var connection = await database;
//     return await connection
//         ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
//   }

// //deletw data
//   deleteDataById(table, itemId) async {
//     var connection = await database;
//     return await connection?.rawDelete("delete from $table where id=$itemId");
//   }
// }
