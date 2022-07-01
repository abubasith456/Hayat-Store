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
    final idType = 'INTEGER PRIMARY KEY';
    final textType = 'TEXT';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    // await db.execute(
    //     'CREATE TABLE $CartData (id INTEGER PRIMARY KEY, name TEXT, price TEXT, description REAL, categoryId TEXT, productImage TEXT, productId TEXT)');

    await db.execute('''
CREATE TABLE $UserData (
  ${UserFields.id} $idType,
  ${UserFields.name} $textType,
  ${UserFields.email} $textType,
  ${UserFields.password} $textType,
  ${UserFields.userId} $textType
  )
''');
  }

//insert
  Future<User> create(User user) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(UserData, user.toJson());
    print("User added into Db");
    return user.copy(id: id);
  }

  Future<List<User>> readAllcart() async {
    final db = await instance.database;

    final name = '${UserFields.name} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(UserData, orderBy: name);

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      UserData,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }
}
