import 'package:flutter/material.dart';
import 'package:xtreem_task/provider.dart';
import 'package:xtreem_task/task.dart';
import 'package:xtreem_task/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskProvider()..loadTasks(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeScreen(),
    );
  }
}