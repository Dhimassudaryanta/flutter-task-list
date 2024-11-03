import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_list/models/task.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({super.key});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  String title = '';
  String description = '';
  bool isChecked = false;

  List<Task> task = [];

  void postTasks() async {
    await postTodos();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Your data is successfully saved!'),
        duration: const Duration(milliseconds: 1500),
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16.0 // Inner padding for SnackBar content.
            ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(69.0),
        ),
      ),
    );
  }

  Future<Task> postTodos() async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'title': title,
          'body': description,
          'completed': isChecked,
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        return Task.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow;
      // throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add data'),
      ),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Is Completed ?',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        postTasks();
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
