import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todolist/task_viewer/models/task_model.dart';

class TaskService {
  static const String baseUrl = 'http://10.0.2.2/todolist';

  static Future<void> createTask({
    required String userId,
    required String title,
    required String description,
    bool complete = false,
  }) async {
    await http.post(
      Uri.parse('$baseUrl/create_task.php'),
      body: {
        'user_id': userId,
        'title': title,
        'description': description,
        'status': complete ? '1' : '0',
      },
    );
  }

  static Future<void> getTasks(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/get_tasks.php?user_id=$userId'),
    );
    var responseData = json.decode(response.body);
    if (responseData['status'] == 'success') {
      List<Task> tasks = [];
      for (var taskData in responseData['data']) {
        tasks.add(
          Task(
            taskData['title'],
            taskData['description'],
            taskData['complete'],
            taskData['task_id'],
          ),
        );
      }
    }
  }

  static Future<void> updateTask({
    required String taskId,
    required String userId,
    String? title,
    String? description,
    bool? complete,
  }) async {
    Map<String, String> body = {'task_id': taskId, 'user_id': userId};

    if (title != null) body['title'] = title;
    if (description != null) body['description'] = description;
    if (complete != null) body['status'] = complete ? '1' : '0';

    await http.post(Uri.parse('$baseUrl/update_task.php'), body: body);
  }

  static Future<void> deleteTask({
    required String taskId,
    required String userId,
  }) async {
    await http.post(
      Uri.parse('$baseUrl/delete_task.php'),
      body: {'task_id': taskId, 'user_id': userId},
    );
  }

  static Future<void> deleteCompletedTasks(String userId) async {
    await http.post(
      Uri.parse('$baseUrl/delete_completed_tasks.php'),
      body: {'user_id': userId},
    );
  }

  static Future<void> deleteAllTasks(String userId) async {
    await http.post(
      Uri.parse('$baseUrl/delete_all_tasks.php'),
      body: {'user_id': userId},
    );
  }
}
