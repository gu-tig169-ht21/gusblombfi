// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addView.dart';
import 'model.dart';
import 'buildList.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo TIG169',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'TIG169 TODO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[900],
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.w300, color: Colors.white),
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('All'), value: 'All'),
              const PopupMenuItem(child: Text('Done'), value: 'Done'),
              const PopupMenuItem(child: Text('Undone'), value: 'Undone')
            ],
            onSelected: (String value) {
              Provider.of<MyState>(context, listen: false).filter(value);
            },
          )
        ],
      ),
      body: Consumer<MyState>(
          builder: (context, state, child) =>
              BuildList(filterList: _filterList(state.list, state.filterBy))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[900],
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 55,
        ),
        onPressed: () async {
          var newToDo = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddView(CheckBoxState(
                        title: '',
                      ))));
          if (newToDo != null) {
            Provider.of<MyState>(context, listen: false).addTodo(newToDo);
          }
        },
      ),
    );
  }

  List<CheckBoxState> _filterList(List<CheckBoxState> list, String filterBy) {
    List<CheckBoxState> filteredList = [];
    filteredList.clear();

    if (filterBy == "Done") {
      list.forEach((CheckBoxState element) {
        if (element.value == true) {
          filteredList.add(element);
        }
      });
      return filteredList;
      // return list.where((checkbox) => checkbox.value == true).toList();
    }

    if (filterBy == "Undone") {
      for (var element in list) {
        if (element.value == false) {
          filteredList.add(element);
        }
      }
      return filteredList;
      //return list.where((checkbox) => checkbox.value == false).toList();
    }

    ///If [filterBy] is not 'done' or 'undone' return the entire list unfiltered.
    return list;
  }
}
