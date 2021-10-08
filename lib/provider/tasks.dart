import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todoapp/data/mock_tasks.dart';
import 'package:flutter_todoapp/models/task.dart';

class Tasks with ChangeNotifier {
  Map<String, Task> _items = {...MOCK_TASKS};

  List<Task> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Task byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Task task) {
    if (task == null) {
      return;
    }

    if (task.id != null &&
        task.id.trim().isNotEmpty &&
        _items.containsKey(task.id)) {
      _items.update(task.id, (_) => task);
    } else {
      final id = Random().nextDouble().toString();

      _items.putIfAbsent(
          id,
          () => Task(
              id: id,
              title: task.title,
              description: task.description,
              createdAt: task.createdAt,
              done: task.done));
    }

    notifyListeners();
  }

  void remove(Task task, BuildContext context) {
    if (task != null && task.id != null && task.id.trim().isNotEmpty) {
      _items.remove(task.id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("A tarefa \"" + task.title + "\" foi removida!")));
      notifyListeners();
    }
  }
}
