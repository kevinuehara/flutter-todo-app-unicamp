import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todoapp/components/task_tile.dart';
import 'package:flutter_todoapp/provider/tasks/task_bloc.dart';
import 'package:flutter_todoapp/provider/tasks/task_event.dart';
import 'package:flutter_todoapp/provider/tasks/task_state.dart';
import 'package:flutter_todoapp/routes/app_routes.dart';
import 'package:flutter_todoapp/views/task_about.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
        bloc: BlocProvider.of<TaskBloc>(context)..add(FetchTaskList()),
        builder: (context, state) {
          // Fetch Tasks success
          if (state is TaskStateLoaded && state.tasks != null) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                body: TabBarView(children: [
                  ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (ctx, i) => TaskTile(state.tasks[i]),
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
                          Navigator.of(context)
                              .pushNamed(AppRoutes.TASK_FORM)
                              .then((_) => BlocProvider.of<TaskBloc>(context)
                                  .add(FetchTaskList()));
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.TASK_FORM).then(
                        (_) => BlocProvider.of<TaskBloc>(context)
                            .add(FetchTaskList()));
                  },
                  tooltip: 'Nova Tarefa',
                  child: Icon(Icons.add),
                ),
              ),
            );
          }
          if (state is UpdateTaskState) {
            BlocProvider.of<TaskBloc>(context).add(FetchTaskList());
          }

          return Container();
        });
  }
}
