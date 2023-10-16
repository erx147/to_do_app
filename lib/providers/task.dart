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
}

class TaskProvider with ChangeNotifier {
  List<Task> _toDoList = [];

  List<Task> get itemsList {
    return _toDoList;
  }

  final _baseUrl =
      'https://your-api-endpoint.com/tasks'; // Replace with your API endpoint

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/tasks.json');
  }

  Future<void> saveTasks() async {
    final file = await _localFile;
    final jsonString = json.encode(_toDoList
        .map((task) => {
              'id': task.id,
              'description': task.description,
              'dueDate': task.dueDate.toIso8601String(),
              'dueTime': task.dueTime.format(TimeOfDay.now()
                  .toString() as BuildContext), // Assuming you have a BuildContext available
              'isDone': task.isDone,
            })
        .toList());
    await file.writeAsString(jsonString);
  }

  Future<void> loadTasks() async {
    try {
      final file = await _localFile;
      final jsonString = await file.readAsString();
      final jsonData = json.decode(jsonString) as List;
      _toDoList = jsonData
          .map((taskData) => Task(
                id: taskData['id'],
                description: taskData['description'],
                dueDate: DateTime.parse(taskData['dueDate']),
                dueTime:
                    TimeOfDay.fromDateTime(DateTime.parse(taskData['dueTime'])),
                isDone: taskData['isDone'],
              ))
          .toList();
      notifyListeners();
    } catch (error) {
      print('Error loading tasks: $error');
    }
  }

  Future<void> fetchTasksFromAPI() async {
    final response = await http.get(Uri.parse(_baseUrl));
    final jsonData = json.decode(response.body) as List;
    _toDoList = jsonData
        .map((taskData) => Task(
              id: taskData['id'],
              description: taskData['description'],
              dueDate: DateTime.parse(taskData['dueDate']),
              dueTime:
                  TimeOfDay.fromDateTime(DateTime.parse(taskData['dueTime'])),
              isDone: taskData['isDone'],
            ))
        .toList();
    notifyListeners();
  }

  // Add a new task to the list
  void AddNewTask(Task task) {
    _toDoList.add(task);
    notifyListeners();
    // Optionally, save to file or API here
  }

  // Edit an existing task
  void editTask(Task updatedTask) {
    final taskIndex = _toDoList.indexWhere((task) => task.id == updatedTask.id);
    if (taskIndex >= 0) {
      _toDoList[taskIndex] = updatedTask;
      notifyListeners();
      // Optionally, save to file or API here
    }
  }

  // Get a task by its ID
  Task getById(String id) {
    return _toDoList.firstWhere((task) => task.id == id);
  }

  // Change the status of a task
  void changeStatus(String taskId, bool newStatus) {
    final taskIndex = _toDoList.indexWhere((task) => task.id == taskId);
    if (taskIndex >= 0) {
      _toDoList[taskIndex].isDone = newStatus;
      notifyListeners();
      // Optionally, save to file or API here
    }
  }

  // Remove a task by its ID
  void removeTask(String taskId) {
    _toDoList.removeWhere((task) => task.id == taskId);
    notifyListeners();
    // Optionally, save to file or API here
  }
}
