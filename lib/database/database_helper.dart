import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../model/user_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "user.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE users (
        id INTEGER PRIMARY KEY , 
        username Text ,
        password Text
        )
        ''');
  }

  Future<List<User>> getUsers() async {
    Database db = await instance.database;
    var users = await db.query('users', orderBy: 'username');
    List<User> userList = users.isNotEmpty
        ? users.map((e) => User.fromMap(e)).toList()
        : [];
    return userList;
  }

  Future<int> add(User user) async {
    Database db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<int> remove(int id)async{
    Database db = await instance.database;
    return await db.delete('users',where: 'id = ?',whereArgs: [id]);
  }

  Future<int> update(User user)async{
    Database db = await instance.database;
    return await db.update('users', user.toMap(),where: 'id = ?',whereArgs: [user.id],conflictAlgorithm: ConflictAlgorithm.replace);
  }
}