import 'package:flutter/material.dart';
import '../task_viewer/models/task_model.dart';
import '../task_viewer/models/task_service_model.dart';
import '../task_viewer/models/user_model.dart';

class AppViewModel extends ChangeNotifier {
  List<Task> tasks = <Task>[];
  User user = User("", "user", "");

  Color colorLevel1 = Colors.grey.shade50;
  Color colorLevel2 = Colors.grey.shade200;
  Color colorLevel3 = Colors.grey.shade800;
  Color colorLevel4 = Colors.grey.shade900;

  int get numTask => tasks.length;

  int get numTasksRemaining => tasks.where((task) => !task.complete).length;

  String get username => user.username;

  void addTask(Task newTask) {
    tasks.add(newTask);
    notifyListeners();
  }

  bool getTaskValue(int taskIndex) {
    return tasks[taskIndex].complete;
  }

  String getTaskTitle(int taskIndex) {
    return tasks[taskIndex].title;
  }

  String getTaskDescription(int taskIndex) {
    return tasks[taskIndex].description;
  }

  void setTaskValue(int taskIndex, bool taskValue) {
    tasks[taskIndex].complete = taskValue;
    notifyListeners();
  }

  void setUserData({
    required String userId,
    required String username,
    required String email,
}) {
    user.userId = userId;
    user.username = username;
    user.email = email;
    notifyListeners();
  }

  void clearUserData() {
    user = User("","user", "");
    tasks.clear();
    notifyListeners();
  }

  Future<void> loadUserData() async {
    final userData = await User.getUserData();
    if (userData != null) {
      user.userId = userData['userId'] ?? "";
      user.username = userData['username'] ?? "user";
      user.email = userData['email'] ?? "";
    }
    notifyListeners();
  }

  Future<void> loadTasks() async {
    final tasksData = await TaskService.getTasks(user.userId);
    print("Task Data: $tasksData");
    if (tasksData['status'] == 'success') {
      tasks.clear();
      tasks.addAll(tasksData['tasks']);
    }
    notifyListeners();
  }

  void deleteTask(int taskIndex) {
    tasks.removeAt(taskIndex);
    notifyListeners();
  }

  void deleteAllTasks() {
    tasks.clear();
    notifyListeners();
  }

  void deleteCompletedTasks() {
    tasks.removeWhere((task) => task.complete);
    notifyListeners();
  }

  void updateTask(int taskIndex, String newTaskTitle, String newTaskDescription){
    tasks[taskIndex].title = newTaskTitle;
    tasks[taskIndex].description = newTaskDescription;
    notifyListeners();
  }

  void bottomSheetBuilder(Widget bottomSheetView, BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: ((context) {
          return bottomSheetView;
        }));
  }
}