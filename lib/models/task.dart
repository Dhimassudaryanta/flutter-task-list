import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Task {
  int id;
  String title;
  bool isCompleted;

  Task({
    this.id = 1,
    this.title = '',
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['userId'],
      title: json['title'],
      isCompleted: json['completed'],
    );
  }
}

class TaskNotifier with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get task => _tasks;

  void addTask(Task task) {
    print(task);
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void setTasks(List<Task> tasks) {
    _tasks = tasks;
    notifyListeners();
  }
}
