// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addView.dart';
import 'model.dart';
import 'buildList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// API-Key: 503e94e7-1781-463d-bd6a-38522d2a3b55
// API-LÄNK: https://todoapp-api-pyq5q.ondigitalocean.app/todos?key=503e94e7-1781-463d-bd6a-38522d2a3b55

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
    ///Size of the entire screen.
    final Size size = MediaQuery.of(context).size;
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
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _content(),
          ],
        ),
      ),
      /* Consumer<MyState>(
          builder: (context, state, child) =>
              BuildList(filterList: _filterList(state.list, state.filterBy))), */
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

  Widget _content() {
    return ElevatedButton(
        child: Text('Hej'),
        onPressed: () {
          _findToDo();
        });
  }

  void _findToDo() async {
    var result = await _fetchToDo();
    print(result);
  }

  Future<String> _fetchToDo() async {
    http.Response response = await http.get(Uri.parse(
        'https://todoapp-api-pyq5q.ondigitalocean.app/todos?key=503e94e7-1781-463d-bd6a-38522d2a3b55'));
    var jsonData = response.body;
    var obj = jsonDecode(jsonData);
    for (int i = 0; i < obj.length; i++) {
      var fetchedToDo = obj[i]['title'];
      return fetchedToDo;
    }
    return obj[0]['title'];
  }
}
