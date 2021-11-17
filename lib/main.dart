// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'addView.dart';

void main() {
  runApp(const MyApp());
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
  bool isChecked = false;
  bool pressed = false;

  /*  Map<String, bool?> tasks = {
    'Write a book': false,
    'Clean': false,
    'Do dishes': false,
    'Sweep floor': false,
    'Climb Mount Everest': true,
  }; */

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
      body: _body(),
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

  _body() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          _item('Write a book'),
          _divider(),
          _item('Do Homework'),
          _divider(),
          _item('Tidy room'),
          _divider(),
          _item('Watch TV'),
          _divider(),
          _item('Nap'),
          _divider(),
          _item('Shop groceries'),
          _divider(),
          _item('Have fun'),
          _divider(),
          _item('Meditate'),
          _divider(),
        ],
      ),
    );
  }

/*   _checkItem2() {
    final List<CheckboxItem> checkboxList = [
      CheckboxItem('Test', false),
      CheckboxItem('Test', false)
    ];
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
              title: Text(checkboxList[index].text),
              value: checkboxList[index].flag,
              onChanged: (bool? value) {
                setState(() {});
              });
        });
  } */
/* 
  _checkItem() {
    return Expanded(
      child: Column(
        children: tasks.keys.map(
          (taskItem) {
            return CheckboxListTile(
              title: Text(
                taskItem,
                style: taskItem. == true 
                ? const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  
                )
                :
              ),
              value: tasks[taskItem],
              secondary: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    print(taskItem);
/*  tasks.removeWhere((key, value) => value == tasks[taskItem]);*/
                  });
                },
              ),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  tasks[taskItem] = value;
                });
              },
            );
          },
        ).toList(),
      ),
    );
  } */

  Widget _item(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
              pressed = !pressed;
            });
          },
        ),
        Expanded(
          child: Text(
            name,
            style: pressed
                ? const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough,
                  )
                : const TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.clear),
        ),
      ],
    );
  }

  _divider() {
    return const Divider(
      height: 15,
      thickness: 1,
    );
  }
}

/* class CheckboxItem {
  final String text;
  final bool flag;

  CheckboxItem(this.text, this.flag);
} */


