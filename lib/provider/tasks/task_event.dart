import 'package:flutter_todoapp/models/task_db.dart';

abstract class TaskEvent {}

class FetchTaskList extends TaskEvent {}

class UpdateTaskList extends TaskEvent {
  final TaskDB task;
  final String? id;

  UpdateTaskList({this.id, required this.task});
}

class CreateTaskEvent extends TaskEvent {
  final TaskDB task;

  CreateTaskEvent({required this.task});
}

class UpdateTaskEvent extends TaskEvent {
  final TaskDB task;
  final String id;

  UpdateTaskEvent({required this.id, required this.task});
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  DeleteTaskEvent({required this.id});
}
