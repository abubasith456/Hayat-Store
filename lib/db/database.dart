import 'package:path_provider/path_provider.dart';
import 'package:shop_app/models/user.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/my_db_model.dart';

class MyDatabase {
  static final MyDatabase instance = MyDatabase._init();

  static Database? _database;

  MyDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('MyDb.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY';
    final textType = 'TEXT';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    // await db.execute(
    //     'CREATE TABLE $CartData (id INTEGER PRIMARY KEY, name TEXT, price TEXT, description REAL, categoryId TEXT, productImage TEXT, productId TEXT)');

    await db.execute('''
CREATE TABLE $CartData (
  ${CartFields.id} $idType,
  ${CartFields.name} $textType,
  ${CartFields.price} $textType,
  ${CartFields.description} $textType,
  ${CartFields.categoryId} $textType,
  ${CartFields.productImage} $textType,
   ${CartFields.productId} $textType
  )
''');
  }

  Future<Cart> create(Cart cart) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(CartData, cart.toJson());
    print("Cart added");
    return cart.copy(id: id);
  }

  Future<Cart> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      CartData,
      columns: CartFields.values,
      where: '${CartFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Cart.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Cart>> readAllcart() async {
    final db = await instance.database;

    final name = '${CartFields.name} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(CartData, orderBy: name);

    return result.map((json) => Cart.fromJson(json)).toList();
  }

  Future<int> update(Cart note) async {
    final db = await instance.database;

    return db.update(
      CartData,
      note.toJson(),
      where: '${CartFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      CartData,
      where: '${CartFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}

// Future<Database> setDatabase() async {
//   var directory = await getApplicationDocumentsDirectory();
//   var path = join(directory.path, 'MY_DB');
//   var database =
//       await openDatabase(path, version: 1, onCreate: _createDatabase);
//   return database;
// }

// Future<void> _createDatabase(Database database, int version) async {
//   String sql =
//       "CREATE TABLE users (id INTEGER PRIMARY KEY,userIdTEXT,emalTEXT,passwordText);";
//   await database.execute(sql);
// }
