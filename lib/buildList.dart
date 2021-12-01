// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_first_app/model.dart';
import 'package:my_first_app/todo_model.dart';
import 'package:provider/provider.dart';

class BuildList extends StatefulWidget {
  final Todo filteredTodo;

  // ignore: use_key_in_widget_constructors
  const BuildList({required this.filteredTodo});

  @override
  State<BuildList> createState() => _BuildListState();
}

class _BuildListState extends State<BuildList> {
  @override
  Widget build(BuildContext context) {
    return _buildtodo(context, widget.filteredTodo);
  }

  Widget _buildtodo(context, Todo todo) => CheckboxListTile(
      contentPadding: const EdgeInsets.all(12.0),
      controlAffinity: ListTileControlAffinity.leading,
      value: todo.done,
      title: Text(todo.title,
          style: TextStyle(
              decoration: todo.done ? TextDecoration.lineThrough : null)),
      secondary: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            Provider.of<MyState>(context, listen: false).removeTodo(todo);
          }),
      onChanged: (value) {
        Provider.of<MyState>(context, listen: false).checkTodo(todo);
      });

  /*  : (value) => setState(
          () => todo.done = value!,
        ), ); */

}
