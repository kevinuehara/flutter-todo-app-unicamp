import 'package:flutter/material.dart';
import 'package:flutter_todoapp/models/task_db.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String createdAt;
  final bool done;

  const Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.createdAt,
    required this.done,
  });

  TaskDB parseTaskToTaskDB(Task task) {
    return new TaskDB(this.id,this.title, this.description, this.createdAt, this.done);
  }
}