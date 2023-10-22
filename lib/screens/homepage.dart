import 'package:flutter/material.dart';
import 'package:to_do_app/screens/settingsScreen.dart';
import 'addTaskScreen.dart'; // Import the AddTaskScreen

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Settings') {
                Navigator.of(context).pushNamed('/settings');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings'),
              ),
            ],
            icon: Icon(Icons.more_vert), // This is the three-dot icon
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
