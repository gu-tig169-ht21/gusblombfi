// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

List<Todo> todoFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todoToJson(List<Todo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.done,
  });

  String id;
  String title;
  bool done;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        done: json["done"] == null ? null : json["done"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "done": done == null ? null : done,
      };
}
