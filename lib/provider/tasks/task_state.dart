import 'package:flutter_todoapp/models/task_db.dart';

abstract class TaskState {}

class TaskLoadingState extends TaskState {}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState({required this.message});
}

class TaskStateLoaded extends TaskState {
  late List<TaskDB> tasks;

  TaskStateLoaded(List<TaskDB> tasks) {
    this.tasks = tasks;
  }
}

class TaskStateUpdated extends TaskState {
  late List<TaskDB> tasks;

  TaskStateUpdated(List<TaskDB> tasks) {
    this.tasks = tasks;
  }
}

class CreateTaskState extends TaskState {
  final TaskDB task;

  CreateTaskState({required this.task});
}

class UpdateTaskState extends TaskState {
  final TaskDB task;

  UpdateTaskState({required this.task});
}

class DeleteTaskState extends TaskState {
  final int id;

  DeleteTaskState({required this.id});
}
