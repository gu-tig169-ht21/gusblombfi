// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_first_app/model.dart';
import 'package:provider/provider.dart';

class BuildList extends StatefulWidget {
  final List<CheckBoxState> filterList;

  const BuildList({required this.filterList});

  @override
  State<BuildList> createState() => _BuildListState();
}

class _BuildListState extends State<BuildList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.filterList
            .map((checkbox) => _buildCheckbox(context, checkbox))
            .toList());
  }

  Widget _buildCheckbox(context, CheckBoxState checkbox) => CheckboxListTile(
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
}
