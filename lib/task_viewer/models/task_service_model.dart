import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todolist/task_viewer/models/task_model.dart';

class TaskService {
  static const String baseUrl = 'http://10.0.2.2/todolist';

  static Future<Map<String, dynamic>> createTask({
    required String userId,
    required String title,
    required String description,
    required bool complete,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create_task.php'),
      body: {
        'user_id': userId,
        'title': title,
        'description': description,
        'status': complete ? '1' : '0',
      },
    );
    if (response.body.isNotEmpty) {
      print(response.body);
      return json.decode(response.body);
    } else {
      return {
        'status': 'error',
        'message': 'Server error: ${response.statusCode}',
      };
    }
  }

  static Future<Map<String, dynamic>> getTasks(String userId) async {
    print("User ID: $userId");
    final response = await http.get(
      Uri.parse('$baseUrl/get_task.php?user_id=$userId'),
    );
    print(response.body);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        List<Task> tasks = [];
        for (var taskData in responseData['data']) {
          print("Task Data: $taskData");
          tasks.add(
            Task(
              taskData['task_id'].toString(),
              taskData['title'],
              taskData['description'],
              taskData['complete'],
            ),
          );
        }
        return {
          'status': 'success',
          'tasks': tasks,
          'count': responseData['count'],
        };
      }
      return responseData;
    } else {
      return {
        'status': 'error',
        'message': 'Server error: ${response.statusCode}',
      };
    }
  }

  static Future<Map<String, dynamic>> updateTask({
    required String taskId,
    required String userId,
    required String? title,
    required String? description,
    required bool? complete,
  }) async {
    Map<String, String> body = {'task_id': taskId, 'user_id': userId};
    print("Before change: $body");

    if (title != null) {
      body['title'] = title;
    }
    if (description != null) {
      body['description'] = description;
    }
    if (complete != null) {
      body['status'] = complete ? '1' : '0';
    }
    print("After change: $body");

    final response = await http.post(
      Uri.parse('$baseUrl/update_task.php'),
      body: body,
    );

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      return {
        'status': 'error',
        'message': 'Server error: ${response.statusCode}',
      };
    }
  }

  static Future<Map<String, dynamic>> deleteTask({
    required String taskId,
    required String userId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/delete_task.php'),
      body: {'task_id': taskId, 'user_id': userId},
    );

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      return {
        'status': 'error',
        'message': 'Server error: ${response.statusCode}',
      };
    }
  }

  static Future<Map<String, dynamic>> deleteCompletedTasks(String userId) async {
      final response = await http.post(
        Uri.parse('$baseUrl/delete_completed_tasks.php'),
        body: {
          'user_id': userId,
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
      } else {
        return {
          'status': 'error',
          'message': 'Server error: ${response.statusCode}'
        };
      }
  }

  static Future<Map<String, dynamic>> deleteAllTasks(String userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/delete_all_tasks.php'),
      body: {'user_id': userId},
    );
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      return {
        'status': 'error',
        'message': 'Server error: ${response.statusCode}'
      };
    }
  }
}
