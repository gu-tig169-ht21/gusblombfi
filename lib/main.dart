// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addView.dart';
import 'model.dart';

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
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_sharp, size: 35))
        ],
      ),
      body: Consumer<MyState>(builder: (context, state, child) {
        return ListView(children: <Widget>[
          ...state.list.map(_buildCheckbox).toList(),
        ]);
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
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

  Widget _buildCheckbox(CheckBoxState checkbox) => CheckboxListTile(
        contentPadding: const EdgeInsets.all(12.0),
        controlAffinity: ListTileControlAffinity.leading,
        value: checkbox.value,
        title: Text(checkbox.title,
            style: TextStyle(
                decoration:
                    checkbox.value ? TextDecoration.lineThrough : null)),
        secondary: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              Provider.of<MyState>(context, listen: false).removeBox(checkbox);
            }),
        onChanged: (value) => setState(
          () => checkbox.value = value!,
        ),
      );

  _divider() {
    return const Divider(
      height: 15,
      thickness: 1,
    );
  }
}
