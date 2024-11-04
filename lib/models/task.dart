import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Task {
  int id;
  String title;
  String description;
  bool isCompleted;

  Task({
    this.id = 1,
    this.title = '',
    this.description = '',
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['userId'] as int,
      title: json['title'],
      description: json['description'],
      isCompleted: json['completed'],
    );
  }
}
