import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todoapp/models/task.dart';
import 'package:flutter_todoapp/provider/tasks.dart';
import 'package:flutter_todoapp/routes/app_routes.dart';
import 'package:provider/provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile(this.task);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(Icons.task_alt)),
      title: Text(task.title),
      isThreeLine: true,
      dense: true,
      subtitle: Text("${task.description}. Criado em: ${task.createdAt}"),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.TASK_FORM, arguments: task);
                },
                color: Colors.blue,
                icon: Icon(Icons.edit)),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Excluir Tarefa'),
                          content:
                              Text('Tem certeza que deseja excluir a tarefa?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text('Não')),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Text('Sim'))
                          ],
                        )).then((confirmed) {
                  if (confirmed) {
                    Provider.of<Tasks>(context, listen: false)
                        .remove(task, context);
                  }
                });
              },
              color: Colors.red,
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}
