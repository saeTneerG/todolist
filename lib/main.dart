import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/task_viewer/views/task_page.dart';
import 'login_view/login_view.dart';
import 'login_view/register_view.dart';
import 'view_models/app_view_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) =>AppViewModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}