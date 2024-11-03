import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:task_list/models/task.dart'; // For JSON encoding/decoding

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Call your function here
    fetchData();
  }

  List<Task> task = [];
  bool isListLoading = false;

  Future<List<Task>> fetchData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=15'));

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
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
                    // Use ListView to display the list of Todo items
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final todo = snapshot.data![index];
                        return ListTile(
                          onTap: () => Navigator.pushNamed(context, '/details'),
                          title: Text(todo.title),
                          trailing: Icon(
                            todo.isCompleted ? Icons.check : Icons.clear,
                            color: todo.isCompleted ? Colors.green : Colors.red,
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
    );
  }
}
