import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_first_app/todo_model.dart';

var URL =
    "https://todoapp-api-pyq5q.ondigitalocean.app/todos/?key=503e94e7-1781-463d-bd6a-38522d2a3b55";

class Api {
  static getTodos() async {
    final List<Todo> todoList = [];
    try {
      http.Response response = await http.get(Uri.parse(URL));
      if (response.statusCode == 200) {
        final List responseObject = jsonDecode(response.body);
        responseObject.forEach((element) {
          final Todo todoItem = Todo.fromJson(element);
          todoList.add(todoItem);
        });
        return todoList;
      }
    } catch (e) {
      print(e);
    }
  }

  static /*Future<List<Todo>?>*/ deleteTodo(String id) async {
    final List<Todo> todoList = [];
    http.Response response = await http.delete(Uri.parse(
        'https://todoapp-api-pyq5q.ondigitalocean.app/todos/$id?key=503e94e7-1781-463d-bd6a-38522d2a3b55'));

    if (response.statusCode == 200) {
      final List responseObject = jsonDecode(response.body);
      responseObject.forEach((element) {
        final Todo todoItem = Todo.fromJson(element);
        todoList.add(todoItem);
      });
      return todoList;
    }
  }

  static /*Future*/ checkTodo(Todo todo, id) async {
    final List<Todo> todoList = [];

    var json = todo.toJson();
    var bodyString = jsonEncode(json);

    http.Response response = await http.put(
        Uri.parse(
            'https://todoapp-api-pyq5q.ondigitalocean.app/todos/$id?key=503e94e7-1781-463d-bd6a-38522d2a3b55'),
        body: bodyString,
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final List responseObject = jsonDecode(response.body);

      responseObject.forEach((element) {
        final Todo todoItem = Todo.fromJson(element);
        todoList.add(todoItem);
      });
      return todoList;
    }
  }

  static addTodo(String title) async {
    print(title);
    final List<Todo> todoList = [];

    http.Response response = await http.post(
      Uri.parse(URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "title": title,
      }),
    );

    if (response.statusCode == 200) {
      final List responseObject = jsonDecode(response.body);

      responseObject.forEach((element) {
        final Todo todoItem = Todo.fromJson(element);
        todoList.add(todoItem);
      });
      return todoList;
    }
  }
}

/* 
   static Future updateTodo(TodoModel todo, todoId) async {
    var json = todo.toJson();
    var bodyString = jsonEncode(json);

    var response = await http.put('$API_URL/todos/$todoId?key=$API_KEY',
        body: bodyString, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return response;
    } else {
      print('error on update');
      return null;
    }
  } */





// API DELETE: https://todoapp-api-pyq5q.ondigitalocean.app/todos/$id?key=503e94e7-1781-463d-bd6a-38522d2a3b55

