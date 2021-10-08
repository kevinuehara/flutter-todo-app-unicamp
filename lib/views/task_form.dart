import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todoapp/models/task.dart';
import 'package:flutter_todoapp/provider/tasks.dart';
import 'package:provider/provider.dart';

class TaskForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, Object> _formData = {};

  void _loadFormData(Task? task) {
    print(task);
    if (task != null) {
      _formData['id'] = task.id;
      _formData['title'] = task.title;
      _formData['description'] = task.description;
      _formData['createdAt'] = task.createdAt;
      _formData['done'] = task.done;
    } else {
      _formData['title'] = '';
      _formData['description'] = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Task? task = ModalRoute.of(context)?.settings.arguments as Task?;
    _loadFormData(task);

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Tarefa'),
        actions: [
          IconButton(
              onPressed: () {
                final isValid = _form.currentState!.validate();
                if (isValid) {
                  _form.currentState!.save();

                  Provider.of<Tasks>(context, listen: false).put(Task(
                      id: _formData['id'].toString(),
                      title: _formData['title'].toString(),
                      description: _formData['description'].toString(),
                      createdAt: DateTime.now().toString(),
                      done: false));
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
                decoration: InputDecoration(labelText: 'Título da Tarefa'),
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
                onSaved: (value) => _formData['description'] = value.toString(),
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

            Provider.of<Tasks>(context, listen: false).put(Task(
                id: _formData['id'].toString(),
                title: _formData['title'].toString(),
                description: _formData['description'].toString(),
                createdAt: DateTime.now().toString(),
                done: false));
            Navigator.of(context).pop();
          }
        },
        tooltip: 'Salvar Tarefa',
        child: Icon(Icons.save),
      ),
    );
  }
}
