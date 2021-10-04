import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todoapp/components/task_tile.dart';
import 'package:flutter_todoapp/models/task.dart';
import 'package:flutter_todoapp/provider/tasks.dart';
import 'package:flutter_todoapp/routes/app_routes.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  const TaskList({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Tasks tasks = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tarefas'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.TASK_FORM);
            }, 
            icon: Icon(Icons.add)
          )
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.count,
        itemBuilder: (ctx, i) => TaskTile(tasks.byIndex(i)),
      ),
    );
  }
}