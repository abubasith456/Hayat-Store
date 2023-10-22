import 'package:flutter/foundation.dart';
import 'package:shop_app/models/my_address_model.dart';
import 'package:shop_app/models/user_db_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDb {
  static final UserDb instance = UserDb._init();

  static Database? _database;

  UserDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('UserDb.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $userDataTable (
  ${UserFields.id} $idType,
  ${UserFields.name} $textType,
  ${UserFields.email} $textType,
  ${UserFields.password} $textType,
  ${UserFields.userId} $textType,
  ${UserFields.role} $textType
  )
''');

    await db.execute('''
CREATE TABLE $MyAddress (
  ${MyAddressFields.id} $idType,
  ${MyAddressFields.name} $textType,
  ${MyAddressFields.userId} $textType,
  ${MyAddressFields.mobileNumber} $textType,
  ${MyAddressFields.pinCode} $textType,
  ${MyAddressFields.address} $textType,
  ${MyAddressFields.area} $textType,
  ${MyAddressFields.landmark} $textType,
  ${MyAddressFields.alteMobNumber} $textType
  )
''');
  }

//insert
  Future<User> create(User user) async {
    final db = await instance.database;
    final id = await db.insert(userDataTable, user.toJson());
    print("User added into Db");
    return user.copy(id: id);
  }

  Future<List<User>> readAllUser() async {
    final db = await instance.database;

    final name = '${UserFields.name} ASC';

    final result = await db.query(userDataTable, orderBy: name);

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<bool> isAdmin() async {
    final db = await instance.database;

    final name = '${UserFields.name} ASC';

    final dbResult = await db.query(userDataTable, orderBy: name);

    final result = dbResult.map((json) => User.fromJson(json)).toList();

    if (result.isNotEmpty) {
      var userRole = result[0].role;

      if (userRole == "admin") {
        return true;
      } else {
        return false;
      }
    }

    return false;
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      userDataTable,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

//insert my address
  Future<MyAddress> insert(MyAddress myAddress,
      {required String userId}) async {
    final db = await instance.database;
    final id = await db.insert(myAddressTableName + userId, myAddress.toJson());
    if (kDebugMode) {
      print("Address added into Db");
    }
    return myAddress.copy(id: id);
  }

// getUserAddress
  Future<List<MyAddress>> getUserAddress(String userId) async {
    final db = await instance.database;
    final myAddress = await db.query(myAddressTableName + userId,
        where: '${MyAddressFields.userId} = ?', whereArgs: [userId]);

    return myAddress.map((json) => MyAddress.fromJson(json)).toList();
  }

  Future<List<MyAddress>> readAllAddress({required String userId}) async {
    final db = await instance.database;

    const name = '${MyAddressFields.name} ASC';

    final result = await db.query(myAddressTableName + userId, orderBy: name);

    return result.map((json) => MyAddress.fromJson(json)).toList();
  }

  // delete address
  Future<int> deleteAddress(int id, {required String userId}) async {
    final db = await instance.database;

    return await db.delete(
      myAddressTableName + userId,
      where: '${MyAddressFields.id} = ?',
      whereArgs: [id],
    );
  }
}
