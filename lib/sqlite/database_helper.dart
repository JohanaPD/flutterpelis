import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peliculas_flutter/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseManager {
  static const _databaseName = 'Users.db';
  static const _databaseVersion = 1;

 DatabaseManager._();
 
  static final DatabaseManager instance = DatabaseManager._();
  static Database? _database;
 
  // Getter database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
 
    return _database!;
  }
 
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
 
    return await openDatabase(path, 
      version: _databaseVersion,
      onCreate: _onCreateDatabase
    );
  }

  // Método para crear la base de datos si es la primera vez.
  Future _onCreateDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario TEXT,
        passw TEXT
      )
    ''');
  }

Future<int> createUser(User user) async{
  final Database db = await database;
 
  int inserted = await db.insert('users', user.toJson());
 
  return inserted;
}
 
// Método que lista todos los usuarios de base de datos
Future<List<User>> listUsers() async{
  final Database db = await database;
   
  final List<Map<String, Object?>> respDb = await db.query('users');
 
  return respDb.map((e) => User.fromJson(e)).toList();
}
 
// Método que elimina un usuario de base de datos
Future<void> deleteUser(int id) async{
  final Database db = await database;
 
  db.delete('users', where: 'id = ?', whereArgs: [id]);
}
 
// Método que actualiza un usuario existente
Future<void> updateUser(User user) async{
  final Database db = await database;
 
  db.update('users', user.toJson(), where: 'id = ?', whereArgs: [user.id]);
}

Future<bool> loginUser(String usuario, String passw)async{
  final db= await database; 
  var res=  await db.query('Users', where: "usuario=? and passw=?", whereArgs: [usuario, passw]);

  return res.isNotEmpty;
}

Future <bool> verifyCredentials(String usuario, String passw)async{
  var  dbHelper= DatabaseManager._();
  bool  isValid= await dbHelper.loginUser(usuario, passw);
  return isValid;
}
}
