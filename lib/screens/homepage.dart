import 'package:flutter/material.dart';
import 'addTaskScreen.dart'; // Import the AddTaskScreen

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO LIST'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to AddTaskScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(), // Empty container as the body
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddTaskScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        tooltip: 'Add a new item!',
        child: const Icon(Icons.add),
      ),
    );
  }
}
