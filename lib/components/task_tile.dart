import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todoapp/models/task_db.dart';
import 'package:flutter_todoapp/provider/tasks/task_bloc.dart';
import 'package:flutter_todoapp/provider/tasks/task_event.dart';
import 'package:flutter_todoapp/routes/app_routes.dart';

class TaskTile extends StatefulWidget {
  final TaskDB task;

  const TaskTile(this.task);

  @override
  State<StatefulWidget> createState() => _TaskTileState();
}

@override
class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Icon(Icons.task_alt)),
      title:
          Text(widget.task.title != null ? widget.task.title! : "Sem título"),
      isThreeLine: true,
      dense: true,
      subtitle: Text(
          "${widget.task.description}. Criado em: ${widget.task.createdAt}"),
      trailing: Container(
        width: 144,
        child: Row(
          children: [
            Checkbox(
              value: widget.task.done,
              onChanged: (bool? value) {
                setState(() {
                  widget.task.done = value;
                  BlocProvider.of<TaskBloc>(context).add(UpdateTaskList(
                      id: widget.task.id,
                      task: widget.task));
                });
              },
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.TASK_FORM, arguments: widget.task)
                      .then((_) => BlocProvider.of<TaskBloc>(context)
                          .add(FetchTaskList()));
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
                    BlocProvider.of<TaskBloc>(context)
                        .add(DeleteTaskEvent(id: widget.task.id!));
                    BlocProvider.of<TaskBloc>(context).add(FetchTaskList());
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
