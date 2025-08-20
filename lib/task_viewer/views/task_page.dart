import 'package:flutter/material.dart';

import 'add_task_view.dart';
import 'header_view.dart';
import 'task_info_view.dart';
import 'task_list_view.dart';

class TaskPage extends StatelessWidget {
  const TaskPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Column(children: [
          // Header View
          Expanded(flex: 1, child: HeaderView()),

          // Task Info View
          Expanded(flex: 1, child: TaskInfoView()),

          // Task List View
          Expanded(flex: 7, child: TaskListView()),
        ],),
      ),
      floatingActionButton: const AddTaskView(),
    );
  }
}
