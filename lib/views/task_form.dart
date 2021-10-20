import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todoapp/models/task_db.dart';
import 'package:flutter_todoapp/provider/tasks/task_bloc.dart';
import 'package:flutter_todoapp/provider/tasks/task_event.dart';
import 'package:flutter_todoapp/provider/tasks/task_state.dart';

class TaskForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, Object> _formData = {};

  bool isToUpdate = false;

  void _loadFormData(TaskDB? task) {
    print(task);
    if (task != null) {
      _formData['id'] = task.id.toString();
      _formData['title'] = task.title.toString();
      _formData['description'] = task.description.toString();
      _formData['createdAt'] = task.createdAt.toString();
      _formData['done'] = task.done.toString();
      this.isToUpdate = true;
    } else {
      _formData['title'] = '';
      _formData['description'] = '';
      this.isToUpdate = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TaskDB? task = ModalRoute.of(context)?.settings.arguments as TaskDB?;
    _loadFormData(task);

    return BlocBuilder<TaskBloc, TaskState>(
        bloc: BlocProvider.of<TaskBloc>(context),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Criar Tarefa'),
              actions: [
                IconButton(
                    onPressed: () {
                      final isValid = _form.currentState!.validate();
                      if (isValid) {
                        _form.currentState!.save();
                        bool done =
                            (_formData['done'] == 'true') ? true : false;

                        TaskDB task = new TaskDB(
                            _formData['id'].toString(),
                            _formData['title'].toString(),
                            _formData['description'].toString(),
                            DateTime.now().toString(),
                            done);

                        if (!this.isToUpdate) {
                          BlocProvider.of<TaskBloc>(context)
                              .add(CreateTaskEvent(task: task));
                        } else {
                          BlocProvider.of<TaskBloc>(context).add(
                              UpdateTaskEvent(
                                  id: int.parse(_formData['id'].toString()),
                                  task: task));
                        }

                        Navigator.of(context).pop();
                      }
                    },
                    icon: Icon(Icons.save))
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _formData['title'].toString(),
                      decoration:
                          InputDecoration(labelText: 'Título da Tarefa'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'O campo é obrigatório';
                        }

                        return null;
                      },
                      onSaved: (value) => _formData['title'] = value.toString(),
                    ),
                    TextFormField(
                      initialValue: _formData['description'].toString(),
                      decoration: InputDecoration(labelText: 'Descrição'),
                      onSaved: (value) => {
                        _formData['description'] = value.toString(),
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Os dados da tarefa \"" +
                                _formData['title'].toString() +
                                "\" foram salvos!")))
                      },
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                final isValid = _form.currentState!.validate();
                if (isValid) {
                  _form.currentState!.save();
                  bool done = (_formData['done'] == 'true') ? true : false;

                  TaskDB task = new TaskDB(
                      _formData['id'].toString(),
                      _formData['title'].toString(),
                      _formData['description'].toString(),
                      DateTime.now().toString(),
                      done);

                  if (!this.isToUpdate) {
                    BlocProvider.of<TaskBloc>(context)
                        .add(CreateTaskEvent(task: task));
                  } else {
                    BlocProvider.of<TaskBloc>(context).add(UpdateTaskEvent(
                        id: int.parse(_formData['id'].toString()), task: task));
                  }

                  BlocProvider.of<TaskBloc>(context).add(FetchTaskList());
                  Navigator.of(context).pop();
                }
              },
              tooltip: 'Salvar Tarefa',
              child: Icon(Icons.save),
            ),
          );
        });
  }
}
