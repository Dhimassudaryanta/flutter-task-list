import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_list/models/task.dart';

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
