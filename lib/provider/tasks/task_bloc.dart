import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todoapp/data/local/local_database.dart';
import 'package:flutter_todoapp/models/task_db.dart';
import 'package:flutter_todoapp/provider/tasks/task_event.dart';
import 'package:flutter_todoapp/provider/tasks/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(TaskState initialState) : super(TaskLoadingState());

  TaskState get initialState => TaskLoadingState();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is FetchTaskList) {
      List<TaskDB> tasks = await DatabaseLocalServer.helper.getTasks();
      yield TaskStateLoaded(tasks);
    } else if (event is UpdateTaskList) {
      await DatabaseLocalServer.helper.updateTask(event.id, event.task);
      List<TaskDB> tasks = await DatabaseLocalServer.helper.getTasks();
      yield TaskStateUpdated(tasks);
    } else if (event is CreateTaskEvent) {
      await DatabaseLocalServer.helper.insertTask(event.task);
      yield CreateTaskState(task: event.task);
    } else if (event is UpdateTaskEvent) {
      await DatabaseLocalServer.helper.updateTask(event.id, event.task);
      yield UpdateTaskState(task: event.task);
    } else if (event is DeleteTaskEvent) {
      await DatabaseLocalServer.helper.deleteTask(event.id);
      yield DeleteTaskState(id: event.id);
    }
  }
}
