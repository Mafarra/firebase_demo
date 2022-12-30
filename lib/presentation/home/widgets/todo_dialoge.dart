import 'dart:developer';

import 'package:firebase_demo/viewModel/home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../Utils/lists_of_data_for_test.dart';
import '../../../model/todo_model.dart';

class AddTodoDialog extends StatefulWidget {
  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Todo'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) => _title = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
              onSaved: (value) => _description = value,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        GetBuilder<HomeViewModel>(
            init: HomeViewModel(),
            builder: (logic) {
              return TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    logic.todos
                        .add(Todo(title: _title, description: _description));
                    logic.update();
                    Navigator.of(context).pop();
                  }
                  setState(() {});
                },
                child: const Text('Add'),
              );
            }),
      ],
    );
  }
}



//This code creates a form for adding a new todo note, with fields for the title and description. When the user clicks the 'Add' button, the form is validated and the new todo note is added to the list of todos.




