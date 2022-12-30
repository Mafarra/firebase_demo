import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/presentation/home/widgets/todo_dialoge.dart';
import 'package:firebase_demo/viewModel/home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../Utils/lists_of_data_for_test.dart';
import '../../viewModel/firebase_auth.dart';
import '../../model/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FireBaseAuth fireBaseAuth = FireBaseAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => fireBaseAuth.signOut(),
              icon: const Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: GetBuilder<HomeViewModel>(
          init: HomeViewModel(),
          builder: (logic) {
            return ListView.builder(
              itemCount: logic.todos.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green[100],
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(logic.todos[index].title ?? "no title exist"),
                    subtitle:
                        Text(logic.todos[index].description ?? "no subtitle exist"),
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTodoDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
