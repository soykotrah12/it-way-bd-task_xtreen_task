import 'package:flutter/material.dart';
import 'package:xtreem_task/task.dart';
import 'package:xtreem_task/provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Task Manager"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: taskProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : taskProvider.tasks.isEmpty
          ? Center(
        child: Text(
          "No tasks available. Add one!",
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: taskProvider.tasks.length,
        itemBuilder: (context, index) {
          final task = taskProvider.tasks[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Icon(
                task.completed
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: task.completed ? Colors.green : Colors.grey,
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  decoration: task.completed
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color:
                  task.completed ? Colors.grey[600] : Colors.black,
                ),
              ),
              trailing: Checkbox(
                activeColor: Colors.deepPurple,
                value: task.completed,
                onChanged: (_) => taskProvider.toggleTask(task.id),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        icon: Icon(Icons.add),
        label: Text("New Task"),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Text("Add New Task"),
              content: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Enter task name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              actions: [
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: Text("Add"),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      taskProvider.addTask(_controller.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Task Added Successfully")),
                      );
                      _controller.clear();
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
