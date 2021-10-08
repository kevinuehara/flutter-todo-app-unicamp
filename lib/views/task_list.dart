import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todoapp/components/task_tile.dart';
import 'package:flutter_todoapp/provider/tasks.dart';
import 'package:flutter_todoapp/routes/app_routes.dart';
import 'package:flutter_todoapp/views/task_about.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Tasks tasks = Provider.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(children: [
          ListView.builder(
            itemCount: tasks.count,
            itemBuilder: (ctx, i) => TaskTile(tasks.byIndex(i)),
          ),
          TaskAbout()
        ]),
        appBar: AppBar(
          title: Text('Lista de tarefas'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.check_box)),
              Tab(icon: Icon(Icons.info))
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.TASK_FORM);
                },
                icon: Icon(Icons.add))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.TASK_FORM);
          },
          tooltip: 'Nova Tarefa',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
