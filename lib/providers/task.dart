import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class Task {
  final String id;
  String description;
  DateTime dueDate;
  TimeOfDay dueTime;
  bool isDone;

  Task({
    required this.id,
    required this.description,
    required this.dueDate,
    required this.dueTime,
    this.isDone = false,
  });

  // Convert a Task object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'dueTime': dueTime.format(TimeOfDay.now()
          .toString() as BuildContext),
      'isDone': isDone,
    };
  }

  // Convert a Map object into a Task object
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      dueTime: TimeOfDay.fromDateTime(DateTime.parse(map['dueTime'])),
      isDone: map['isDone'],
    );
  }
}

class TaskProvider with ChangeNotifier {
  List<Task> _toDoList = [];

  List<Task> get itemsList {
    return _toDoList;
  }

  final _baseUrl =
      'https://your-api-endpoint.com/tasks'; // Replace with API endpoint

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/tasks.json');
  }

  Future<void> saveTasks() async {
    final file = await _localFile;
    final jsonString =
        json.encode(_toDoList.map((task) => task.toMap()).toList());
    await file.writeAsString(jsonString);
  }

  Future<void> loadTasks() async {
    try {
      final file = await _localFile;
      final jsonString = await file.readAsString();
      final jsonData = json.decode(jsonString) as List;
      _toDoList = jsonData.map((taskData) => Task.fromMap(taskData)).toList();
      notifyListeners();
    } catch (error) {
      print('Error loading tasks: $error');
    }
  }

  Future<void> fetchTasksFromAPI() async {
    final response = await http.get(Uri.parse(_baseUrl));
    final jsonData = json.decode(response.body) as List;
    _toDoList = jsonData.map((taskData) => Task.fromMap(taskData)).toList();
    notifyListeners();
  }

  Future<void> addTaskToAPI(Task task) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      body: json.encode(task.toMap()),
    );
    if (response.statusCode == 201) {
      _toDoList.add(task);
      notifyListeners();
    }
  }

  // Similarly, you can add methods to update and delete tasks using PUT and DELETE HTTP methods.
}
