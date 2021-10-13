import 'package:flutter_todoapp/models/task.dart';

abstract class TaskState{}

class TaskLoadingState extends TaskState {}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState({required this.message});
}

class TaskStateLoaded extends TaskState {
  final List<Task> taskList;

  TaskStateLoaded({required this.taskList});
}

class CreateTaskState extends TaskState {
  final Task task;

  CreateTaskState({required this.task});
}

class UpdateTaskState extends TaskState {
  final Task task;

  UpdateTaskState({required this.task});
}

class DeleteTaskState extends TaskState {
  final String id;

  DeleteTaskState({required this.id});
}