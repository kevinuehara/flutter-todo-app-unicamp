import 'package:flutter_todoapp/models/task.dart';

abstract class TaskEvent {}

class FetchTaskList extends TaskEvent {}

class CreateTaskEvent extends TaskEvent {
  final Task task;
  
  CreateTaskEvent({required this.task});
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;
  
  UpdateTaskEvent({required this.task});
}

class DeleteTaskEvent extends TaskEvent {
  final String id;
  
  DeleteTaskEvent({required this.id});
}