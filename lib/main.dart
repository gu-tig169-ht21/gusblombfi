// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:my_first_app/api.dart';
import 'package:my_first_app/todo_model.dart';
import 'package:provider/provider.dart';
import 'add_view.dart';
import 'buildList.dart';
import 'model.dart';

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
      home: const MyHomePage(title: 'TIG169 TODO', todoList: []),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.todoList})
      : super(key: key);

  final String title;
  final List<Todo> todoList;

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
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _content(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[900],
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 55,
        ),
        onPressed: () async {
          String? todoTitle = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddView()));
          if (todoTitle != null) {
            Provider.of<MyState>(context, listen: false).addTodo(todoTitle);
          }
        },
      ),
    );
  }

  List<TodoState> _filterList(List<TodoState> list, String filterBy) {
    List<TodoState> filteredList = [];
    filteredList.clear();

    if (filterBy == "Done") {
      list.forEach((TodoState element) {
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
    return Consumer<MyState>(builder: (context, state, child) {
      if (state.list.isEmpty) {
        return _futureBuilder();
      } else {
        return _listView(todolist: state.list);
      }
    });
/*     _futureBuilder(); */
  }

  _findToDo() async {
    List<Todo> todoList = await Api.getTodos();
    todoList.forEach((Todo element) {
      element.title;
    });

    return todoList;
  }

  _futureBuilder() {
    return FutureBuilder(
      future: _findToDo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _listView(todolist: snapshot.data);
        }
        return const CircularProgressIndicator();
      },
    );
  }

  _listView({required todolist}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: todolist.isEmpty ? 1 : todolist.length,
      itemBuilder: (context, index) {
        if (todolist.isEmpty) {
          return Container(child: const Text('Funkade sådär'));
        }
        print(todolist[index]);
        return BuildList(filteredTodo: todolist[index]);
      },
    );
  }
  //TODO: Lägg till future builder och sen listvirew builder
}
