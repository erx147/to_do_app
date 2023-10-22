import 'package:flutter/material.dart';

import '../widgets/list.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO LIST'),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 1) {
                Navigator.of(context)
                    .pushNamed('/settings'); // Navigate to AddTaskScreen
              }

            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 1,
                child: Text('View Settings'),
              ),
              // Add more items to the menu if needed
            ],
            icon: const Icon(Icons.more_vert), // Three-dot icon
          ),
        ],
      ),
      body: const List(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed('/add-task'); // Navigate to AddTaskScreen
        },
        tooltip: 'Add a new item!',
        child: const Icon(Icons.add),
      ),
    );
  }
}