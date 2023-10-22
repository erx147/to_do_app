import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/providers/task.dart';
import 'package:flutter/material.dart';



void main() {
  final taskProvider = TaskProvider();

  group('TaskProvider Tests', () {
    test('Add a new task', () {
      final newTask = Task(
        id: '1',
        description: 'Test Task',
        dueDate: DateTime.now(),
        dueTime: TimeOfDay.now(),
      );
      taskProvider.addNewTask(newTask);
      expect(taskProvider.itemsList.length, 1);
      expect(taskProvider.itemsList[0].description, 'Test Task');
    });

    test('Edit an existing task', () {
      final updatedTask = Task(
        id: '1',
        description: 'Updated Test Task',
        dueDate: DateTime.now(),
        dueTime: TimeOfDay.now(),
      );
      taskProvider.editTask(updatedTask);
      expect(taskProvider.itemsList[0].description, 'Updated Test Task');
    });

    test('Get a task by its ID', () {
      final task = taskProvider.getById('1');
      expect(task.description, 'Updated Test Task');
    });

    test('Change the status of a task', () {
      taskProvider.changeStatus('1', true);
      expect(taskProvider.getById('1').isDone, true);
    });

    test('Remove a task by its ID', () {
      taskProvider.removeTask('1');
      expect(taskProvider.itemsList.length, 0);
    });
  });
}
