import 'package:firebase_demo/Utils/lists_of_data_for_test.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/todo_model.dart';

class HomeViewModel extends GetxController {
  List<Todo> todos = [
    Todo(title: 'Todo 1', description: 'Description 1'),
    Todo(title: 'Todo 2', description: 'Description 2'),
    Todo(title: 'Todo 3', description: 'Description 3'),
  ];

  @override
  void onInit() {
    getNotesLists();
    super.onInit();
  }

  getNotesLists() {
    update();
    return todos;
  }
}
