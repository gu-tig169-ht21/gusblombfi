// ignore_for_file: file_names

import 'package:flutter/material.dart';

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

  void addTodo(CheckBoxState checkbox) {
    _list.add(checkbox);
    notifyListeners();
  }
}

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({
    required this.title,
    this.value = false,
  });
}
