import 'dart:convert';
import 'package:xtreem_task/task.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/todos";

  // Fetch tasks
  static Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load tasks");
    }
  }

  // Add new task
  static Future<Task> addTask(String title) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode({"title": title, "completed": false}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 201) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to add task");
    }
  }
}
