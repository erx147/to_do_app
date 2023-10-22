import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task.dart'; // Ensure this import path is correct

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _saveTask(BuildContext context) {
    final taskDescription = _taskController.text;

    if (taskDescription.isEmpty) {
      // Optionally, show a message to the user that the task cannot be empty
      return;
    }

    // Create a new task
    final newTask = Task(
      id: DateTime.now().toString(),
      description: taskDescription,
      dueDate: DateTime.now(), // You can adjust this as needed
      dueTime: TimeOfDay.now(), // You can adjust this as needed
    );

    // Add the task using the provider
    Provider.of<TaskProvider>(context, listen: false).addNewTask(newTask);

    // Pop back to the homepage
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveTask(context),
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
