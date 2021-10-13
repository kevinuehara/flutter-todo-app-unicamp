import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todoapp/provider/tasks.dart';
import 'package:flutter_todoapp/provider/tasks/task_bloc.dart';
import 'package:flutter_todoapp/provider/tasks/task_event.dart';
import 'package:flutter_todoapp/provider/tasks/task_state.dart';
import 'package:flutter_todoapp/routes/app_routes.dart';
import 'package:flutter_todoapp/views/task_form.dart';
import 'package:flutter_todoapp/views/task_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => TaskBloc(TaskLoadingState())..add(FetchTaskList()))],
        child: TaskList(),
      )
      /*routes: {
        AppRoutes.HOME: (_) => TaskList(),
        AppRoutes.TASK_FORM: (_) => TaskForm()
      },*/
    );
  }
}
