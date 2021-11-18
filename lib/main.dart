// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addView.dart';

class MyState extends ChangeNotifier {
  final List<CheckBoxState> _list = [
    CheckBoxState(title: 'Read a book'),
    CheckBoxState(title: 'Do homework'),
    CheckBoxState(title: 'Tidy room'),
    CheckBoxState(title: 'Have fun'),
    CheckBoxState(title: 'Meditate'),
  ];

  List<CheckBoxState> get list => _list;

  void removeBox(CheckBoxState checkbox) {
    _list.remove(checkbox);
    notifyListeners();
  }

  /* void addToDo(CheckBoxState checkbox) {
    _list.add(checkbox);
  } */
}

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({
    required this.title,
    this.value = false,
  });
}

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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddView();
          }));
        },
        tooltip: 'Increment',
        backgroundColor: Colors.teal[900],
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 55,
        ),
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
              var state = Provider.of<MyState>(context, listen: false);
              state.removeBox(checkbox); //ta bort kort
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
