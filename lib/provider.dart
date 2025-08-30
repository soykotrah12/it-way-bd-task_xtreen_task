import 'package:flutter/material.dart';
import 'package:xtreem_task/api.dart';
import 'package:xtreem_task/task.dart';


class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  bool isLoading = false;

  // Fetch tasks from API
  Future<void> loadTasks() async {
    try {
      isLoading = true;
      notifyListeners();
      tasks = await ApiService.fetchTasks();
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Add new task
  Future<void> addTask(String title) async {
    try {
      Task newTask = await ApiService.addTask(title);
      tasks.insert(0, newTask);
      notifyListeners();
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  // Toggle task completion
  void toggleTask(int id) {
    int index = tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      tasks[index].completed = !tasks[index].completed;
      notifyListeners();
    }
  }
}
