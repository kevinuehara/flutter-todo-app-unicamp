import 'dart:io';

import 'package:flutter_todoapp/models/task_db.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseLocalServer {
  static DatabaseLocalServer helper = DatabaseLocalServer._createInstance();
  static Database? _database;
  String taskTable = "task_table";
  String colTitle = "title";
  String colDescription = "description";
  String colId = "id";
  String colCreatedAt = "createdAt";
  String colDone = "done";

  DatabaseLocalServer._createInstance();

  get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "tasks.db";

    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  _createDb(Database db, int newVersion) {
    db.execute(""" 
      CREATE TABLE $taskTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTitle TEXT,
        $colDescription TEXT,
        $colCreatedAt TEXT,
        $colDone INTEGER
      )
      """);
  }

  Future<int> insertTask(TaskDB task) async {
    Database db = await this.database;
    return db.insert(this.taskTable, task.toMap());
  }

  Future<int> updateTask(int id, TaskDB task) async {
    Database db = await this.database;
    return db.update(this.taskTable, task.toMap(),
        where: "$colId = ?", whereArgs: [id]);
  }

  Future<int> deleteTask(int id) async {
    Database db = await this.database;
    return db.delete(this.taskTable, where: "$colId = ?", whereArgs: [id]);
  }

  getTasks() async {
    Database db = await this.database;
    List<Map<String, Object?>> taskMapList = await db.rawQuery("SELECT * FROM $taskTable;");
    List<TaskDB> taskList = [];
    List<int> idList = [];

    for (int i=0; i < taskMapList.length; i++) {
      TaskDB task = TaskDB.fromMap(taskMapList[i]);
      taskList.add(task);
      idList.add(int.parse(task.id!));
    }

    return [taskList, idList];
  }

  Future<TaskDB> getTaskById(int id) async {
    Database db = await this.database;
    List<Map<String, Object?>> taskMapList = await db.rawQuery("SELECT * FROM $taskTable where $colId = $id;");
    TaskDB task = TaskDB.fromMap(taskMapList[0]);
    return task;
  }
}
