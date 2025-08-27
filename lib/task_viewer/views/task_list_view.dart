import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/app_view_model.dart';

import '../models/task_service_model.dart';
import 'task_detail_page.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  void initState() {
    super.initState();
    loadTasks();
  }
  Future<void> loadTasks() async {
    final viewModel = Provider.of<AppViewModel>(context, listen: false);
    await viewModel.loadTasks();
    print("Task Load!");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          decoration: BoxDecoration(
            color: viewModel.colorLevel2,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(15),
            separatorBuilder: (context, index) {
              return SizedBox(height: 15);
            },
            itemCount: viewModel.numTask,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  TaskService.deleteTask(
                    taskId: viewModel.tasks[index].taskId,
                    userId: viewModel.user.userId,
                  );
                  viewModel.deleteTask(index);
                },
                background: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(Icons.delete, color: Colors.red.shade700),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: viewModel.colorLevel1,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: BorderSide(
                        width: 2,
                        color: viewModel.colorLevel3,
                      ),
                      checkColor: viewModel.colorLevel1,
                      activeColor: viewModel.colorLevel3,
                      value: viewModel.getTaskValue(index),
                      onChanged: (value) {
                        TaskService.updateTask(
                          taskId: viewModel.tasks[index].taskId,
                          userId: viewModel.user.userId,
                          title: null,
                          description: null,
                          complete: value,
                        );
                        viewModel.setTaskValue(index, value!);
                      },
                    ),
                    title: Text(
                      viewModel.getTaskTitle(index),
                      style: TextStyle(
                        color: viewModel.colorLevel4,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TaskDetailPage(
                            index: index,
                            initialTitle: viewModel.getTaskTitle(index),
                            initialDesc: viewModel.getTaskDescription(
                              index,
                            ),
                            initialValue: viewModel.getTaskValue(index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
