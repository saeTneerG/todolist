import 'package:flutter/material.dart';
import 'package:todolist/views/add_task_view.dart';
import 'package:todolist/views/task_list_view.dart';

class TaskPage extends StatelessWidget {
  const TaskPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(children: [
          // Header View
          Expanded(flex: 1, child: Container(color: Colors.red)),

          // Task Info View
          Expanded(flex: 1, child: Container(color: Colors.green)),

          // Task List View
          Expanded(flex: 7, child: TaskListView()),
        
        ],),
      ),
      floatingActionButton: const AddTaskView(),
    );
  }
}
