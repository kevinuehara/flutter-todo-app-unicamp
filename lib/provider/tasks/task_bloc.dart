import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todoapp/data/mock_tasks.dart';
import 'package:flutter_todoapp/provider/tasks/task_event.dart';
import 'package:flutter_todoapp/provider/tasks/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(TaskState initialState) : super(TaskLoadingState());

  TaskState get initialState => TaskLoadingState();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    TaskLoadingState();

    if (event is FetchTaskList) {
      yield TaskStateLoaded(taskList: MOCK_TASKS);
    } else if (event is CreateTaskEvent) {
      yield CreateTaskState(task: event.task);
    } else if (event is UpdateTaskEvent) {
      yield UpdateTaskState(task: event.task);
    } else if (event is DeleteTaskEvent) {
      yield DeleteTaskState(id: event.id);
    }
  }
}