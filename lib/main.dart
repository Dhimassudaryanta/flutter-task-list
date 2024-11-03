import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list/models/task.dart';
import 'package:task_list/views/addEdit_screen.dart';
import 'package:task_list/views/detail_screen.dart';
import 'package:task_list/views/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // final TaskController taskController = TaskController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // home: HomeScreen(),
      routes: {
        '/': (context) => HomeScreen(),
        '/details': (context) => DetailScreen(),
        '/addEdit': (context) => AddEditScreen(),
      },
    );
  }
}
