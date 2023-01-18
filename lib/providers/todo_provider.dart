import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class TodoProvider extends ChangeNotifier {
  TodoProvider() {
    todos = filterdTodos;
  }

  List<Todo> todos = [];
  List<Todo> filterdTodos = [];

  void searchFilter(String searchKey) {
    if (searchKey.isEmpty || searchKey == "") {
      filterdTodos = todos;
    } else {
      filterdTodos = todos
          .where((task) =>
              task.todoText.toLowerCase().contains(searchKey.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void addTodo({required Todo todo}) {
    todos.add(todo);
    notifyListeners();
  }

  void deleteTodo({required Todo currentTodo}) {
    todos.removeWhere((todo) => todo.id == currentTodo.id);
    notifyListeners();
  }

  void checkIfTaskComplete(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }
}
