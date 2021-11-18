// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'model.dart';

class AddView extends StatefulWidget {
  final CheckBoxState checkbox;

  AddView(this.checkbox);

  @override
  State<StatefulWidget> createState() {
    return AddViewState(checkbox);
  }
}

class AddViewState extends State<AddView> {
  late String title;

  late TextEditingController textEditingController;

  AddViewState(CheckBoxState checkbox) {
    this.title = checkbox.title;

    textEditingController = TextEditingController(text: checkbox.title);

    textEditingController.addListener(() {
      setState(() {
        title = textEditingController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Second View',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal[900],
            leading: IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left, size: 35),
            ),
            title: Center(
              child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 40),
                  child: const Text(
                    'TIG169 TODO',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  )),
            ),
          ),
          body: _writeToDo()),
    );
  }

  _writeToDo() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(35),
          child: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              hintText: 'What are you going to do?',
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pop(context, CheckBoxState(title: title));
              }),
          const Text('ADD',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ])
      ],
    );
  }
}
