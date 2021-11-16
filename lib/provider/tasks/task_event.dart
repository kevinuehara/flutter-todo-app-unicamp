import 'package:flutter_todoapp/models/task_db.dart';

abstract class TaskEvent {}

class FetchTaskList extends TaskEvent {}

class UpdateTaskList extends TaskEvent {
  final TaskDB task;
  final int id;

  UpdateTaskList({required this.id, required this.task});
}

class CreateTaskEvent extends TaskEvent {
  final TaskDB task;

  CreateTaskEvent({required this.task});
}

class UpdateTaskEvent extends TaskEvent {
  final TaskDB task;
  final int id;

  UpdateTaskEvent({required this.id, required this.task});
}

class DeleteTaskEvent extends TaskEvent {
  final int id;

  DeleteTaskEvent({required this.id});
}
