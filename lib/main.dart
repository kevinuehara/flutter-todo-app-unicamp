import 'package:flutter/material.dart';
import 'package:flutter_todoapp/provider/tasks.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Tasks(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.HOME: (_) => TaskList(),
          AppRoutes.TASK_FORM: (_) => TaskForm()
        },
      ),
    );
  }
}
