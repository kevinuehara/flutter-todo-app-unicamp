import 'package:flutter_todoapp/models/task_db.dart';

class TaskCollection {
  late List<int> idList;
  late List<TaskDB> taskList;

  TaskCollection() {
    this.idList = [];
    this.taskList = [];
  }

  int length() {
    return idList.length;
  }

  TaskDB getTaskAtIndex(int index) {
    return taskList[index];
  }

  int getIdAtIndex(int index) {
    return idList[index];
  }

  int getIndexOfId(int id) {
    for (int i = 0; i < idList.length; i++) {
      if (id == idList[i]) {
        return i;
      }
    }
    return -1;
  }

  updateNoteOfId(int id, TaskDB task) {
    int index = getIndexOfId(id);
    if (index != -1) {
      taskList[index] = task;
    }
  }

  deleteNoteOfId(int id) {
    int index = getIndexOfId(id);
    if (index != -1) {
      taskList.removeAt(index);
      idList.removeAt(index);
    }
  }

  insertNoteOfId(int id, TaskDB task) {
    idList.add(id);
    taskList.add(task);
  }
}
