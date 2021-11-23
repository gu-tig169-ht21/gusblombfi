// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_first_app/api.dart';
import 'package:my_first_app/todo_model.dart';

class MyState extends ChangeNotifier {
  List<Todo> _list = [];
  List<Todo> get list => _list;

  String _filterBy = 'All';
  String get filterBy => _filterBy;

  void checkTodo(Todo todo) async {
    todo.done = !todo.done;
    List<Todo>? newList = await Api.checkTodo(todo, todo.id);
    notifyListeners();
  }

  void removeTodo(Todo todo) async {
    try {
      List<Todo>? newList = await Api.deleteTodo(todo.id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void addTodo(String title) async {
    _list = await Api.addTodo(title);
    notifyListeners();
  }

  void filter(String filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }
}

class TodoState {
  final String title;
  bool value;

  TodoState({
    required this.title,
    this.value = false,
  });
}
