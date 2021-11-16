import 'package:flutter/material.dart';

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
        primarySwatch: Colors.grey,
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
  /* void _incrementCounter() {
    setState(() {
      _counter++;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
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
            return const MySecondView();
          }));
        },
        tooltip: 'Increment',
        backgroundColor: Colors.grey[400],
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
          _doneItem('Tidy room'),
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

  Widget _item(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.crop_square_sharp),
        ),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
            textAlign: TextAlign.left,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.clear),
        ),
      ],
    );
  }

  Widget _doneItem(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.check_box_outlined),
        ),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.lineThrough,
            ),
            textAlign: TextAlign.left,
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

//**********  2:A SIDAN  **********

class MySecondView extends StatelessWidget {
  const MySecondView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Second View',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
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
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
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
          child: const TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              hintText: 'What are you going to do?',
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Icon(Icons.add),
          Text('ADD',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ]),
      ],
    );
  }
}
