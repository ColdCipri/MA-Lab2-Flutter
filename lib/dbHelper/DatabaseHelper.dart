import 'dart:async';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_app/model/Med.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  final String tableMeds = 'medsTable';
  final String columndId = 'id';
  final String columnName = 'name';
  final String columnExpDate = 'exp_date';
  final String columnPieces = 'pieces';
  final String columnBaseSubst = 'base_subst';
  final String columnQuantity = 'quantity';
  final String columnDescription = 'description';

  factory DatabaseHelper() => _instance;
  static Database _db;

  DatabaseHelper.internal();
  
  Future<Database> get db async {
    if (_db != null){
      return _db;
    }
    _db = await initDb();
    
    return _db;
  }
  
  initDb() async{
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'meds.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $tableMeds($columndId INTEGER PRIMARY KEY, $columnName TEXT, $columnExpDate TEXT, $columnPieces INT, $columnBaseSubst TEXT, $columnQuantity TEXT, $columnDescription TEXT)');
    
  }
  
  Future<int> saveMed(Med med) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableMeds, med.toMap());
    
    return result;
  }
  
  Future<List> getallMeds() async {
    var dbClient = await db;
    var result = await dbClient.query(tableMeds, columns: [columndId, columnName, columnExpDate, columnPieces, columnBaseSubst, columnQuantity, columnDescription]);

    return result.toList();
  }


  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableMeds'));
  }

  Future<Med> getMed(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableMeds,
      columns: [columndId, columnName, columnExpDate, columnPieces, columnBaseSubst, columnQuantity, columnDescription],
      where: '$columndId = ?',
      whereArgs: [id]);
    
    if (result.length > 0) {
      return new Med.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteMed(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableMeds,
      where: '$columndId = ?',
      whereArgs: [id]
    );
  }

  Future<int> updateMed(Med med) async {
    var dbClient = await db;
    return await dbClient.update(tableMeds,
      med.toMap(),
      where: "$columndId = ?",
      whereArgs: [med.id]
    );
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}