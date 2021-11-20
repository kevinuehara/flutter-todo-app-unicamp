import 'dart:convert';
import 'dart:io';

import 'package:flutter_todoapp/models/task_db.dart';
import 'package:dio/dio.dart';

class DatabaseRemoteServer {
  static DatabaseRemoteServer helper = DatabaseRemoteServer._createInstance();

  final Dio _dio = Dio();
  String databaseUrl = "http://192.168.15.17:3000/tasks";


  DatabaseRemoteServer._createInstance();


  Future<int> insertTask(TaskDB task) async {
    await _dio.post(databaseUrl,
        options: Options(headers: {"Accept": "application/json"}),
        data:
            jsonEncode({"title": task.title, "description": task.description, "done": false}));
    return 42;
  }

  Future<TaskDB> getTask(taskId) async {
    Response response = await _dio.get(
      databaseUrl + "/$taskId",
      options: Options(headers: {"Accept": "application/json"}),
    );
    return TaskDB.fromMap(response.data);
  }


  Future<int> updateTask(taskId, TaskDB task) async {
    print(taskId);
    print(task.title);
    await _dio.put(databaseUrl + "/$taskId",
        options: Options(headers: {"Accept": "application/json"}),
        data:
            jsonEncode({"title": task.title, "description": task.description, "done": task.done}));
    return 42;
  }

  Future<int> deleteTask(id) async {
    await _dio.delete(
      databaseUrl + "/$id",
      options: Options(headers: {"Accept": "application/json"}),
    );
    return 42;
  }

  Future<List<TaskDB>> getTasks() async {

    Response response = await _dio.get(
      databaseUrl,
      options: Options(headers: {"Accept": "application/json"}),
    );
    List<TaskDB> listTask = [];

    response.data.forEach((element) {
      if (element != null) {
        TaskDB task = TaskDB.fromMap(element);
        listTask.add(task);
      }
    });

    listTask.forEach((element) { print(element.id); });

    return listTask;
  }
}
