import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:task_list/models/task.dart';
import 'package:task_list/notifiers/task_notifier.dart'; // For JSON encoding/decoding

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchData().then((tasks) {
      context.read<TaskNotifier>().setTasks(tasks);
    });
  }

  List<Task> task = [];
  bool isListLoading = false;

  Future<List<Task>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://67283e78270bd0b97554c5cf.mockapi.io/api/v1/todos?page=1&limit=15'));
    if (response.statusCode == 200) {
      List<dynamic> jsonArray = jsonDecode(response.body);

      return jsonArray.map((json) => Task.fromJson(json)).toList();
    } else {
      // If the response was not OK, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskNotifier>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('To-Do List'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator?.pushNamed(context, '/addEdit');
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            Container(
              child: Expanded(
                child: FutureBuilder<List<Task>>(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return (SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: value.task!.length,
                        itemBuilder: (context, index) {
                          final todo = value.task![index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.teal, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              onTap: () => Navigator.pushNamed(
                                context,
                                '/details',
                                arguments: {
                                  'data': value.task![index],
                                },
                              ),
                              title: Text(todo.title),
                              trailing: Icon(
                                todo.isCompleted ? Icons.check : Icons.clear,
                                color: todo.isCompleted
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Text('No data');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
